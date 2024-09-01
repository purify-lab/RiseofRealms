// SPDX-License-Identifier: MIT
pragma solidity >=0.8.0;

import {System} from "@latticexyz/world/src/System.sol";
import {Player, PlayerDetail, Capital, Army, BattleReport, GlobalStatistics, GlobalStake, GlobalConfig, PlayerStake, Land} from "../codegen/index.sol";
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
        PlayerDetail.set(entity, _msgSender(), 1000000000, 1000000000, 1000000000, 1000000000, 1000000000, 0, false);
//        PlayerDetail.setWallet(entity, _msgSender());
//        PlayerDetail.setGold(entity, 1000000000);
//        PlayerDetail.setInfantry(entity, 1000000000);
//        PlayerDetail.setCavalryA(entity, 1000000000);
//        PlayerDetail.setCavalryB(entity, 1000000000);
//        PlayerDetail.setCavalryC(entity, 1000000000);
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
    * @dev 生成城池
    * @param capital_id 城池id
    */
    function spawnCapital(uint16 capital_id) public payable {
        //price 0.0005 eth
        require(capital_id > 0 && capital_id <= 8000, "invalid capital id");
        require(msg.value == 500000000000000, "No eth");
        bytes32 owner = Utility.addressToEntityKey(address(_msgSender()));
        require(Capital.getOwner(capital_id) == 0, "this capital already spawned");
        require(PlayerDetail.getIsSpawnCapital(owner) == true, "you already spawned capital");

        PlayerDetail.setLands(owner, PlayerDetail.getLands(owner) + 1);
        PlayerDetail.setIsSpawnCapital(owner, true);
        Capital.set(capital_id, capital_id, owner, (uint32)(block.timestamp));
        Land.set(capital_id, capital_id, owner, 0, 0, 0, 0, (uint32)(block.timestamp), false);

        //eth转账给收款人
        payable(Recipient).transfer(msg.value);
    }

    /**
    * @dev 驻守
    * @param land_id 要驻守的领地id
    * @param infantry 步兵数量
    * @param cavalryA 骑兵A数量
    * @param cavalryB 骑兵B数量
    * @param cavalryC 骑兵C数量
    */
    function garrison(uint16 land_id, uint256 infantry, uint256 cavalryA, uint256 cavalryB, uint256 cavalryC) public {
        bytes32 owner = Utility.addressToEntityKey(address(_msgSender()));
        require(Capital.getOwner(land_id) == owner, "this land_id not yours");

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

        Land.setInfantry(land_id, Land.getInfantry(land_id) + infantry);
        Land.setCavalryA(land_id, Land.getCavalryA(land_id) + cavalryA);
        Land.setCavalryB(land_id, Land.getCavalryB(land_id) + cavalryB);
        Land.setCavalryC(land_id, Land.getCavalryC(land_id) + cavalryC);
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
        require(army_id > 0 && army_id <= 9, "invalid army id");

        bytes32 owner = Utility.addressToEntityKey(address(_msgSender()));
        bytes32 armyKey = Utility.armyToEntityKey(owner, army_id);

        require(PlayerDetail.getInfantry(owner) >= infantry, "not enough infantry");
        require(PlayerDetail.getCavalryA(owner) >= cavalryA, "not enough cavalryA");
        require(PlayerDetail.getCavalryB(owner) >= cavalryB, "not enough cavalryB");
        require(PlayerDetail.getCavalryC(owner) >= cavalryC, "not enough cavalryC");
        require(Army.getDestination(armyKey) == 0, "this army not yours");

        PlayerDetail.setInfantry(owner, PlayerDetail.getInfantry(owner) - infantry);
        PlayerDetail.setCavalryA(owner, PlayerDetail.getCavalryA(owner) - cavalryA);
        PlayerDetail.setCavalryB(owner, PlayerDetail.getCavalryB(owner) - cavalryB);
        PlayerDetail.setCavalryC(owner, PlayerDetail.getCavalryC(owner) - cavalryC);

//        Army.set(armyKey, owner, army_id, infantry, cavalryA, cavalryB, cavalryC, (uint32)(block.timestamp), destination);
        Army.setOwner(armyKey, owner);
        Army.setId(armyKey, army_id);
        Army.setInfantry(armyKey, infantry);
        Army.setCavalryA(armyKey, cavalryA);
        Army.setCavalryB(armyKey, cavalryB);
        Army.setCavalryC(armyKey, cavalryC);
        Army.setDestination(armyKey, destination);
        Army.setLastTime(armyKey, (uint32)(block.timestamp));
    }

    /**
     * @dev Calculate the total combat power of an army.
     * @param entityKey The entity key of the army owner.
     * @return The total combat power of the army.
     */
    function getArmyPower(bytes32 entityKey) public view returns (uint256) {
        return Army.getInfantry(entityKey) * 5 + Army.getCavalryA(entityKey) * 10 + Army.getCavalryB(entityKey) * 10 + Army.getCavalryC(entityKey) * 10;
    }

    /**
     * @dev Calculate the total combat power of a capital.
     * @param land_id The ID of the capital.
     * @return The total combat power of the capital.
     */
    function getLandPower(uint16 land_id) public view returns (uint256) {
        return Land.getInfantry(land_id) * 5 + Land.getCavalryA(land_id) * 10 + Land.getCavalryB(land_id) * 10 + Land.getCavalryC(land_id) * 10;
    }

    /**
    * @dev Calculate losses for both sides
    */
    function _calculateLosses(
        bytes32 armyKey,
        uint16 defenceLocation
    ) public view returns (uint256[8] memory) {
        uint256[8] memory losses;

        if (Army.getInfantry(armyKey) >= Land.getInfantry(defenceLocation)) {
            losses[0] = Land.getInfantry(defenceLocation);
            losses[4] = Land.getInfantry(defenceLocation);
        } else {
            losses[0] = Army.getInfantry(armyKey);
            losses[4] = Army.getInfantry(armyKey);
        }

        if (Army.getCavalryA(armyKey) >= Land.getCavalryA(defenceLocation)) {
            losses[1] = Land.getCavalryA(defenceLocation);
            losses[5] = Land.getCavalryA(defenceLocation);
        } else {
            losses[1] = Army.getCavalryA(armyKey);
            losses[5] = Army.getCavalryA(armyKey);
        }

        if (Army.getCavalryB(armyKey) >= Land.getCavalryB(defenceLocation)) {
            losses[2] = Land.getCavalryB(defenceLocation);
            losses[6] = Land.getCavalryB(defenceLocation);
        } else {
            losses[2] = Army.getCavalryB(armyKey);
            losses[6] = Army.getCavalryB(armyKey);
        }

        if (Army.getCavalryC(armyKey) >= Land.getCavalryC(defenceLocation)) {
            losses[3] = Land.getCavalryC(defenceLocation);
            losses[7] = Land.getCavalryC(defenceLocation);
        } else {
            losses[3] = Army.getCavalryC(armyKey);
            losses[7] = Army.getCavalryC(armyKey);
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
        bytes32 armyKey = Utility.armyToEntityKey(attacker, army_id);
        uint256 attackPower = getArmyPower(armyKey);
        uint16 defenceLocation = Army.getDestination(armyKey);
        bytes32 defender = Land.getOwner(defenceLocation);
        uint256 defensePower = getLandPower(defenceLocation);

        require(Army.getDestination(armyKey) != 0, "this army is not marching");
        require(attacker != Capital.getOwner(defenceLocation), "cannot attack your own capital");
        require((uint32)(block.timestamp) - Army.getLastTime(armyKey) >= 60 * 5, "not ready yet");

        uint256[8] memory losses = _calculateLosses(armyKey, defenceLocation);

        if (attackPower > defensePower) {
            Land.setOwner(defenceLocation, attacker);
            Land.setLastTime(defenceLocation, (uint32)(block.timestamp));
            Land.setInfantry(defenceLocation, Army.getCavalryC(armyKey) - losses[0]);
            Land.setCavalryA(defenceLocation, Army.getCavalryA(armyKey) - losses[1]);
            Land.setCavalryB(defenceLocation, Army.getCavalryB(armyKey) - losses[2]);
            Land.setCavalryC(defenceLocation, Army.getCavalryC(armyKey) - losses[3]);

            PlayerDetail.setLands(attacker, PlayerDetail.getLands(attacker) + 1);
            if (defender != 0) {
                PlayerDetail.setLands(defender, PlayerDetail.getLands(defender) - 1);
//                passiveUnStake(defender);
            }
        } else {
            Land.setInfantry(defenceLocation, Land.getInfantry(defenceLocation) - losses[4]);
            Land.setCavalryA(defenceLocation, Land.getCavalryA(defenceLocation) - losses[5]);
            Land.setCavalryB(defenceLocation, Land.getCavalryB(defenceLocation) - losses[6]);
            Land.setCavalryC(defenceLocation, Land.getCavalryC(defenceLocation) - losses[7]);
        }

        bytes32 reportKey = Utility.battleReportToEntityKey(defenceLocation, (uint32)(block.timestamp));
        BattleReport.set(reportKey, defenceLocation, (uint32)(block.timestamp), _msgSender(), Utility.entityKeyToAddress(defender), attackPower > defensePower, losses);
//        BattleReport.setCapitalId(reportKey, defenceLocation);
//        BattleReport.setTimestamp(reportKey, (uint32)(block.timestamp));
//        BattleReport.setAttackWin(reportKey, attackPower > defensePower);
//        BattleReport.setAttacker(reportKey, _msgSender());
//        BattleReport.setDefender(reportKey, Utility.entityKeyToAddress(defender));
//        BattleReport.setLosses(reportKey, losses);

        // Destroy the armies
        Army.deleteRecord(armyKey);
    }

    /**
    * @dev 收获
    * @param capital_id 要收获的领地id
    */
    function farming(uint16 capital_id) public {
        bytes32 owner = Utility.addressToEntityKey(address(_msgSender()));
        require(Capital.getOwner(capital_id) == owner, "this capital not yours");
        uint32 last_time = Capital.getLastTime(capital_id);
        uint32 currentTimestamp = (uint32)(block.timestamp);
        uint32 time = currentTimestamp - last_time;
        uint256 gold = (uint256)(time) * 1;
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

    function getStakeLimit(address owner) view public returns (uint256 amount){
        uint256 amount = 50000;
        bytes32 id = Utility.addressToEntityKey(owner);
        return amount + PlayerDetail.getLands(id) * 50000;
    }

    event EventBurnToken(uint256 netValueB, uint256 netValueC);

//    function stakeTokenB(uint256 amount) public {
//        require(amount + PlayerStake.getTokenB(_msgSender()) + PlayerStake.getTokenC(_msgSender()) >= getStakeLimit(_msgSender()), "exceed the limit");
//        IERC20 tokenB = IERC20(TokenB);
//        bool success = tokenB.transferFrom(_msgSender(), address(this), amount);
//        require(success, "trans fail");
//        PlayerStake.setTokenB(_msgSender(), PlayerStake.getTokenB(_msgSender()) + amount);
//        uint256 rate = 1;//0.0001
//
//        uint256 last_time = GlobalStake.getLastStakeTime();
//        uint256 current_time = block.timestamp;
//        uint256 block_delta = current_time - last_time;
//
//        if (block_delta > 0) {
//            uint256 supply = tokenB.totalSupply();
//            uint256 temp = GlobalStake.getStakeTokenB() * (1 + GlobalStake.getStakeTokenB() / supply) * block_delta * rate / 10000;
//
//            uint256 valueB = GlobalStake.getStakeTokenB() + temp;
//
//            GlobalStake.setValueB(valueB);
//            GlobalStake.setLastStakeTime(block.timestamp);
//
//            uint256 valueC = GlobalStake.getStakeTokenC();
//
//            uint256 netValueB = valueC - valueB;
//            uint256 netValueC = valueB - valueC;
//
//            emit EventBurnToken(netValueB, netValueC);
//        }
//    }
//
//    function stakeTokenC(uint256 amount) public {
//        require(amount + PlayerStake.getTokenB(_msgSender()) + PlayerStake.getTokenC(_msgSender()) >= getStakeLimit(_msgSender()), "exceed the limit");
//        IERC20 tokenC = IERC20(TokenC);
//        bool success = tokenC.transferFrom(_msgSender(), address(this), amount);
//        require(success, "trans fail");
//        PlayerStake.setTokenC(_msgSender(), PlayerStake.getTokenC(_msgSender()) + amount);
//        uint256 rate = 1;//0.0001
//
//        uint256 last_time = GlobalStake.getLastStakeTime();
//        uint256 current_time = block.timestamp;
//        uint256 block_delta = current_time - last_time;
//
//        if (block_delta > 0) {
//            uint256 supply = tokenC.totalSupply();
//            uint256 temp = GlobalStake.getStakeTokenC() * (1 + GlobalStake.getStakeTokenC() / supply) * block_delta * rate / 10000;
//
//            uint256 valueC = GlobalStake.getStakeTokenC() + temp;
//
//            GlobalStake.setValueC(valueC);
//            GlobalStake.setLastStakeTime(block.timestamp);
//
//            uint256 valueB = GlobalStake.getStakeTokenB();
//
//            uint256 netValueB = valueC - valueB;
//            uint256 netValueC = valueB - valueC;
//
//            emit EventBurnToken(netValueB, netValueC);
//        }
//    }
//
//    function unStakeTokenB(address staker, uint256 amount) public {
//        require(PlayerStake.getTokenB(staker) > amount, "insuffcient amount");
//        address sender = _msgSender();
//        if (sender == staker) {
//            uint256 out = amount - (amount * GlobalConfig.getUnStakeFee() / 100);
//            IERC20(TokenB).transferFrom(address(this), staker, out);
//        }
//    }
//
//    function passiveUnStake(bytes32 defender, bytes32 attacker) private {
////        address defenderAddress = Utility.entityKeyToAddress(defender);
////        address attackerAddress = Utility.entityKeyToAddress(attacker);
////        uint256 limit = getStakeLimit(defenderAddress);
////        uint256 totalStaked = PlayerStake.getTokenB() + PlayerStake.setTokenC();
////        uint256 fee = GlobalConfig.getPassiveUnStakeFee();
////        if (totalStaked > limit) {
////            uint256 partB = PlayerStake.getTokenB() * 100 / totalStaked * 100;
////            uint256 partC = PlayerStake.getTokenC() * 100 / totalStaked * 100;
////            uint256 tokenUnStakedB = (totalStaked - limit) * partB / 100;
////            uint256 tokenUnStakedC = (totalStaked - limit) * partC / 100;
////            if (tokenUnStakedB > 0) {
////                uint256 feeAmount = tokenUnStakedB * fee / 100;
////                IERC20 tokenB = IERC20(TokenB);
////                PlayerStake.setTokenB(defenderAddress, PlayerStake.getTokenB(defenderAddress) - tokenUnStakedB);
////                tokenB.transferFrom(address(this), defenderAddress, tokenUnStakedB - feeAmount);
////                tokenB.transferFrom(address(this), attackerAddress, feeAmount);
////            }
////            if (tokenUnStakedC > 0) {
////                IERC20 tokenC = IERC20(TokenC);
////                uint256 feeAmount = tokenUnStakedC * fee / 100;
////                PlayerStake.setTokenC(defenderAddress, PlayerStake.getTokenC(defenderAddress) - tokenUnStakedC);
////                tokenC.transferFrom(address(this), defenderAddress, tokenUnStakedC - feeAmount);
////                tokenC.transferFrom(address(this), attackerAddress, feeAmount);
////            }
////        }
//    }

    modifier onlyOwner() {
        require(_msgSender() == GlobalConfig.getOwner(), "Only the contract owner can call this function.");
        _;
    }

    function setUnStakeFee(uint256 fee) onlyOwner public {
        GlobalConfig.setUnStakeFee(fee);
    }

    function setPassiveUnStakeFee(uint256 fee) onlyOwner public {
        GlobalConfig.setPassiveUnStakeFee(fee);
    }

    function setOwner() public {
        require(GlobalConfig.getOwner() == address(0), "readly set owner");
        GlobalConfig.setOwner(_msgSender());
    }
}
