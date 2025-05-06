// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.8.2 <0.9.0;

contract Receiver {
    event Received(address caller, uint amount, string message);
    // 成功无值
    receive() external payable {
        emit Received(msg.sender, msg.value, "Receive was called");
    }
    // 失败 比如下面传abc
    fallback() external payable { 
        emit Received(msg.sender, msg.value, "Fallback was called");
    }

    function foo(string memory _message, uint _y) public payable returns (uint) {
        emit Received(msg.sender, msg.value, _message);
        return _y;
    }

    function getAddress() public view returns (address) {
        return address(this);
    }
    function getBalance() public view returns (uint) {
        return address(this).balance;
    }
}

contract Caller {
    Receiver receiver;
    constructor() {
        receiver = new Receiver();
    }
    event Response(bool success, bytes data);

    function testCall(address payable _addr, uint _y) public payable {
        // 没有abc 走 receive 否则走failback abc 可以替换为函数
        // (bool success, bytes memory data) = _addr.call{value: msg.value}("abc");
        (bool success, bytes memory data) = _addr.call{value: msg.value}(
            abi.encodeWithSignature("foo(string,uint256)", "call foo", _y)
        );
        emit Response(success,data);
    }
    function getAddress() public view returns(address) {
        return receiver.getAddress();
    }
    function getBalance() public view returns (uint) {
        return receiver.getBalance();
    }
}