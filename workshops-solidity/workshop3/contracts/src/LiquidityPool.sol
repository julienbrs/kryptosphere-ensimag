// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import {ILiquidityPool} from "./interfaces/ILiquidityPool.sol";
import {IERC20} from "./interfaces/IERC20.sol";
import {console} from "forge-std/console.sol";

contract LiquidityPool is ILiquidityPool {
    address tokenA;
    address tokenB;

    uint256 public aLiquidity;
    uint256 public bLiquidity;

    string public name;
    string public symbol;

    error InvalidToken();
    error SlippageTooHigh();
    error InsuffisantLiquidity();

    constructor(
        string memory _name,
        string memory _symbol,
        address _tokenA,
        address _tokenB
    ) {
        tokenA = _tokenA;
        tokenB = _tokenB;

        name = _name;
        symbol = _symbol;
    }

    function getTokenA() external view returns (address) {
        return tokenA;
    }

    function getTokenB() external view returns (address) {
        return tokenB;
    }

    function addLiquidity(address _token, uint256 _amount) external {}

    function getLiquidity(address _token) external view returns (uint256) {
        return 0;
    }

    function rate(
        address _token,
        uint256 _amount
    ) external view returns (uint256, uint256) {
        return (0, 0);
    }

    function swap(
        address _fromToken,
        uint256 _amountIn,
        uint256 _slippageTolerance
    ) external returns (uint256) {
        return 0;
    }
}
