// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.8.2 <0.9.0;

contract immutableContract {
    // 编译后不可修改想读只能使用pure constant
    string constant name = "Biden";
    // 部署合约后不能再修改，需要在构造函数里初始化
    uint immutable age;
    constructor () {
        age = 80;
    }
    function getName() public pure returns (string memory) {
        return name;
    }
    function getAge() public view returns (uint) {
        return age;
    }
}