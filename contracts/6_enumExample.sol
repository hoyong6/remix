// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.8.2 <0.9.0;

contract enumExample {
    enum Status { OFF, ON }
    Status status;
    function getStatus() view external returns (Status) {
        return status;
    }
    function setStatus(Status _status) external {
        status = _status;
    }
    function setStatus2() external  {
        status = Status.ON;
    }
    function reset() external  {
        delete status;
    }
    function getKeyByValue(Status _status) pure external returns ( string memory) {
        if(Status.OFF == _status) return "OFF";
        if(Status.ON == _status) return "ON";
        return "";
    }
    function getValueBykey(string memory _status) pure external returns (Status) {
        if(keccak256(bytes("OFF")) == keccak256( bytes(_status))) return Status.OFF;
        if(keccak256(bytes("ON")) == keccak256( bytes(_status))) return Status.ON;
        revert();
    }
}