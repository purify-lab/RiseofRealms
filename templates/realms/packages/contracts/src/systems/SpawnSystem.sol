// SPDX-License-Identifier: MIT
pragma solidity >=0.8.0;

import {System} from "@latticexyz/world/src/System.sol";
import {IWorld} from "../codegen/world/IWorld.sol";
import {Player, Position, Toad, GameManager, PlayerDetail, Capital} from "../codegen/index.sol";

import {getUniqueEntity} from "@latticexyz/world-modules/src/modules/uniqueentity/getUniqueEntity.sol";
import {Utility} from "../utility/utility.sol";
import {IERC20} from "../utility/IERC20.sol";


contract SpawnSystem is System {
    function spawnPlayer() public {
        bytes32 entity = Utility.addressToEntityKey(address(_msgSender()));
        require(Player.get(entity) == false, "Already spawned");

        Player.set(entity, true);
        uint32 gold = 1000000000;
        uint32 soldier = 2000000000;
//        bytes32[] memory cites = new bytes32[](0);
        PlayerDetail.set(entity, gold, soldier, 0);
    }

    function buySoldier() public {
        bytes32 entity = Utility.addressToEntityKey(address(_msgSender()));
        PlayerDetail.setGold(entity, PlayerDetail.getGold(entity) - 1);
        PlayerDetail.setSoldier(entity, PlayerDetail.getSoldier(entity) + 1);
    }

    function spawnCapital(uint16 capital_id) public payable {
        //price 0.0005 eth
        require(msg.value == 500000000000000, "No eth");
        bytes32 owner = Utility.addressToEntityKey(address(_msgSender()));
        require(Capital.getOwner(capital_id) == 0, "this capital already spawned");
        require(PlayerDetail.getCapital(owner) == 0, "you already spawned capital");

//        Capital.set(id, owner, 0, block.timestamp);
        PlayerDetail.setCapital(owner, capital_id);
        Capital.setOwner(capital_id, owner);
        Capital.setLastTime(capital_id, block.timestamp);
    }

    function spawnToad(int32 x, int32 y, int32 z) public payable {
//        bytes32 [] memory keys = Utility.getKeysAtPosition(IWorld(_world()), x, y, z);
//        require(keys.length == 0, "Obstruction");
        require(msg.value == 100000000000000, "No eth");

//        bytes32 toad = getUniqueEntity();
//        uint32 tadpoles = GameManager.get();
//
//        Position.set(toad, x, y, z);
//        Toad.set(toad, true);
//        GameManager.set(tadpoles + 1);
    }

    function spawnToad2(int32 x, int32 y, int32 z) public {
        bytes32 [] memory keys = Utility.getKeysAtPosition(IWorld(_world()), x, y, z);
        require(keys.length == 0, "Obstruction");

        bytes32 toad = getUniqueEntity();
        uint32 tadpoles = GameManager.get();

        Position.set(toad, x, y, z);
        Toad.set(toad, true);
        GameManager.set(tadpoles + 1);
    }

    function spawnToad3(int32 x, int32 y, int32 z) public {
        bytes32 [] memory keys = Utility.getKeysAtPosition(IWorld(_world()), x, y, z);
        require(keys.length == 0, "Obstruction");

        IERC20 token = IERC20(0x4200000000000000000000000000000000000006);
        token.transferFrom(msg.sender, address(this), 100);

        bytes32 toad = getUniqueEntity();
        uint32 tadpoles = GameManager.get();

        Position.set(toad, x, y, z);
        Toad.set(toad, true);
        GameManager.set(tadpoles + 1);
    }

    function deleteToad(int32 x, int32 y, int32 z) public {
        bytes32 [] memory keys = Utility.getKeysAtPosition(IWorld(_world()), x, y, z);
        require(keys.length > 0, "No toad");

        bytes32 toad = keys[0];
        uint32 tadpoles = GameManager.get();

        Position.deleteRecord(toad);
        Toad.deleteRecord(toad);
        GameManager.set(tadpoles - 1);
    }
}
