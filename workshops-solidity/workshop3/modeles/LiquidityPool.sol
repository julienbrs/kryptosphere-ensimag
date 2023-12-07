// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/token/ERC20/ERC20.sol";

contract LiquidityPool {

  ERC20 public eth;
  ERC20 public dai;

  constructor(ERC20 _ethAddress, ERC20 _daiAddress) {
    eth = _ethAddress;
    dai = _daiAddress;
  }

  function deposit(ERC20 token, uint256 amount) public {
  }

  function withdraw(ERC20 token, uint256 amount) public {
  }

  function getEthToDaiPrice() public view returns (uint256) {
  }

  function exchange(ERC20 fromToken, uint256 fromAmount, ERC20 toToken) public {
  }
}