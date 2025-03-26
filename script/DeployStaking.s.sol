// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "forge-std/Script.sol";
import "../src/facets/StakingFacet.sol";
import "../src/tokens/MockToken.sol";

contract DeployStaking is Script {
    function run() external {
        vm.startBroadcast();
        
        // Deploy mock tokens
        MockToken stakingToken = new MockToken("StakingToken", "STK");
        MockToken rewardToken = new MockToken("RewardToken", "RWD");
        
        // Deploy staking contract and pass token addresses (if required)
        StakingFacet stakingFacet = new StakingFacet();
        
        // Ensure stakingFacet has the tokens it will use
        stakingToken.approve(address(stakingFacet), type(uint256).max);
        rewardToken.approve(address(stakingFacet), type(uint256).max);

        vm.stopBroadcast();
    }
}
