// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.8.2 <0.9.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

// 提供一种简单的访问控制机制，允许只有合约的所有者才能调用特定函数
import "@openzeppelin/contracts/access/Ownable.sol";

contract HYChain is ERC20, Ownable(msg.sender) {
    bool public isLocked = false;
    uint public timeLock = block.timestamp + 1 minutes;

    constructor() ERC20("HYChain","HYC") {
        _mint(msg.sender, 100000 * 10 ** decimals());
    }

    function transfer(address _to, uint256 amount) public  override  returns(bool) {
        // require(isLocked == false, "transfer was locked");
        require(block.timestamp > timeLock, "It's not time yet");
        return super.transfer(_to, amount);
    }

    function setLock() public onlyOwner returns(bool) {
        isLocked = true;
        return true;
    }
}