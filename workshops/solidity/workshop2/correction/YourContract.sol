// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract YourContract {
    uint256 private secretValue;

    function setValue(uint256 _newValue) public {
        secretValue = _newValue;
    }
}
