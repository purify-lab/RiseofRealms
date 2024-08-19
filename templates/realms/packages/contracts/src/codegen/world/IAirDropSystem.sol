// SPDX-License-Identifier: MIT
pragma solidity >=0.8.24;

/* Autogenerated file. Do not edit manually. */

/**
 * @title IAirDropSystem
 * @author MUD (https://mud.dev) by Lattice (https://lattice.xyz)
 * @dev This interface is automatically generated from the corresponding system contract. Do not edit manually.
 */
interface IAirDropSystem {
  function app__claim(bytes32[] memory proof, uint256 amount) external;

  function app__setMerkleRoot(bytes32 _merkleRoot) external;
}
