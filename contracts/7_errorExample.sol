// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.8.2 <0.9.0;

error Unauthorized(string error, address _address);

contract errorExample {
    address payable owner = payable(msg.sender);
    function withraw() public {
        if(msg.sender != owner) {
            revert Unauthorized({error:"Unauthorized", _address: msg.sender});
        }
        owner.transfer(address(this).balance);
    }
}