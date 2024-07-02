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

        PlayerDetail.setGold(entity, 1000000000);
        PlayerDetail.setInfantry(entity, 1000000000);
        PlayerDetail.setCavalry(entity, 1000000000);
    }

    function buyInfantry(uint256 amount) public {
        uint256 price = 50;
        bytes32 entity = Utility.addressToEntityKey(address(_msgSender()));
        PlayerDetail.setGold(entity, PlayerDetail.getGold(entity) - price * amount);
        PlayerDetail.setInfantry(entity, PlayerDetail.getInfantry(entity) + amount);
    }

    function buyCavalry(uint256 amount) public {
        uint256 price = 100;
        bytes32 entity = Utility.addressToEntityKey(address(_msgSender()));
        PlayerDetail.setGold(entity, PlayerDetail.getGold(entity) - price * amount);
        PlayerDetail.setCavalry(entity, PlayerDetail.getCavalry(entity) + amount);
    }

    function spawnCapital(uint16 capital_id) public payable {
        //price 0.0005 eth
        require(msg.value == 500000000000000, "No eth");
        bytes32 owner = Utility.addressToEntityKey(address(_msgSender()));
        require(Capital.getOwner(capital_id) == 0, "this capital already spawned");
        require(PlayerDetail.getCapital(owner) == 0, "you already spawned capital");

        PlayerDetail.setCapital(owner, capital_id);
        Capital.setOwner(capital_id, owner);
        Capital.setLastTime(capital_id, block.timestamp);
    }


}
