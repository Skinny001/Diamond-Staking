// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

// Mock token for testing purposes
contract MockToken is ERC20 {
    constructor(string memory name, string memory symbol) ERC20(name, symbol) {
        // Mint initial supply to contract deployer
        _mint(msg.sender, 1_000_000 * 10**18);
    }

    // Helper function to mint tokens during testing
    function mint(address to, uint256 amount) external {
        _mint(to, amount);
    }
}