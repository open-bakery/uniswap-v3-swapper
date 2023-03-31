// SPDX-License-Identifier: UNLICENSED
pragma solidity >=0.5.0 <0.8.14;
pragma abicoder v2;

import 'forge-std/Test.sol';
import '../src/Swapper.sol';

contract SwapperTest is Test {
  Swapper public swapper;
  address usdc = vm.envAddress('USDC');
  address weth = vm.envAddress('WETH');
  uint24 fee = uint24(vm.envUint('FEE'));
  uint256 initialBalanceWETH;
  uint256 initialBalanceUSDC;

  function setUp() public {
    initialBalanceWETH = 100_000 ether;
    initialBalanceUSDC = 100_000_000_000000;
    deal(usdc, address(this), initialBalanceUSDC);
    deal(weth, address(this), initialBalanceWETH);
    swapper = new Swapper(vm.envAddress('UNISWAP_V3_FACTORY'), vm.envAddress('UNISWAP_V3_ROUTER'));
    ERC20(usdc).approve(address(swapper), type(uint256).max);
    ERC20(weth).approve(address(swapper), type(uint256).max);
  }

  function testSwap() public {
    uint256 amount = 10_000_000_000000;

    Swapper.SwapParameters memory params = Swapper.SwapParameters({
      recipient: address(this),
      tokenIn: usdc,
      tokenOut: weth,
      fee: fee,
      amountIn: amount,
      slippage: 100,
      oracleSeconds: 60
    });
    uint256 amountOut = swapper.swap(params);
    assertEq(ERC20(usdc).balanceOf(address(swapper)), 0, 'Check swapper balance usdc');
    assertEq(ERC20(weth).balanceOf(address(swapper)), 0, 'Check swapper balance weth');
    assertEq(ERC20(usdc).balanceOf(address(this)), initialBalanceUSDC - amount, 'Check  balance usdc');

    assertEq(ERC20(weth).balanceOf(address(this)), initialBalanceWETH + amountOut, 'Check  balance weth');

    assertTrue(amountOut != 0, 'Check  amount out');
    console.log('Amount out: ', amountOut);
  }
}
