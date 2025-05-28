// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.8.2 <0.9.0;

contract ETHWallect {

    address payable public owner;

    receive() external payable {
        owner = payable(msg.sender);
    }

    function getBalance() external view returns(uint) {
        return address(this).balance;
    }

    function withdraw(uint _amount) external {
        // bool sent = payable(msg.sender).send(_amount);
        // require(sent, "send fail");

        // payable(msg.sender).transfer(_amount);

        require(msg.sender == owner, "Not owner");

        (bool sent,) = payable(msg.sender).call{value: _amount}("");
        require(sent, "sent fail");
    }
}