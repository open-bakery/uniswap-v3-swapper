// SPDX-License-Identifier: GPL-2.0-or-later
pragma solidity >=0.5.0 <0.8.0;
pragma abicoder v2;

import { console } from 'forge-std/console.sol';
import { Script } from 'forge-std/Script.sol';
import { Swapper } from '../src/Swapper.sol';
import { Strings } from '@openzeppelin/contracts/utils/Strings.sol';

contract SwapperScript is Script {
  uint256 DEPLOYER_PRIVATE_KEY = vm.envUint('DEPLOYER_PRIVATE_KEY');
  uint8 private constant _ADDRESS_LENGTH = 20;

  function setUp() public {}

  function run() public {
    vm.broadcast(DEPLOYER_PRIVATE_KEY);
    Swapper swapper = new Swapper(vm.envAddress('UNISWAP_V3_FACTORY'), vm.envAddress('UNISWAP_V3_ROUTER'));
    console.logAddress(address(swapper));
  }
}
