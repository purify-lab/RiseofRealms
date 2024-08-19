// SPDX-License-Identifier: MIT
pragma solidity >=0.8.24;

/* Autogenerated file. Do not edit manually. */

import { TokenType } from "../Common.sol";

/**
 * @title ISpawnSystem
 * @author MUD (https://mud.dev) by Lattice (https://lattice.xyz)
 * @dev This interface is automatically generated from the corresponding system contract. Do not edit manually.
 */
interface ISpawnSystem {
  function app__spawnPlayer() external;

  function app__buyInfantry(uint256 amount) external;

  function app__buyInfantryByToken(TokenType token_type, uint256 amount) external;

  function app__buyCavalryA(uint256 amount) external;

  function app__buyCavalryB(uint256 amount) external;

  function app__buyCavalryC(uint256 amount) external;

  function app__spawnCapital(uint16 capital_id) external payable;

  function app__garrison(
    uint16 capital_id,
    uint256 infantry,
    uint256 cavalryA,
    uint256 cavalryB,
    uint256 cavalryC
  ) external;

  function app__march(
    uint16 destination,
    uint256 infantry,
    uint256 cavalryA,
    uint256 cavalryB,
    uint256 cavalryC,
    uint8 army_id
  ) external;

  function app__attack(uint8 army_id) external;

  function app__farming(uint16 capital_id) external;

  function app__getStageOneEndTime() external pure returns (uint256 timestamp);

  function app__stakeTokenB(uint256 amount) external;

  function app__stakeTokenC(uint256 amount) external;

  function app__unStakeTokenB(address staker, uint256 amount) external;

  function app__setUnStakeFee(uint256 fee) external;

  function app__setPassiveUnStakeFee(uint256 fee) external;

  function app__setOwner() external;
}
