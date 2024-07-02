// SPDX-License-Identifier: MIT
pragma solidity >=0.8.0;

import {System} from "@latticexyz/world/src/System.sol";
import {IWorld} from "../codegen/world/IWorld.sol";
import {Player, Position, Toad, GameManager, PlayerDetail, Capital, Army} from "../codegen/index.sol";

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
        PlayerDetail.setCavalryA(entity, 1000000000);
        PlayerDetail.setCavalryB(entity, 1000000000);
        PlayerDetail.setCavalryC(entity, 1000000000);
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

    //驻军
    function garrison(uint16 capital_id, uint256 infantry, uint256 cavalryA, uint256 cavalryB, uint256 cavalryC) public {
        bytes32 owner = Utility.addressToEntityKey(address(_msgSender()));
        require(Capital.getOwner(capital_id) == owner, "this capital not yours");

        require(PlayerDetail.getInfantry(owner) >= infantry, "not enough infantry");
        require(PlayerDetail.getCavalryA(owner) >= cavalryA, "not enough cavalryA");
        require(PlayerDetail.getCavalryB(owner) >= cavalryB, "not enough cavalryB");
        require(PlayerDetail.getCavalryC(owner) >= cavalryC, "not enough cavalryC");

        PlayerDetail.setInfantry(owner, PlayerDetail.getInfantry(owner) - infantry);
        PlayerDetail.setCavalryA(owner, PlayerDetail.getCavalryA(owner) - cavalryA);
        PlayerDetail.setCavalryB(owner, PlayerDetail.getCavalryB(owner) - cavalryB);
        PlayerDetail.setCavalryC(owner, PlayerDetail.getCavalryC(owner) - cavalryC);

        Capital.setInfantry(capital_id, Capital.getInfantry(capital_id) + infantry);
        Capital.setCavalryA(capital_id, Capital.getCavalryA(capital_id) + cavalryA);
        Capital.setCavalryB(capital_id, Capital.getCavalryB(capital_id) + cavalryB);
        Capital.setCavalryC(capital_id, Capital.getCavalryC(capital_id) + cavalryC);
    }

    //行军
    function march(uint16 destination, uint256 infantry, uint256 cavalryA, uint256 cavalryB, uint256 cavalryC, uint8 army_id) public {
        bytes32 owner = Utility.addressToEntityKey(address(_msgSender()));

        require(PlayerDetail.getInfantry(owner) >= infantry, "not enough infantry");
        require(PlayerDetail.getCavalryA(owner) >= cavalryA, "not enough cavalryA");
        require(PlayerDetail.getCavalryB(owner) >= cavalryB, "not enough cavalryB");
        require(PlayerDetail.getCavalryC(owner) >= cavalryC, "not enough cavalryC");
        require(army_id > 0 && army_id <= 9, "invalid army id");
        require(army_id.getOwner(owner) == 0, "this army not yours");

        PlayerDetail.setInfantry(owner, PlayerDetail.getInfantry(owner) - infantry);
        PlayerDetail.setCavalryA(owner, PlayerDetail.getCavalryA(owner) - cavalryA);
        PlayerDetail.setCavalryB(owner, PlayerDetail.getCavalryB(owner) - cavalryB);
        PlayerDetail.setCavalryC(owner, PlayerDetail.getCavalryC(owner) - cavalryC);

        Army.setInfantry(owner, army_id, infantry);
        Army.setCavalryA(owner, army_id, cavalryA);
        Army.setCavalryB(owner, army_id, cavalryB);
        Army.setCavalryC(owner, army_id, cavalryC);
        Army.setDestination(owner, army_id, destination);
        Army.setLastTime(owner, army_id, block.timestamp);
    }

    function attack(uint16 army_id) public {

    }

}
