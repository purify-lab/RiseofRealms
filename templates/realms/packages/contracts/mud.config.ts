import {defineWorld} from "@latticexyz/world";

export default defineWorld({
  worldContractName: "RoR",
  // namespace: "mud",
  enums: {
    TokenType: ["TokenA", "TokenB", "TokenC"],
  },
  systems: {
    SpawnSystem: {
      name: "spwan",
      openAccess: true,
    },
  },
  tables: {
    Player: "bool",
    PlayerDetail: {
      schema: {
        id: "bytes32",
        wallet: "address",
        gold: "uint256",
        infantry: "uint256",
        cavalryA: "uint256",
        cavalryB: "uint256",
        cavalryC: "uint256",
        capitals: "uint16",
      },
      key: ['id']
    },
    Army: {
      key: ["key"],
      schema: {
        key: "bytes32",
        owner: "bytes32",
        id: "uint8",
        infantry: "uint256",
        cavalryA: "uint256",
        cavalryB: "uint256",
        cavalryC: "uint256",
        lastTime: "uint32",
        destination: "uint16",
      }
    },
    Capital: {
      key: ["id"],
      schema: {
        id: "uint16",
        tileId: "uint16",
        owner: "bytes32",
        occupation: "address",
        infantry: "uint256",
        cavalryA: "uint256",
        cavalryB: "uint256",
        cavalryC: "uint256",
        lastTime: "uint32",
        pledgedTokenB: "uint256",
        pledgedTokenC: "uint256",
      }
    },
    BattleReport: {
      key: ["key"],
      schema: {
        key: "bytes32",
        capitalId: "uint16",
        timestamp: "uint32",
        attacker: "address",
        defender: "address",
        attackWin: "bool",
        losses: "uint256[8]"
      }
    },
    GlobalStatistics: {
      schema: {
        consumptionTokenB: "uint256",
        consumptionTokenC: "uint256",
      },
      key: [],
    },
    GlobalStake: {
      schema: {
        stakeTokenB: "uint256",
        stakeTokenC: "uint256",
        lastStakeTime: "uint256",
        valueB: "uint256",
        valueC: "uint256"
      },
      key: [],
    },
    GlobalConfig: {
      schema: {
        unStakeFee: "uint256",
        passiveUnStakeFee: "uint256",
        owner: "address",
        merkleRoot: "bytes32",
      },
      key: [],

    },
    PlayerStake: {
      schema: {
        wallet: "address",
        tokenB: "uint256",
        tokenC: "uint256"
      },
      key: ['wallet']
    },
    PlayerAirdrop: {
      schema: {
        wallet: "address",
        isClaimed: "bool"
      },
      key: ['wallet']
    }
    // PlayerStatistics:{
    //   schema: {
    //     id: "bytes32",
    //
    //   },
    //   key: ['id']
    // }
  },
  deploysDirectory: "./mud-deploys",
});