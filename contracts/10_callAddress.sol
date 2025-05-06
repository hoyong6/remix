// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.8.2 <0.9.0;

contract callAddress {
    function calls(address payable _to) public payable {
        (bool is_send,) = _to.call{value: msg.value, gas: 5000}("");
        require(is_send, 'Send Fail');
    }
}