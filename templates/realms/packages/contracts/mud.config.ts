import {mudConfig, resolveTableId} from "@latticexyz/world/register";

export default mudConfig({

  systems: {},

  tables: {
    Player: "bool",
    PlayerDetail: {
      name: "PlayerDetail",
      valueSchema: {
        gold: "uint256",
        soldier: "uint256",
        cites:"bytes32[]"
      }
    },
    Toad: "bool",
    Position: {
      name: "Position",
      valueSchema: {
        x: "int32",
        y: "int32",
        z: "int32",
      }
    },
    GameManager: {
      keySchema: {},
      valueSchema: {
        tadpoles: "uint32",
      },
    },

  },

  modules: [

    {
      name: "UniqueEntityModule",
      root: true,
    },
    {
      name: "KeysWithValueModule",
      root: true,
      args: [resolveTableId("Position")],
    },
  ],

});
