const {SwapRouter} = require('@uniswap/universal-router-sdk')
const {TradeType, Ether, Token, CurrencyAmount, Percent} = require('@uniswap/sdk-core')
const {Trade: V2Trade} = require('@uniswap/v2-sdk')
const {
    NonfungiblePositionManager,
    Position,
    Pool,
    nearestUsableTick,
    TickMath,
    TICK_SPACINGS,
    FeeAmount,
    Trade: V3Trade,
    Route: RouteV3
} = require('@uniswap/v3-sdk')
const {MixedRouteTrade, Trade: RouterTrade} = require('@uniswap/router-sdk')
const IUniswapV3Pool = require('@uniswap/v3-core/artifacts/contracts/UniswapV3Pool.sol/UniswapV3Pool.json')
const JSBI = require('jsbi')
const erc20Abi = require('../abi/erc20.json')
const INonfungiblePositionManagerABI = require('@uniswap/v3-periphery/artifacts/contracts/interfaces/INonfungiblePositionManager.sol/INonfungiblePositionManager.json').abi;

// const hardhat = require("hardhat");
const ethers = require("ethers");
const {BigNumber} = ethers;
const abis = require('./abis');
const UNISWAP_V3_POOL_ABI = abis.UNISWAP_V3_POOL_ABI

const provider = new ethers.providers.JsonRpcProvider("https://rpc.garnet.qry.live/");


const WETH = new Token(1, '0x4200000000000000000000000000000000000006', 18, 'WETH', 'Wrapped Ether')
const USDC = new Token(1, '0xC6dD7d2374073d4C1a4de12eD54E0f436572f917', 6, 'USDC', 'USD Coin')


//移除流动性

const collectOptions = {
    expectedCurrencyOwed0: CurrencyAmount.fromRawAmount(
        WETH,
        0
    ),
    expectedCurrencyOwed1: CurrencyAmount.fromRawAmount(
        USDC,
        0
    ),
    recipient: address,
}

const removeLiquidityOptions = {
    deadline: Math.floor(Date.now() / 1000) + 60 * 20,
    slippageTolerance: new Percent(50, 10_000),
    tokenId: positionId,
    // percentage of liquidity to remove
    liquidityPercentage: new Percent(0.5),
    collectOptions,
}

const amount0 = fromReadableAmount(
    readableAmount0 * fractionToAdd,
    WETH.decimals
)
const amount1 = fromReadableAmount(
    readableAmount1 * fractionToAdd,
    USDC.decimals
)

const currentPosition = constructPosition(
    amount0,
    amount1
)

const {calldata, value} = NonfungiblePositionManager.removeCallParameters(
    currentPosition,
    removeLiquidityOptions
)

async function removeLiquidityFromPool() {

}