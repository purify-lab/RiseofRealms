import {defineWorld} from "@latticexyz/world";

export default defineWorld({
  worldContractName: "RoR",
  enums: {
    TokenType: ["TokenA", "TokenB", "TokenC"],
  },
  systems: {
    SpawnSystem: {
      name: "spwan",
      openAccess: true,
    },
    TokenManagerSystem: {
      name: "tokenManager",
      openAccess: false,
    }
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
        lands: "uint16",
        isSpawnCapital: "bool"
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
        lastTime: "uint32",
      }
    },
    Land: {
      key: ["id"],
      schema: {
        id: "uint16",
        tileId: "uint16",
        owner: "bytes32",
        infantry: "uint256",
        cavalryA: "uint256",
        cavalryB: "uint256",
        cavalryC: "uint256",
        lastTime: "uint32",
        attackAble: "bool"
      }
    },
    BattleReport: {
      key: ["key"],
      schema: {
        key: "bytes32",
        landId: "uint16",
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
        tokenB: "uint256",
        tokenC: "uint256",
        lastStakeTime: "uint256",
        isPositive: "bool",
        mintB: "uint256",
        burnB: "uint256",
        netValue: "uint256",
        burnRate: "uint256",
        perSecondReward: "uint256"
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
        tokenC: "uint256",
        lastRewardTimeB: "uint256",
        lastRewardTimeC: "uint256",
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