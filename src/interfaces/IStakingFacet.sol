// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/token/ERC721/IERC721.sol";
import "@openzeppelin/contracts/token/ERC1155/IERC1155.sol";
import "../interfaces/IStakingFacet.sol";  // Keep this import
import "../libraries/LibStaking.sol";

// Interface defining core staking methods
interface IStakingFacet {
    // Stake tokens of various types
    function stake(address token, uint256 amount) external;
    
    // Unstake tokens
    function unstake(address token, uint256 amount) external;
    
    // Claim accumulated rewards
    function claimRewards() external;
    
    // Get user's staked balance for a specific token
    function getStakedBalance(address user, address token) external view returns (uint256);
}