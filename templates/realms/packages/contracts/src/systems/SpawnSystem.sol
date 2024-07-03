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

        //转账给收款人
        IERC20(Recipient).transfer(Recipient, 500000000000000);
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
     * @dev 攻击 如果攻击人的士兵数量大于被攻击人的士兵数量，攻击人胜利，否则被攻击人胜利
     * @dev 攻击人胜利 领取所有人变为攻击人 更新时间
     * @dev 被攻击人胜利 领取所有人不变
     * @dev 无论胜利与否 都销毁军队

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

        uint256 attacker_infantry_loss = 0;
        uint256 defender_infantry_loss = 0;
        if (Army.getInfantry(owner, army_id) > Capital.getInfantry(destination)) {
            attacker_infantry_loss = Army.getInfantry(owner, army_id) - Capital.getInfantry(destination);
        } else {
            defender_infantry_loss = Capital.getInfantry(destination) - Army.getInfantry(owner, army_id);
        }

        if (attack_power > defence_power) {
            Capital.setOwner(destination, owner);
            Capital.setLastTime(destination, block.timestamp);
            // Attacker wins
            BattleReport.setAttacker(destination, block.timestamp, _msgSender());
            BattleReport.setDefender(destination, block.timestamp, Utility.entityKeyToAddress(Capital.getOwner(destination)));
            BattleReport.setWin(destination, block.timestamp, true);
            BattleReport.setAttackOrDefence(destination, block.timestamp, true);
            BattleReport.setLossInfantry(destination, block.timestamp, Capital.getInfantry(destination));

            // Defender loses
            uint256 defenderLoss = Capital.getInfantry(destination) + Capital.getCavalryA(destination) + Capital.getCavalryB(destination) + Capital.getCavalryC(destination);

            BattleReport.setLossInfantry(destination, block.timestamp, defenderLoss);
        } else {
            // Attacker loses
            BattleReport.setAttacker(destination, block.timestamp, _msgSender());
            BattleReport.setDefender(destination, block.timestamp, Utility.entityKeyToAddress(Capital.getOwner(destination)));
            BattleReport.setWin(destination, block.timestamp, false);
            BattleReport.setAttackOrDefence(destination, block.timestamp, true);
            BattleReport.setLossInfantry(destination, block.timestamp, Army.getInfantry(owner, army_id));

            // Defender wins
            uint256 attackerLoss = Army.getInfantry(owner, army_id) + Army.getCavalryA(owner, army_id) + Army.getCavalryB(owner, army_id) + Army.getCavalryC(owner, army_id);

            BattleReport.setLossInfantry(destination, block.timestamp, attackerLoss);
        }

        //销毁军队
        Army.setDestination(owner, army_id, 0);
        Army.setLastTime(owner, army_id, 0);
        Army.setInfantry(owner, army_id, 0);
        Army.setCavalryA(owner, army_id, 0);
        Army.setCavalryB(owner, army_id, 0);
        Army.setCavalryC(owner, army_id, 0);
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
