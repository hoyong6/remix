// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.8.2 <0.9.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract hyChainToken is ERC20 {
    constructor() ERC20("hyChainToken", "HYC") {
        _mint(msg.sender, 1000 * 10 ** decimals());
    }
}