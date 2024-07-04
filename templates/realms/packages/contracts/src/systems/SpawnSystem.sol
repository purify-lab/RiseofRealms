// SPDX-License-Identifier: MIT
pragma solidity >=0.8.0;

import {System} from "@latticexyz/world/src/System.sol";
import {IWorld} from "../codegen/world/IWorld.sol";
import {Player, PlayerDetail, Capital, Army, BattleReport} from "../codegen/index.sol";
import {TokenType} from "../codegen/Common.sol";
import {Utility} from "../utility/utility.sol";
import {IERC20} from "../utility/IERC20.sol";


contract SpawnSystem is System {

    //收款人
    address constant Recipient = 0x74f0Bf9321fF57a4028999bB88ca623cc9e79F14;
    //货币
    address constant TokenA = 0x74f0Bf9321fF57a4028999bB88ca623cc9e79F14;
    address constant TokenB = 0x74f0Bf9321fF57a4028999bB88ca623cc9e79F14;
    address constant TokenC = 0x74f0Bf9321fF57a4028999bB88ca623cc9e79F14;

    /**
    * @dev 生成玩家
    */
    function spawnPlayer() public {
        bytes32 entity = Utility.addressToEntityKey(address(_msgSender()));
        require(Player.get(entity) == false, "Already spawned");

        Player.set(entity, true);

        PlayerDetail.setWallet(entity, _msgSender());
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

    function buyInfantryByToken(TokenType token_type, uint256 amount) public {
        if (token_type == TokenType.TokenA) {
            IERC20(TokenA).transferFrom(_msgSender(), Recipient, 50 * amount);
        }
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
        Capital.setTileId(capital_id, capital_id);
        Capital.setOwner(capital_id, owner);
        Capital.setLastTime(capital_id, block.timestamp);

        //eth转账给收款人
        payable(Recipient).transfer(msg.value);
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
     * @dev Calculate the total combat power of an army.
     * @param entityKey The entity key of the army owner.
     * @param armyId The ID of the army.
     * @return The total combat power of the army.
     */
    function getArmyPower(bytes32 entityKey, uint8 armyId) private view returns (uint256) {
        return Army.getInfantry(entityKey, armyId) * 5 + Army.getCavalryA(entityKey, armyId) * 10 + Army.getCavalryB(entityKey, armyId) * 10 + Army.getCavalryC(entityKey, armyId) * 10;
    }

    /**
     * @dev Calculate the total combat power of a capital.
     * @param locationId The ID of the capital.
     * @return The total combat power of the capital.
     */
    function getCapitalPower(uint16 locationId) private view returns (uint256) {
        return Capital.getInfantry(locationId) * 5 + Capital.getCavalryA(locationId) * 10 + Capital.getCavalryB(locationId) * 10 + Capital.getCavalryC(locationId) * 10;
    }

    /**
     * @dev Destroy the army.
     * @param entityKey The entity key of the army owner.
     * @param armyId The ID of the army.
     */
    function destroyArmy(bytes32 entityKey, uint8 armyId) private {
        Army.setDestination(entityKey, armyId, 0);
        Army.setLastTime(entityKey, armyId, 0);
        Army.setInfantry(entityKey, armyId, 0);
        Army.setCavalryA(entityKey, armyId, 0);
        Army.setCavalryB(entityKey, armyId, 0);
        Army.setCavalryC(entityKey, armyId, 0);
    }

    /**
    * @dev Calculate losses for both sides
    */
    function _calculateLosses(
        bytes32 attacker,
        uint8 army_id,
        uint16 defenceLocation
    ) private view returns (uint256[8] memory) {
        uint256[8] memory losses;
        if (Army.getInfantry(attacker, army_id) >= Capital.getInfantry(defenceLocation)) {
            losses[0] = Capital.getInfantry(defenceLocation);
            losses[4] = Capital.getInfantry(defenceLocation);
        } else {
            losses[0] = Army.getInfantry(attacker, army_id);
            losses[4] = Army.getInfantry(attacker, army_id);
        }

        if (Army.getCavalryA(attacker, army_id) >= Capital.getCavalryA(defenceLocation)) {
            losses[1] = Capital.getCavalryA(defenceLocation);
            losses[5] = Capital.getCavalryA(defenceLocation);
        } else {
            losses[1] = Army.getCavalryA(attacker, army_id);
            losses[5] = Army.getCavalryA(attacker, army_id);
        }

        if (Army.getCavalryB(attacker, army_id) >= Capital.getCavalryB(defenceLocation)) {
            losses[2] = Capital.getCavalryB(defenceLocation);
            losses[6] = Capital.getCavalryB(defenceLocation);
        } else {
            losses[2] = Army.getCavalryB(attacker, army_id);
            losses[6] = Army.getCavalryB(attacker, army_id);
        }

        if (Army.getCavalryC(attacker, army_id) >= Capital.getCavalryC(defenceLocation)) {
            losses[3] = Capital.getCavalryC(defenceLocation);
            losses[7] = Capital.getCavalryC(defenceLocation);
        } else {
            losses[3] = Army.getCavalryC(attacker, army_id);
            losses[7] = Army.getCavalryC(attacker, army_id);
        }
        return losses;
    }

    /**
     * @dev Attack: If the attacker's army size is greater than the defender's, the attacker wins. Otherwise, the defender wins.
     * @dev If the attacker wins: All entities become the attacker's, and the last attack time is updated.
     * @dev If the defender wins: Entities remain unchanged.
     * @dev Regardless of the outcome, the armies are destroyed.
     * @dev The side with greater combat power wins the battle.
     * @dev Both sides lose soldiers, with a minimum of 0.
     * @dev Record the battle report.
     * @param army_id The ID of the attacking army.
     */
    function attack(uint8 army_id) public {
        require(army_id > 0 && army_id <= 9, "invalid army id");
        bytes32 attacker = Utility.addressToEntityKey(address(_msgSender()));
        uint256 attackPower = getArmyPower(attacker, army_id);
        uint16 defenceLocation = Army.getDestination(attacker, army_id);
        bytes32 defender = Capital.getOwner(defenceLocation);
        uint256 defensePower = getCapitalPower(defenceLocation);

        require(Army.getDestination(attacker, army_id) != 0, "this army is not marching");
        require(attacker != Capital.getOwner(defenceLocation), "cannot attack your own capital");
        require(block.timestamp - Army.getLastTime(attacker, army_id) >= 60 * 5, "not ready yet");

        uint256[8] memory losses = _calculateLosses(attacker, army_id, defenceLocation);

        if (attackPower > defensePower) {
            Capital.setOwner(defenceLocation, attacker);
            Capital.setLastTime(defenceLocation, block.timestamp);
            Capital.setInfantry(defenceLocation, Army.getCavalryC(attacker, army_id) - losses[0]);
            Capital.setCavalryA(defenceLocation, Army.getCavalryA(attacker, army_id) - losses[1]);
            Capital.setCavalryB(defenceLocation, Army.getCavalryB(attacker, army_id) - losses[2]);
            Capital.setCavalryC(defenceLocation, Army.getCavalryC(attacker, army_id) - losses[3]);
        } else {
            Capital.setInfantry(defenceLocation, Capital.getInfantry(defenceLocation) - losses[4]);
            Capital.setCavalryA(defenceLocation, Capital.getCavalryA(defenceLocation) - losses[5]);
            Capital.setCavalryB(defenceLocation, Capital.getCavalryB(defenceLocation) - losses[6]);
            Capital.setCavalryC(defenceLocation, Capital.getCavalryC(defenceLocation) - losses[7]);
        }

        BattleReport.setAttackWin(defenceLocation, block.timestamp, attackPower > defensePower);
        BattleReport.setAttacker(defenceLocation, block.timestamp, _msgSender());
        BattleReport.setDefender(defenceLocation, block.timestamp, Utility.entityKeyToAddress(defender));
        BattleReport.setLosses(defenceLocation, block.timestamp, losses);

        // Destroy the armies
        destroyArmy(attacker, army_id);
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

    /**
     * @dev 第一阶段结束时间
     */
    function getStageOneEndTime() pure public returns (uint256 timestamp){
        //2024-07-10
        return 1720540800;
    }
}
