pragma solidity ^0.7.0;

contract Staking {
    address public owner;
    mapping(address => uint) public stakes;

    constructor() public {
        owner = msg.sender;
    }

    function stake(uint amount) public { // allows users to send to contract and add to their stake
        require(amount > 0, "You must stake a positive amount");
        require(msg.value == amount, "You must send the exact amount you are staking");
        stakes[msg.sender] += amount;
    }

    function unstake(uint amount) public { // allows users to unstake and send back to their address
        require(amount > 0, "You must unstake a positive amount");
        require(stakes[msg.sender] >= amount, "You do not have enough stake to unstake this amount");
        stakes[msg.sender] -= amount;
        msg.sender.transfer(amount);
    }

    function claimOwnership() public { //allow the owner to claim ownership
        require(msg.sender == owner, "Only the owner can claim ownership");
        owner = msg.sender;
    }
}
