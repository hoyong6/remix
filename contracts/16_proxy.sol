// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.8.2 <0.9.0;

interface ILogic {
    function setNum(uint _number) external;
    function getNum() external view returns (uint);
}

contract Proxy {
    ILogic public logic;
    function setLogicAddress(address _logicAddress) public {
        logic = ILogic(_logicAddress);
    }

    function getLogicAddress() public view returns(address) {
        return address(logic);
    }

    function setNum(uint _number) public {
        logic.setNum(_number);
    }

    function getNum() public view returns(uint) {
        return logic.getNum();
    }
}