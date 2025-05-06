// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.8.2 <0.9.0;

contract exampleEvent {
    event Deposit(address _from, string _name, uint256 _value);

    function deposit(string memory _name) public  payable {
        emit Deposit(msg.sender, _name, msg.value);
    }
}