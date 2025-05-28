// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.8.4 <0.9.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/ERC20FlashMint.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "https://github.com/NomicFoundation/hardhat/blob/master/packages/hardhat-core/console.sol";

contract leader is ERC20, Ownable, ERC20FlashMint {
    bytes32 private constant _RETURN_VALUE = keccak256("ERC3156FlashBorrower.onFlashLoan");
    constructor() Ownable(msg.sender) ERC20("Lender", "LND") {}
    function flashLoan (
        IERC3156FlashBorrower receiver,
        address token,
        uint256 amount,
        bytes calldata data
    ) public virtual override returns (bool) {
        require(amount <= maxFlashLoan(token), "ERC20FlashMint: amount exceeds maxFlashLoan");
        uint256 fee = flashFee(token, amount);
        _mint(address(receiver), amount);
        require(receiver.onFlashLoan(address(receiver), token, amount, fee, data) == _RETURN_VALUE, "ERC20FlashMint: invalid return value");
        uint256 currentAllowance = allowance(address(this), address(receiver));
        require(currentAllowance >= amount + fee, "ERC20FlashMint: allowance does not allow refud");
        _approve(address(this), address(receiver), currentAllowance - amount - fee);
        return true;
    }

    function approveLoanAmount(address receiver, uint256 amount) public virtual onlyOwner {
        _approve(address(this), receiver, amount);
    }
}

contract Borrower is IERC3156FlashBorrower {
    enum Action {NORMAL, OTHER}
    IERC3156FlashLender lender;
    constructor(address _lendAddress) {
        lender = IERC3156FlashLender(_lendAddress);
    }
    function onFlashLoan(
        address initiator,
        address token,
        uint256 amount,
        uint256 fee,
        bytes calldata data
    )external view override returns(bytes32) {
        require(
            msg.sender == address(lender),
            "FlashBorrower: Untrusted lender"
        );
        require(
            initiator == address(this),
            "FlashBorrower: Untrusted loan initiator"
        );
        (Action action) = abi.decode(data, (Action));
        console.log("action");
        if(action == Action.NORMAL) {
            // doing some
            console.log("Action.NORMAL");
        } else if (action == Action.OTHER) {
            console.log("Action.OTHER");
        }

        // 前置验证函数
        return keccak256("ERC3156FlashBorrower.onFlashLoan");
    }

    // dev Initiate a flash loa
    function flashBorrow(
        address token,
        uint256 amount
    ) public {
        bytes memory data = abi.encode(Action.NORMAL);
        uint256 _allownce = IERC20(token).allowance(address(lender), address(this));
        console.log("_allownce", _allownce);
        uint256 _fee = lender.flashFee(token,amount);

        uint256 _repayment = _allownce + _fee;

        console.log("_repayment", _repayment);
        lender.flashLoan(this, token, amount, data);
    }

    function encodeNORMAL() public pure returns(bytes memory message){
        return abi.encode(Action.NORMAL);
    }
}