// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.8.2 <0.9.0;

contract logic {
    uint private number;

    function setNum(uint _number) public {
        number = _number + 2;
    }

    function getNum() public view returns(uint) {
        return number;
    }
}