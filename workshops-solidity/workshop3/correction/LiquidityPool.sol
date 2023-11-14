pragma solidity ^0.6.12

import "https://github.com/OpenZeppelin/openzeppelin-solidity/contracts/math/SafeMath.sol";
import "https://github.com/OpenZeppelin/openzeppelin-solidity/contracts/token/ERC20/SafeERC20.sol";

contract LiquidityPool {
  using SafeMath for uint256;
  using SafeERC20 for ERC20;

  ERC20 public eth;
  ERC20 public dai;

  constructor(ERC20 _eth, ERC20 _dai) public {
    eth = _eth;
    dai = _dai;
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
    return daiBalance.mul(1 ether).div(ethBalance);
  }

  function exchange(ERC20 fromToken, uint256 fromAmount, ERC20 toToken) public {
    require(fromToken == eth || fromToken == dai, "Invalid fromToken.");
    require(toToken == eth || toToken == dai, "Invalid toToken.");

    uint256 fromTokenBalance = fromToken.balanceOf(address(this));
    uint256 toTokenBalance = toToken.balanceOf(address(this));
    require(fromTokenBalance >= fromAmount, "Insufficient balance.");

    uint256 exchangeRate = getEthToDaiPrice();
    uint256 toAmount;
    if (fromToken == eth) {
      toAmount = fromAmount.mul(exchangeRate).div(1 ether);
    } else {
      toAmount = fromAmount.mul(1 ether).div(exchangeRate);
    }

    fromToken.safeTransferFrom(msg.sender, address(this), fromAmount);
    toToken.safeTransfer(msg.sender, toAmount);
  }
}

;