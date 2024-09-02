pragma solidity >=0.8.0;

import {System} from "@latticexyz/world/src/System.sol";
import {GlobalConfig, PlayerAirdrop, GlobalStake, PlayerStake, PlayerDetail} from "../codegen/index.sol";
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

    function ultraMintTokenB(uint256 net_value, uint256 stake_reward) public {
        IToken(Addresses.TokenB).mint(address(this), net_value);

        IUniswapV2Router02 router = IUniswapV2Router02(Addresses.UniswapV2Router02Address);

        address[] memory path = new address[](2);
        path[0] = Addresses.TokenB;
        path[1] = router.WETH();

        // 60% swap to WETH, 40% remain as stake reward
        router.swapExactTokensForTokensSupportingFeeOnTransferTokens(
            net_value * 6 / 10, 0, path, address(this), block.timestamp);

        // uint256 ethAmount = payable(address(this)).balance;
        uint256 tokenBalance = IERC20(Addresses.TokenB).balanceOf(address(this));
        uint256 ethAmount = IERC20(router.WETH()).balanceOf(address(this));

        address LP = Addresses.PairTokenA();

        // get liqudity balance to calcualte price
        uint256 liqEth = IERC20(router.WETH()).balanceOf(LP);
        uint256 liqToken = IERC20(Addresses.TokenB).balanceOf(LP);
        uint256 price = liqToken * (1000000) / (liqEth);

        // calcualte available token that can add to LP
        uint256 expToken = tokenBalance >= stake_reward ? tokenBalance - stake_reward : 0;

        // executed add Liquidity
        if (expToken > 0) {
            // calcualte equivalent ETH pair to expect token (with 20% buffer)
            uint256 expETH = expToken * (120) * (10000) / (price);       //expETH  = expToken * 120/100 * 1000000 /price

//            emit liquidity(ethAmount, tokenBalance, price);

            // only Add liquidity when there are enough ETH
            if (ethAmount >= expETH) {
                (uint256 tokenBAmount,uint256 ethAmount, uint256 liqAmount) = router.addLiquidity(
                    address(Addresses.TokenB),
                    router.WETH(),
                    expToken,
                    expETH,
                    0, // slippage is unavoidable
                    0, // slippage is unavoidable
                    address(this),
                    block.timestamp
                );
//                net_value = net_value + liqAmount;
            } else {
//                emit text_return("no available ETH to add");
            }
//            emit safe_check(tokenBalance, expToken, expETH, ethAmount);
        } else {
//            emit text_return("no available token to add");
        }

    }

    function ultraBurnTokenB(uint256 net_value, uint256 stake_reward) public {
        IUniswapV2Router02 router = IUniswapV2Router02(Addresses.UniswapV2Router02Address);
        (uint amountTokenB,uint amountEth) = router.removeLiquidity(
            Addresses.TokenB,//token
            router.WETH(),
            net_value,
            0,
            0,
            address(this),
            block.timestamp
        );
    }

    function passiveUnStake(bytes32 defender, bytes32 attacker) public {
        address defenderAddress = Utility.entityKeyToAddress(defender);
        address attackerAddress = Utility.entityKeyToAddress(attacker);
        uint256 limit = getStakeLimit(defenderAddress);
        uint256 totalStaked = PlayerStake.getTokenB(defenderAddress) + PlayerStake.getTokenC(defenderAddress);
        uint256 fee = GlobalConfig.getPassiveUnStakeFee();
        if (totalStaked > limit) {
            uint256 partB = PlayerStake.getTokenB(defenderAddress) * 100 / totalStaked * 100;
            uint256 partC = PlayerStake.getTokenC(defenderAddress) * 100 / totalStaked * 100;
            uint256 tokenUnStakedB = (totalStaked - limit) * partB / 100;
            uint256 tokenUnStakedC = (totalStaked - limit) * partC / 100;
            if (tokenUnStakedB > 0) {
                uint256 feeAmount = tokenUnStakedB * fee / 100;
                IERC20 tokenB = IERC20(Addresses.TokenB);
                PlayerStake.setTokenB(defenderAddress, PlayerStake.getTokenB(defenderAddress) - tokenUnStakedB);
                tokenB.transferFrom(address(this), defenderAddress, tokenUnStakedB - feeAmount);
                tokenB.transferFrom(address(this), attackerAddress, feeAmount);
            }
            if (tokenUnStakedC > 0) {
                uint256 feeAmount = tokenUnStakedC * fee / 100;
                IERC20 tokenC = IERC20(Addresses.TokenC);
                PlayerStake.setTokenC(defenderAddress, PlayerStake.getTokenC(defenderAddress) - tokenUnStakedC);
                tokenC.transferFrom(address(this), defenderAddress, tokenUnStakedC - feeAmount);
                tokenC.transferFrom(address(this), attackerAddress, feeAmount);
            }
        }
    }

    function getStakeLimit(address owner) view public returns (uint256){
        uint256 amount = 50000;
        bytes32 id = Utility.addressToEntityKey(owner);
        return (amount + PlayerDetail.getLands(id) * 50000);
    }
}