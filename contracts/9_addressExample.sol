// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.8.2 <0.9.0;

contract addressExample {

    address ownerAddress;

    constructor() {
        ownerAddress = msg.sender;
    }
    
    // 合约地址
    function getContractAddress() external view returns (address) {
        return address(this);
    }
    // 交互地址
    function getSenderAddress() external view returns (address) {
        return msg.sender;
    }
    // 拥有者地址
    function getOwnerAddress() external view returns (address) {
        return ownerAddress;
    }
    // 获取地址余额
    function getBalance() external view returns (uint, uint, uint){
        uint contractBalance = address(this).balance;
        uint senderBalance = msg.sender.balance;
        uint ownerBalance = ownerAddress.balance;
        return (contractBalance, senderBalance, ownerBalance);
    }
}