// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Counter {
    uint256 private count = 0;

    constructor (uint256 __initial_value) {
        count = __initial_value;
    }

    function getCount() external view returns (uint256) {
        return count;
    }

    function increment() external {
        count++;
    }

    function decrement() external {
        count--;
    }
}
