// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.8.2 <0.9.0;

contract exampleModifier {
    address public owner;
    uint256 public account;
    constructor() {
        owner = msg.sender;
        account = 0;
    }
    modifier isOwner() {
        require (msg.sender == owner, "Not the owner");
        _;
    }
    modifier valid100(uint256 _account){
        require (_account > 100, "valiad 100");
        _;
    }
    function update_account (uint256 _account) public isOwner valid100(_account){
        account = _account;
    }
}