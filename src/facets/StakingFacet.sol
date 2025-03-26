// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/token/ERC721/IERC721.sol";
import "@openzeppelin/contracts/token/ERC1155/IERC1155.sol";
import "../libraries/LibStaking.sol";
import "../interfaces/IStakingFacet.sol";

contract StakingFacet is IStakingFacet {
   using LibStaking for *;

    // Stake tokens (multi-token support)
    function stake(address token, uint256 amount) external {
        LibStaking.StakingStorage storage ds = LibStaking.diamondStorage();
        
        // Validate stake amount
        require(amount > 0, "Stake amount must be positive");
        
        // Transfer tokens from user to contract
        IERC20(token).transferFrom(msg.sender, address(this), amount);
        
        // Update staked balance
        ds.stakedBalances[msg.sender][token] += amount;
        ds.totalStaked += amount;
        
        // Update reward calculations
        _updateReward(msg.sender);
    }

    // Unstake tokens
    function unstake(address token, uint256 amount) external {
        LibStaking.StakingStorage storage ds = LibStaking.diamondStorage();
        
        // Validate unstake conditions
        require(ds.stakedBalances[msg.sender][token] >= amount, "Insufficient staked balance");
        
        // Update balances
        ds.stakedBalances[msg.sender][token] -= amount;
        ds.totalStaked -= amount;
        
        // Transfer tokens back to user
        IERC20(token).transfer(msg.sender, amount);
        
        // Update rewards
        _updateReward(msg.sender);
    }

    // Claim accumulated rewards
    function claimRewards() external {
        LibStaking.StakingStorage storage ds = LibStaking.diamondStorage();
        
        // Calculate and transfer rewards
        uint256 reward = _calculateReward(msg.sender);
        require(reward > 0, "No rewards to claim");
        
        // Transfer reward tokens
        IERC20(ds.rewardToken).transfer(msg.sender, reward);
        
        // Reset user rewards
        ds.rewards[msg.sender] = 0;
        
        _updateReward(msg.sender);
    }

    // Get user's staked balance
    function getStakedBalance(address user, address token) external view returns (uint256) {
        LibStaking.StakingStorage storage ds = LibStaking.diamondStorage();
        return ds.stakedBalances[user][token];
    }

    // Internal reward calculation
    function _calculateReward(address user) internal view returns (uint256) {
        LibStaking.StakingStorage storage ds = LibStaking.diamondStorage();
        
        // Basic reward calculation with decay
        uint256 stakedAmount = ds.stakedBalances[user][ds.rewardToken];
        uint256 timeStaked = block.timestamp - ds.lastUpdateTime;
        
        // Apply APR with decay
        uint256 currentAPR = ds.baseAPR * (1 - (timeStaked * ds.decayRate / 365 days));
        
        return (stakedAmount * currentAPR * timeStaked) / (365 days * 100);
    }

   // Update reward tracking
function _updateReward(address user) internal {
    LibStaking.StakingStorage storage ds = LibStaking.diamondStorage();
    ds.lastUpdateTime = block.timestamp;

    // Silence unused variable warning
    user;
}

}
