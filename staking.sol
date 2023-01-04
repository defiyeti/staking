// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.0;

contract Staking {
    address public owner;
    mapping(address => uint) public stakes;

    constructor() {
        owner = msg.sender;
    }

    function stake(uint amount) public payable {
        require(amount > 0, "You must stake a positive amount");
        require(msg.value == amount, "You must send the exact amount you are staking");
        stakes[msg.sender] += amount;
    }

    function unstake(uint amount) public {
        require(amount > 0, "You must unstake a positive amount");
        require(stakes[msg.sender] >= amount, "You do not have enough stake to unstake this amount");
        stakes[msg.sender] -= amount;
        msg.sender.transfer(amount);
        payable(msg.sender).transfer(amount);
    }
}