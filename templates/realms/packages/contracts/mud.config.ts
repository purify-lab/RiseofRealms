// import {mudConfig} from "@latticexyz/world/register";

// export default mudConfig({
//   systems: {},
//   tables: {
//     Player: "bool",
//     PlayerDetail: {
//       name: "PlayerDetail",
//       valueSchema: {
//         wallet: "address",
//         gold: "uint256",
//         infantry: "uint256",
//         cavalryA: "uint256",
//         cavalryB: "uint256",
//         cavalryC: "uint256",
//         capital: "uint16",
//       }
//     },
//     Cite: {
//       valueSchema: {
//         owner: "bytes32"
//       }
//     },
//     Army: {
//       keySchema: {
//         owner: "bytes32",
//         id: "uint8"
//       },
//       valueSchema: {
//         infantry: "uint256",
//         cavalryA: "uint256",
//         cavalryB: "uint256",
//         cavalryC: "uint256",
//         lastTime: "uint256",
//         destination: "uint16",
//       }
//     },
//     Capital: {
//       keySchema: {
//         id: "uint16"
//       },
//       valueSchema: {
//         owner: "bytes32",
//         occupation: "address",
//         infantry: "uint256",
//         cavalryA: "uint256",
//         cavalryB: "uint256",
//         cavalryC: "uint256",
//         lastTime: "uint256",
//         pledgedTokenB: "uint256",
//         pledgedTokenC: "uint256",
//       }
//     },
//     CapitalExtends: {
//       keySchema: {
//         id: "uint16"
//       },
//       valueSchema: {
//         owner: "bytes32",
//       }
//     },
//     BattleReport: {
//       keySchema: {
//         capitalId: "uint16",
//         timestamp: "uint256"
//       },
//       valueSchema: {
//         attacker: "address",
//         defender: "address",
//         lossInfantry: "uint256",
//       }
//     },
//     Toad: "bool",
//     Position: {
//       name: "Position",
//       valueSchema: {
//         x: "int32",
//         y: "int32",
//         z: "int32",
//       }
//     },
//     GameManager: {
//       keySchema: {},
//       valueSchema: {
//         tadpoles: "uint32",
//       },
//     },
//
//   },
//
//   // modules: [
//   //
//   //   {
//   //     name: "UniqueEntityModule",
//   //     root: true,
//   //   },
//   //   // {
//   //     // name: "KeysWithValueModule",
//   //     // root: true,
//   //     // args: [resolveTableId("Position")],
//   //   // },
//   // ],
//   // deploysDirectory: "./mud-deploys",
//
// });

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
    // Counter: {
    //   schema: {
    //     value: "uint32",
    //   },
    //   key: [],
    // },
    // Tasks: {
    //   schema: {
    //     id: "bytes32",
    //     createdAt: "uint256",
    //     completedAt: "uint256",
    //     description: "string",
    //   },
    //   key: ["id"],
    // },

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
        capital: "uint16",
      },
      key: ['id']
    },
    Army: {
      key: ["owner", "id"],
      schema: {
        owner: "bytes32",
        id: "uint8",
        infantry: "uint256",
        cavalryA: "uint256",
        cavalryB: "uint256",
        cavalryC: "uint256",
        lastTime: "uint256",
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
        lastTime: "uint256",
        pledgedTokenB: "uint256",
        pledgedTokenC: "uint256",
      }
    },
    // CapitalExtends: {
    //   key: {
    //     id: "uint16"
    //   },
    //   valueSchema: {
    //     owner: "bytes32",
    //   }
    // },
    BattleReport: {
      // key: {
      //   capitalId: "uint16",
      //   timestamp: "uint256"
      // },
      key: ["capitalId", "timestamp"],
      schema: {
        capitalId: "uint16",
        timestamp: "uint256",
        attacker: "address",
        defender: "address",
        win: "bool",
        attackOrDefence: "bool",
        lossInfantry: "uint256",
      }
    },
  },
  deploysDirectory: "./mud-deploys",
});