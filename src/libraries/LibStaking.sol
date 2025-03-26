// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

library LibStaking {
    // Diamond storage structure for staking
    struct StakingStorage {
        mapping(address => mapping(address => uint256)) stakedBalances;
        uint256 totalStaked;
        address rewardToken;
        uint256 baseAPR;
        uint256 decayRate;
        uint256 lastUpdateTime;
        mapping(address => uint256) rewards;
    }

    // Get diamond storage slot
    function diamondStorage() internal pure returns (StakingStorage storage ds) {
        bytes32 position = keccak256("diamond.standard.staking.storage");
        assembly {
            ds.slot := position
        }
    }
}