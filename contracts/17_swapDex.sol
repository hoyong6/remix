// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.8.2 <0.9.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/utils/math/SafeMath.sol";

contract Dex {
    using SafeMath for uint;
    address public token1;
    address public token2;

    constructor(address _token1, address _token2) {
        token1 = _token1;
        token2 = _token2;
    }

    function swap(address from, address to, uint amount) public {
        require((from == token1 && to == token2) || (from == token2 && to == token1), "Invalid tokens");
        require(SwappableToken(from).balanceOf(msg.sender) >= amount,"Not enough tokens");
        uint swap_amount = get_swap_price(from, to, amount);
        SwappableToken(from).transferFrom(msg.sender, address(this), amount);
        SwappableToken(to).approve(address(this), swap_amount);
        SwappableToken(to).transferFrom(address(this), msg.sender,swap_amount);
    }

    function get_swap_price(address from, address to, uint amount) public view returns(uint) {
        return((amount * SwappableToken(to).balanceOf(address(this)))/SwappableToken(from).balanceOf(address(this)));
    }

    function add_liquidity(address token_address, uint amount) public {
        SwappableToken(token_address).transferFrom(msg.sender, address(this), amount);
    }

    function approve(address token, uint amount) public {
       SwappableToken(token).approve(address(this), amount);
    }
}

contract SwappableToken is ERC20 {
    constructor(string memory _name, string memory _symbol,uint _amount)ERC20(_name, _symbol){
        // 实现代币铸造功能
        _mint(msg.sender, _amount);
    }
}



