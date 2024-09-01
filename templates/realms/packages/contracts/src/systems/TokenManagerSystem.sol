pragma solidity >=0.8.0;

import {System} from "@latticexyz/world/src/System.sol";
import {GlobalConfig, PlayerAirdrop, GlobalStake, PlayerStake} from "../codegen/index.sol";
import {Utility} from "../utility/utility.sol";
import {IERC20} from "../utility/IERC20.sol";
import {IUniswapV2Router02} from "../utility/IUniswapV2Router02.sol";
import {IUniswapV2Factory} from "../utility/IUniswapV2Factory.sol";
import {IToken} from "../utility/IToken.sol";
import {Addresses} from "../utility/Constant.sol";

contract TokenManagerSystem is System {

    function initAllowance() public onlyOwner {
        IERC20(Addresses.WETH).approve(Addresses.UniswapV2Router02Address, type(uint256).max);
        IERC20(Addresses.TokenA).approve(Addresses.UniswapV2Router02Address, type(uint256).max);
        IERC20(Addresses.TokenB).approve(Addresses.UniswapV2Router02Address, type(uint256).max);
        IERC20(Addresses.TokenC).approve(Addresses.UniswapV2Router02Address, type(uint256).max);
        IERC20(Addresses.PairTokenA()).approve(Addresses.UniswapV2Router02Address, type(uint256).max);
        IERC20(Addresses.PairTokenB()).approve(Addresses.UniswapV2Router02Address, type(uint256).max);
        IERC20(Addresses.PairTokenC()).approve(Addresses.UniswapV2Router02Address, type(uint256).max);
    }

    modifier onlyOwner() {
        require(_msgSender() == GlobalConfig.getOwner(), "Only the contract owner can call this function.");
        _;
    }

    function getPairAmounts() public view returns (uint256, uint256, uint256){
        uint256 a = IERC20(Addresses.PairTokenA()).balanceOf(address(this));
        uint256 b = IERC20(Addresses.PairTokenB()).balanceOf(address(this));
        uint256 c = IERC20(Addresses.PairTokenC()).balanceOf(address(this));
        return (a, b, c);
    }

    function getTokenAmounts() public view returns (uint256, uint256, uint256){
        uint256 a = IERC20(Addresses.TokenA).balanceOf(address(this));
        uint256 b = IERC20(Addresses.TokenB).balanceOf(address(this));
        uint256 c = IERC20(Addresses.TokenC).balanceOf(address(this));
        return (a, b, c);
    }

    function setNetValue(uint256 amount) public onlyOwner {
        GlobalStake.setNetValue(amount);
    }

    function setBurnRate(uint256 amount) public onlyOwner {
        GlobalStake.setBurnRate(amount);
    }

    function setRewardPerSecondReward(uint256 amount) public onlyOwner {
        GlobalStake.setPerSecondReward(amount);
    }

    function setLastStakeTime(uint256 amount) public onlyOwner {
        GlobalStake.setLastStakeTime(amount);
    }

    function stakeTokenB(uint256 amount) public {
        if (PlayerStake.getLastRewardTimeB(msg.sender) != 0) {
            //如果用户之前没有质押过，标记最后领奖时间为现在时间
            //下次用户领取质押奖励的时间范围就是 （当前->下一次领奖时间）
            PlayerStake.setLastRewardTimeB(msg.sender, block.timestamp);
        } else {
            //如果用户是质押过了再次质押，先将先前的奖励全部发放给用户
            claimRewardB();
        }
        //转移代币
        IERC20(Addresses.TokenB).transferFrom(msg.sender, address(this), amount);
        //记录用户质押数量
        PlayerStake.setTokenB(msg.sender, PlayerStake.getTokenB(msg.sender) + amount);
        //记录全局质押量
        GlobalStake.setTokenB(GlobalStake.getTokenB() + amount);
        //获取两种代币的发行量，用于后续计算
        uint256 b_supply = IERC20(Addresses.TokenB).totalSupply();
        uint256 c_supply = IERC20(Addresses.TokenC).totalSupply();
        //如果经过了燃烧周期，更新全局燃烧数值
        if (block.timestamp - GlobalStake.getLastStakeTime() > 1) {
            //计算这个周期长度
            uint256 time_delta = block.timestamp - GlobalStake.getLastStakeTime();
            //计算并保存要燃烧的金额
            uint256 totalStakedTokenB = GlobalStake.getTokenB();
            GlobalStake.setBurnB(GlobalStake.getBurnRate() * totalStakedTokenB * (1 + (totalStakedTokenB / b_supply)) * time_delta);
            //计算并保存要mint的金额
            uint256 totalStakedTokenC = GlobalStake.getTokenC();
            GlobalStake.setMintB(GlobalStake.getBurnRate() * totalStakedTokenC * (1 + (totalStakedTokenC / c_supply)) * time_delta);
            //根据条件更新全局价值
            if (GlobalStake.getMintB() > GlobalStake.getBurnB()) {
                GlobalStake.setNetValue(GlobalStake.getMintB() - GlobalStake.getBurnB());
                GlobalStake.setIsPositive(true);
            } else {
                GlobalStake.setNetValue(GlobalStake.getBurnB() - GlobalStake.getMintB());
                GlobalStake.setIsPositive(false);
            }
        }
        //更新全局最后质押时间
        GlobalStake.setLastStakeTime(block.timestamp);
    }

    function unstakeB(uint256 amount) public {
        //验证用户质押量是否足够提取
        require(PlayerStake.getTokenB(msg.sender) >= amount, "Not enough B tokens to unstake.");
        //先将上一阶段奖励发掉
        claimRewardB();
        //todo 收取手续费 需求待确认
        //转移资产
        IERC20(Addresses.TokenA).transferFrom(address(this), msg.sender, amount);
        //修改个人质押数据
        PlayerStake.setTokenB(msg.sender, PlayerStake.getTokenB(msg.sender) - amount);
        //修改全局质押数据
        GlobalStake.setTokenB(GlobalStake.getTokenB() - amount);
    }

    function claimRewardB() public {
        uint256 lastClaimedTime = PlayerStake.getLastRewardTimeB(msg.sender);
        //先计算出奖励周期范围
        uint256 timeDelta = block.timestamp - lastClaimedTime;
        if (timeDelta > 0) {
            //奖励金额 = 质押时间 * 每秒奖励金额 * 用户的质押占比
            uint256 reward = timeDelta * GlobalStake.getPerSecondReward() * PlayerStake.getTokenB(msg.sender) / GlobalStake.getTokenB();
            //发放资产
            IERC20(Addresses.TokenB).transferFrom(address(this), msg.sender, reward);
            //记录用户领奖时间
            PlayerStake.setLastRewardTimeB(msg.sender, block.timestamp);
        }
    }


}