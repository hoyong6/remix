// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.8.4 <0.9.0;

contract exampleModifier {
    address public owner;
    uint256 public amount;

    constructor() {
        owner = msg.sender;
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "Only owner");
        _;
    }

    function updateAmount(uint256 _amount) public onlyOwner {
        amount = _amount;
    }
}