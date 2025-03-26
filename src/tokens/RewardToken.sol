// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract RewardToken is ERC20, Ownable {
    uint256 public constant MAX_SUPPLY = 1_000_000 * 10**18; // 1 million tokens

    constructor(address initialOwner) ERC20("StakingReward", "STKRWD") Ownable(initialOwner) {
        // Mint initial supply to contract deployer
        _mint(initialOwner, MAX_SUPPLY);
    }

    // Mint additional tokens (only by owner)
    function mint(address to, uint256 amount) external onlyOwner {
        require(totalSupply() + amount <= MAX_SUPPLY, "Exceeds max supply");
        _mint(to, amount);
    }

    // Optional: burn mechanism
    function burn(uint256 amount) external {
        _burn(msg.sender, amount);
    }
}
