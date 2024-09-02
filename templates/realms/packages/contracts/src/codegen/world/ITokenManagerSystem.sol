// SPDX-License-Identifier: MIT
pragma solidity >=0.8.24;

/* Autogenerated file. Do not edit manually. */

/**
 * @title ITokenManagerSystem
 * @author MUD (https://mud.dev) by Lattice (https://lattice.xyz)
 * @dev This interface is automatically generated from the corresponding system contract. Do not edit manually.
 */
interface ITokenManagerSystem {
  function initAllowance() external;

  function getPairAmounts() external view returns (uint256, uint256, uint256);

  function getTokenAmounts() external view returns (uint256, uint256, uint256);

  function setNetValue(uint256 amount) external;

  function setBurnRate(uint256 amount) external;

  function setRewardPerSecondReward(uint256 amount) external;

  function setLastStakeTime(uint256 amount) external;

  function stakeTokenB(uint256 amount) external;

  function unstakeB(uint256 amount) external;

  function claimRewardB() external;

  function ultraMintTokenB(uint256 net_value, uint256 stake_reward) external;

  function ultraBurnTokenB(uint256 net_value, uint256 stake_reward) external;

  function passiveUnStake(bytes32 defender, bytes32 attacker) external;

  function getStakeLimit(address owner) external view returns (uint256 amount);
}
