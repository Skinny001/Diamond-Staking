// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "forge-std/Test.sol";
import "../src/facets/StakingFacet.sol";
import "../src/tokens/MockToken.sol";

contract StakingTest is Test {
    StakingFacet public stakingFacet;
    MockToken public stakingToken;
    MockToken public rewardToken;
    
    address public user = address(0x1);
    
    function setUp() public {
        // Deploy mock tokens
        stakingToken = new MockToken("Staking", "STK");
        rewardToken = new MockToken("Reward", "RWD");
        
        // Deploy staking contract
        stakingFacet = new StakingFacet();
        
        // Mint tokens to user
        stakingToken.mint(user, 1000 ether);
        rewardToken.mint(address(stakingFacet), 1_000_000 ether);
    }
    
    function testStaking() public {
        vm.startPrank(user);
        
        // Approve staking
        stakingToken.approve(address(stakingFacet), 100 ether);
        
        // Stake tokens
        stakingFacet.stake(address(stakingToken), 100 ether);
        
        // Check staked balance
        assertEq(stakingToken.balanceOf(address(stakingFacet)), 100 ether);
        vm.stopPrank();
    }
    
    function testUnstaking() public {
        vm.startPrank(user);
        
        // Approve and stake
        stakingToken.approve(address(stakingFacet), 100 ether);
        stakingFacet.stake(address(stakingToken), 100 ether);
        
        // Unstake
        stakingFacet.unstake(address(stakingToken), 50 ether);
        
        // Check balances
        assertEq(stakingToken.balanceOf(user), 950 ether);
        vm.stopPrank();
    }
}