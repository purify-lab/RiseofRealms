// SPDX-License-Identifier: MIT
pragma solidity >=0.8.24;

/* Autogenerated file. Do not edit manually. */

/**
 * @title IStableSwapSystem
 * @author MUD (https://mud.dev) by Lattice (https://lattice.xyz)
 * @dev This interface is automatically generated from the corresponding system contract. Do not edit manually.
 */
interface IStableSwapSystem {
  function app__swapA2B(uint256 amount) external;

  function app__swapA2C(uint256 amount) external;

  function app__pause() external;

  function app__unpause() external;

  function app__withdrawToken(address tokenAddress, uint256 amount) external;
}
