// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/token/ERC721/IERC721.sol";
import "@openzeppelin/contracts/token/ERC1155/IERC1155.sol";
import "../interfaces/IStakingFacet.sol"; 
import "../libraries/LibStaking.sol";

// Interface defining core staking methods
interface IStakingFacet {
    function stake(address token, uint256 amount) external;
    
    function unstake(address token, uint256 amount) external;
    
    function claimRewards() external;
    
    function getStakedBalance(address user, address token) external view returns (uint256);
}