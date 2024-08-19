// SPDX-License-Identifier: MIT
// Compatible with OpenZeppelin Contracts ^5.0.0
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Burnable.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/math/SafeMath.sol";


contract MyToken is ERC20, ERC20Burnable, Ownable {
    constructor()
    ERC20("MyToken", "MTK")
    Ownable(msg.sender)
    {}

    function mint(address to, uint256 amount) public {
        _mint(to, amount);
    }
}


interface IToken {
    function mint(address to, uint256 value) external;
}


interface IUniswapV2Router01 {
    function factory() external pure returns (address);

    function WETH() external pure returns (address);

    function addLiquidity(
        address tokenA,
        address tokenB,
        uint amountADesired,
        uint amountBDesired,
        uint amountAMin,
        uint amountBMin,
        address to,
        uint deadline
    ) external returns (uint amountA, uint amountB, uint liquidity);

    function addLiquidityETH(
        address token,
        uint amountTokenDesired,
        uint amountTokenMin,
        uint amountETHMin,
        address to,
        uint deadline
    ) external payable returns (uint amountToken, uint amountETH, uint liquidity);

    function removeLiquidity(
        address tokenA,
        address tokenB,
        uint liquidity,
        uint amountAMin,
        uint amountBMin,
        address to,
        uint deadline
    ) external returns (uint amountA, uint amountB);

    function removeLiquidityETH(
        address token,
        uint liquidity,
        uint amountTokenMin,
        uint amountETHMin,
        address to,
        uint deadline
    ) external returns (uint amountToken, uint amountETH);

    function removeLiquidityWithPermit(
        address tokenA,
        address tokenB,
        uint liquidity,
        uint amountAMin,
        uint amountBMin,
        address to,
        uint deadline,
        bool approveMax, uint8 v, bytes32 r, bytes32 s
    ) external returns (uint amountA, uint amountB);

    function removeLiquidityETHWithPermit(
        address token,
        uint liquidity,
        uint amountTokenMin,
        uint amountETHMin,
        address to,
        uint deadline,
        bool approveMax, uint8 v, bytes32 r, bytes32 s
    ) external returns (uint amountToken, uint amountETH);

    function swapExactTokensForTokens(
        uint amountIn,
        uint amountOutMin,
        address[] calldata path,
        address to,
        uint deadline
    ) external returns (uint[] memory amounts);

    function swapTokensForExactTokens(
        uint amountOut,
        uint amountInMax,
        address[] calldata path,
        address to,
        uint deadline
    ) external returns (uint[] memory amounts);

    function swapExactETHForTokens(uint amountOutMin, address[] calldata path, address to, uint deadline)
    external
    payable
    returns (uint[] memory amounts);

    function swapTokensForExactETH(uint amountOut, uint amountInMax, address[] calldata path, address to, uint deadline)
    external
    returns (uint[] memory amounts);

    function swapExactTokensForETH(uint amountIn, uint amountOutMin, address[] calldata path, address to, uint deadline)
    external
    returns (uint[] memory amounts);

    function swapETHForExactTokens(uint amountOut, address[] calldata path, address to, uint deadline)
    external
    payable
    returns (uint[] memory amounts);

    function quote(uint amountA, uint reserveA, uint reserveB) external pure returns (uint amountB);

    function getAmountOut(uint amountIn, uint reserveIn, uint reserveOut) external pure returns (uint amountOut);

    function getAmountIn(uint amountOut, uint reserveIn, uint reserveOut) external pure returns (uint amountIn);

    function getAmountsOut(uint amountIn, address[] calldata path) external view returns (uint[] memory amounts);

    function getAmountsIn(uint amountOut, address[] calldata path) external view returns (uint[] memory amounts);
}


interface IUniswapV2Router02 is IUniswapV2Router01 {
    function removeLiquidityETHSupportingFeeOnTransferTokens(
        address token,
        uint liquidity,
        uint amountTokenMin,
        uint amountETHMin,
        address to,
        uint deadline
    ) external returns (uint amountETH);

    function removeLiquidityETHWithPermitSupportingFeeOnTransferTokens(
        address token,
        uint liquidity,
        uint amountTokenMin,
        uint amountETHMin,
        address to,
        uint deadline,
        bool approveMax, uint8 v, bytes32 r, bytes32 s
    ) external returns (uint amountETH);

    function swapExactTokensForTokensSupportingFeeOnTransferTokens(
        uint amountIn,
        uint amountOutMin,
        address[] calldata path,
        address to,
        uint deadline
    ) external;

    function swapExactETHForTokensSupportingFeeOnTransferTokens(
        uint amountOutMin,
        address[] calldata path,
        address to,
        uint deadline
    ) external payable;

    function swapExactTokensForETHSupportingFeeOnTransferTokens(
        uint amountIn,
        uint amountOutMin,
        address[] calldata path,
        address to,
        uint deadline
    ) external;
}

interface IUniswapV2Factory {
    event PairCreated(address indexed token0, address indexed token1, address pair, uint);

    function feeTo() external view returns (address);

    function feeToSetter() external view returns (address);

    function getPair(address tokenA, address tokenB) external view returns (address pair);

    function allPairs(uint) external view returns (address pair);

    function allPairsLength() external view returns (uint);

    function createPair(address tokenA, address tokenB) external returns (address pair);

    function setFeeTo(address) external;

    function setFeeToSetter(address) external;
}

contract mud {
    using SafeMath for uint256;

    address constant TokenB = 0x6f780376B0b9C47b45fae617d74c5a0359cbBA11;
    address constant WETH = 0x4200000000000000000000000000000000000006;
    address constant UniswapV2Router02Address = 0xf9E6284f46E40c91F31dCe60A79d7aEb243afF6B;
    address constant LP = 0x7FdF6430FFd7e108320Fc527b2b64E31f67d0dEE;
    address constant Factory = 0x3B6cd946C2cCE6B827740dc9eEA76d4CC674b6af;

    constructor()
    {
        IERC20(TokenB).approve(UniswapV2Router02Address, type(uint256).max);
        IERC20(WETH).approve(UniswapV2Router02Address, type(uint256).max);
        IERC20(LP).approve(UniswapV2Router02Address, type(uint256).max);
    }

    event liquidity(uint256 ETH, uint256 Token, uint Price);
    event safe_check(uint256 tokenBalance, uint256 lpToken, uint256 expETH, uint256 ethAmount);
    event text_return(string);

    function ultraMint(uint256 net_value, uint256 stake_reward) public {
        IToken(TokenB).mint(address(this), net_value);

        IUniswapV2Router02 router = IUniswapV2Router02(UniswapV2Router02Address);

        address[] memory path = new address[](2);
        path[0] = TokenB;
        path[1] = router.WETH();

        // 60% swap to WETH, 40% remain as stake reward
        router.swapExactTokensForTokensSupportingFeeOnTransferTokens(
            net_value * 6 / 10, 0, path, address(this), block.timestamp);

        // uint256 ethAmount = payable(address(this)).balance;
        uint256 tokenBalance = IERC20(TokenB).balanceOf(address(this));
        uint256 ethAmount = IERC20(router.WETH()).balanceOf(address(this));

        // get liqudity balance to calcualte price
        uint256 liqEth = IERC20(router.WETH()).balanceOf(LP);
        uint256 liqToken = IERC20(TokenB).balanceOf(LP);
        uint256 price = liqToken.mul(1000000).div(liqEth);

        // calcualte available token that can add to LP
        uint256 expToken = tokenBalance >= stake_reward ? tokenBalance.sub(stake_reward) : 0;

        // executed add Liquidity
        if (expToken > 0) {
            // calcualte equivalent ETH pair to expect token (with 20% buffer)
            uint256 expETH = expToken.mul(120).mul(10000).div(price);       //expETH  = expToken * 120/100 * 1000000 /price

            emit liquidity(ethAmount, tokenBalance, price);

            // only Add liquidity when there are enough ETH
            if (ethAmount >= expETH) {
                (uint256 tokenBAmount, ethAmount, liqAmount) = router.addLiquidity(
            address(TokenB),
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
                emit text_return("no available ETH to add");
            }
            emit safe_check(tokenBalance, expToken, expETH, ethAmount);
        } else {
            emit text_return("no available token to add");
        }

    }


    event EventUltraBurn(uint amountTokenB, uint amountEth);

    function ultraBurn(uint256 net_value, uint256 stake_reward) public {
        IUniswapV2Router02 router = IUniswapV2Router02(UniswapV2Router02Address);
        (uint amountTokenB,uint amountEth) = router.removeLiquidity(
            TokenB,//token
            router.WETH(),
            net_value,
            0,
            0,
            address(this),
            block.timestamp
        );

        emit EventUltraBurn(amountTokenB, amountEth);
    }

    function calculateLPAddress() public view returns (address) {
        return IUniswapV2Factory(Factory).getPair(TokenB, WETH);
    }

    function getLpAmount() public view returns (uint256){
        address lp = calculateLPAddress();
        return IERC20(lp).balanceOf(address(this));
    }


    int256 public net_value;

    //token b 的总质押量
    uint256 public stakeTokenB;

    //每个钱包分别的质押量
    mapping(address => uint) public stakedTokenB;

    function setNetValue(int256 amount) public {
        net_value = amount;
    }

    function getAbsoluteValue(int256 value) public pure returns (uint256) {
        if (value < 0) {
            return uint256(- value);
        } else {
            return uint256(value);
        }
    }

    function stake(uint tokenBAmount, uint256 getreward) public {
        IERC20(TokenB).transferFrom(msg.sender, address(this), tokenBAmount);
        stakedTokenB[msg.sender] += tokenBAmount;
        stakeTokenB += tokenBAmount;
//        net_value+= tokenBAmount;

        if (net_value > 0) {
            ultraMint(getAbsoluteValue(net_value), getreward);
        } else {
            ultraBurn(getAbsoluteValue(net_value), getreward);
        }
    }

    function getReward() public {

    }
    // receive() external payable {}
}