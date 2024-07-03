// SPDX-License-Identifier: MIT
pragma solidity >=0.8.0;

import {System} from "@latticexyz/world/src/System.sol";
import {IWorld} from "../codegen/world/IWorld.sol";
import {Player, Position, Toad, GameManager, PlayerDetail, Capital, Army, BattleReport} from "../codegen/index.sol";

import {getUniqueEntity} from "@latticexyz/world-modules/src/modules/uniqueentity/getUniqueEntity.sol";
import {Utility} from "../utility/utility.sol";
import {IERC20} from "../utility/IERC20.sol";


contract SpawnSystem is System {

    /**
    * @dev 生成玩家
    */
    function spawnPlayer() public {
        bytes32 entity = Utility.addressToEntityKey(address(_msgSender()));
        require(Player.get(entity) == false, "Already spawned");

        Player.set(entity, true);

        PlayerDetail.setWallet(_msgSender());
        PlayerDetail.setGold(entity, 1000000000);
        PlayerDetail.setInfantry(entity, 1000000000);
        PlayerDetail.setCavalryA(entity, 1000000000);
        PlayerDetail.setCavalryB(entity, 1000000000);
        PlayerDetail.setCavalryC(entity, 1000000000);
    }

    /**
    * @dev 购买步兵
    * @param amount 数量
    */
    function buyInfantry(uint256 amount) public {
        uint256 price = 50;
        bytes32 entity = Utility.addressToEntityKey(address(_msgSender()));
        require(PlayerDetail.getGold(entity) >= price * amount, "not enough gold");
        PlayerDetail.setGold(entity, PlayerDetail.getGold(entity) - price * amount);
        PlayerDetail.setInfantry(entity, PlayerDetail.getInfantry(entity) + amount);
    }

    /**
    * @dev 购买骑兵A
    * @param amount 数量
    */
    function buyCavalryA(uint256 amount) public {
        uint256 price = 100;
        bytes32 entity = Utility.addressToEntityKey(address(_msgSender()));
        require(PlayerDetail.getGold(entity) >= price * amount, "not enough gold");
        PlayerDetail.setGold(entity, PlayerDetail.getGold(entity) - price * amount);
        PlayerDetail.setCavalryA(entity, PlayerDetail.getCavalryA(entity) + amount);
    }

    /**
    * @dev 购买骑兵B
    * @param amount 数量
    */
    function buyCavalryB(uint256 amount) public {
        uint256 price = 200;
        bytes32 entity = Utility.addressToEntityKey(address(_msgSender()));
        require(PlayerDetail.getGold(entity) >= price * amount, "not enough gold");
        PlayerDetail.setGold(entity, PlayerDetail.getGold(entity) - price * amount);
        PlayerDetail.setCavalryB(entity, PlayerDetail.getCavalryB(entity) + amount);
    }

    /**
    * @dev 购买骑兵C
    * @param amount 数量
    */
    function buyCavalryC(uint256 amount) public {
        uint256 price = 400;
        bytes32 entity = Utility.addressToEntityKey(address(_msgSender()));
        require(PlayerDetail.getGold(entity) >= price * amount, "not enough gold");
        PlayerDetail.setGold(entity, PlayerDetail.getGold(entity) - price * amount);
        PlayerDetail.setCavalryC(entity, PlayerDetail.getCavalryC(entity) + amount);
    }

    /**
    * @dev 生成领地
    * @param capital_id 领地id
    */
    function spawnCapital(uint16 capital_id) public payable {
        //price 0.0005 eth
        require(capital_id > 0 && capital_id <= 8000, "invalid capital id");
        require(msg.value == 500000000000000, "No eth");
        bytes32 owner = Utility.addressToEntityKey(address(_msgSender()));
        require(Capital.getOwner(capital_id) == 0, "this capital already spawned");
        require(PlayerDetail.getCapital(owner) == 0, "you already spawned capital");

        PlayerDetail.setCapital(owner, capital_id);
        Capital.setOwner(capital_id, owner);
        Capital.setLastTime(capital_id, block.timestamp);
    }

    /**
    * @dev 驻守
    * @param capital_id 要驻守的领地id
    * @param infantry 步兵数量
    * @param cavalryA 骑兵A数量
    * @param cavalryB 骑兵B数量
    * @param cavalryC 骑兵C数量
    */
    function garrison(uint16 capital_id, uint256 infantry, uint256 cavalryA, uint256 cavalryB, uint256 cavalryC) public {
        bytes32 owner = Utility.addressToEntityKey(address(_msgSender()));
        require(Capital.getOwner(capital_id) == owner, "this capital not yours");

        require(PlayerDetail.getInfantry(owner) >= infantry, "not enough infantry");
        require(PlayerDetail.getCavalryA(owner) >= cavalryA, "not enough cavalryA");
        require(PlayerDetail.getCavalryB(owner) >= cavalryB, "not enough cavalryB");
        require(PlayerDetail.getCavalryC(owner) >= cavalryC, "not enough cavalryC");

        uint256 max_power = 20000;
        require(infantry * 5 + cavalryA * 10 + cavalryB * 10 + cavalryC * 10 <= max_power, "too many troops");

        PlayerDetail.setInfantry(owner, PlayerDetail.getInfantry(owner) - infantry);
        PlayerDetail.setCavalryA(owner, PlayerDetail.getCavalryA(owner) - cavalryA);
        PlayerDetail.setCavalryB(owner, PlayerDetail.getCavalryB(owner) - cavalryB);
        PlayerDetail.setCavalryC(owner, PlayerDetail.getCavalryC(owner) - cavalryC);

        Capital.setInfantry(capital_id, Capital.getInfantry(capital_id) + infantry);
        Capital.setCavalryA(capital_id, Capital.getCavalryA(capital_id) + cavalryA);
        Capital.setCavalryB(capital_id, Capital.getCavalryB(capital_id) + cavalryB);
        Capital.setCavalryC(capital_id, Capital.getCavalryC(capital_id) + cavalryC);
    }

    /**
    * @dev 派遣军队
    * @param destination 目的地
    * @param infantry 步兵数量
    * @param cavalryA 骑兵A数量
    * @param cavalryB 骑兵B数量
    * @param cavalryC 骑兵C数量
    * @param army_id 军队id
    */
    function march(uint16 destination, uint256 infantry, uint256 cavalryA, uint256 cavalryB, uint256 cavalryC, uint8 army_id) public {

        require(destination > 0 && destination <= 8000, "invalid destination");

        bytes32 owner = Utility.addressToEntityKey(address(_msgSender()));

        require(PlayerDetail.getInfantry(owner) >= infantry, "not enough infantry");
        require(PlayerDetail.getCavalryA(owner) >= cavalryA, "not enough cavalryA");
        require(PlayerDetail.getCavalryB(owner) >= cavalryB, "not enough cavalryB");
        require(PlayerDetail.getCavalryC(owner) >= cavalryC, "not enough cavalryC");
        require(army_id > 0 && army_id <= 9, "invalid army id");
        require(Army.getDestination(owner, army_id) == 0, "this army not yours");

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

    /**
     * @dev 攻击
     * @param army_id 军队id
     */
    function attack(uint8 army_id) public {
        require(army_id > 0 && army_id <= 9, "invalid army id");
        bytes32 owner = Utility.addressToEntityKey(address(_msgSender()));
        uint256 attack_power = Army.getInfantry(owner, army_id) * 5 + Army.getCavalryA(owner, army_id) * 10 + Army.getCavalryB(owner, army_id) * 10 + Army.getCavalryC(owner, army_id) * 10;
        uint16 destination = Army.getDestination(owner, army_id);
        uint256 defence_power = Capital.getInfantry(destination) * 5 + Capital.getCavalryA(destination) * 10 + Capital.getCavalryB(destination) * 10 + Capital.getCavalryC(destination) * 10;

        require(Army.getDestination(owner, army_id) != 0, "this army not marching");
        require(owner != Capital.getOwner(destination), "can't attack your own capital");
        require(block.timestamp - Army.getLastTime(owner, army_id) >= 60 * 5, "not ready yet");

        if (attack_power > defence_power) {
            Capital.setOwner(destination, owner);
            Capital.setInfantry(destination, Army.getInfantry(owner, army_id));
            Capital.setCavalryA(destination, Army.getCavalryA(owner, army_id));
            Capital.setCavalryB(destination, Army.getCavalryB(owner, army_id));
            Capital.setCavalryC(destination, Army.getCavalryC(owner, army_id));

            BattleReport.setAttacker(destination, block.timestamp, _msgSender());
//            BattleReport.setDefender(destination, block.timestamp, Capital.getOwner(destination));

        }

        Army.setInfantry(owner, army_id, 0);
        Army.setCavalryA(owner, army_id, 0);
        Army.setCavalryB(owner, army_id, 0);
        Army.setCavalryC(owner, army_id, 0);
        Army.setDestination(owner, army_id, 0);
        Army.setLastTime(owner, army_id, 0);
    }

    /**
    * @dev 收获
    * @param capital_id 要收获的领地id
    */
    function farming(uint16 capital_id) public {
        bytes32 owner = Utility.addressToEntityKey(address(_msgSender()));
        require(Capital.getOwner(capital_id) == owner, "this capital not yours");
        uint256 last_time = Capital.getLastTime(capital_id);
        uint256 currentTimestamp = block.timestamp;
        uint256 time = currentTimestamp - last_time;
        uint256 gold = time * 1;
        PlayerDetail.setGold(owner, PlayerDetail.getGold(owner) + gold);
        Capital.setLastTime(capital_id, currentTimestamp);
    }


}
