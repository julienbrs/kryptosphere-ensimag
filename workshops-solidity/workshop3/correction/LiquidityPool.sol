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
    require(token.transferFrom(msg.sender, address(this), amount), "Transfer failed.");
  }

  function withdraw(ERC20 token, uint256 amount) public {
    token.transfer(msg.sender, amount);
  }

  function getEthToDaiPrice() public view returns (uint256) {
    uint256 ethBalance = eth.balanceOf(address(this));
    uint256 daiBalance = dai.balanceOf(address(this));
    return (daiBalance * (1 ether)) / ethBalance;
  }

  function exchange(ERC20 fromToken, uint256 fromAmount, ERC20 toToken) public {
    require(fromToken == eth || fromToken == dai, "Invalid fromToken.");
    require(toToken == eth || toToken == dai, "Invalid toToken.");

    uint256 fromTokenBalance = fromToken.balanceOf(address(this));
    // uint256 toTokenBalance = toToken.balanceOf(address(this));
    require(fromTokenBalance >= fromAmount, "Insufficient balance.");

    uint256 exchangeRate = getEthToDaiPrice();
    uint256 toAmount;
    if (fromToken == eth) {
        toAmount = fromAmount * exchangeRate / (1 ether);
    } else {
        toAmount = fromAmount * (1 ether) / (exchangeRate);
    }

    fromToken.transferFrom(msg.sender, address(this), fromAmount);
    toToken.transfer(msg.sender, toAmount);
  }
}