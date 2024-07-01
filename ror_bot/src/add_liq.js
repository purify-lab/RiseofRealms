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


const ETHER = Ether.onChain(1)
const WETH = new Token(1, '0x4200000000000000000000000000000000000006', 18, 'WETH', 'Wrapped Ether')
const USDC = new Token(1, '0xC6dD7d2374073d4C1a4de12eD54E0f436572f917', 6, 'USDC', 'USD Coin')

const wethContract = new ethers.Contract(WETH.address, erc20Abi, provider)
const usdcContract = new ethers.Contract(USDC.address, erc20Abi, provider)


async function getPool(tokenA, tokenB, feeAmount) {
    const [token0, token1] = tokenA.sortsBefore(tokenB) ? [tokenA, tokenB] : [tokenB, tokenA]

    const poolAddress = "0x9f82Dec2dB0Ae3657b574166Ac4B2D89c629F098";//Pool.getAddress(token0, token1, feeAmount)

    const contract = new ethers.Contract(poolAddress, IUniswapV3Pool.abi, provider)

    let liquidity = await contract.liquidity()

    let {sqrtPriceX96, tick} = await contract.slot0()

    liquidity = JSBI.BigInt(liquidity.toString())
    sqrtPriceX96 = JSBI.BigInt(sqrtPriceX96.toString())

    return new Pool(token0, token1, feeAmount, sqrtPriceX96, liquidity, tick, [
        {
            index: nearestUsableTick(TickMath.MIN_TICK, TICK_SPACINGS[feeAmount]),
            liquidityNet: liquidity,
            liquidityGross: liquidity,
        },
        {
            index: nearestUsableTick(TickMath.MAX_TICK, TICK_SPACINGS[feeAmount]),
            liquidityNet: JSBI.multiply(liquidity, JSBI.BigInt('-1')),
            liquidityGross: liquidity,
        },
    ])
}

const RECIPIENT = '0x74f0Bf9321fF57a4028999bB88ca623cc9e79F14'

async function getPoolState(poolContract) {
    const liquidity = await poolContract.liquidity();
    const slot = await poolContract.slot0();

    const PoolState = {
        liquidity,
        sqrtPriceX96: slot[0],
        tick: slot[1],
        observationIndex: slot[2],
        observationCardinality: slot[3],
        observationCardinalityNext: slot[4],
        feeProtocol: slot[5],
        unlocked: slot[6],
    };

    return PoolState;
}


async function addLiquidityToPool(
    poolAdd,
    signer,
    chainId,
    Token1_decimals,
    Token2_decimals,
    token_contract1,
    token_contract2,
    amount0, amount1,
    fee,
    npmca
) {
    const poolContract = new ethers.Contract(poolAdd, UNISWAP_V3_POOL_ABI, signer);
    var state = await getPoolState(poolContract);


    const Token1 = new Token(chainId, token_contract1.address, Token1_decimals);
    const Token2 = new Token(chainId, token_contract2.address, Token2_decimals);

    const configuredPool = new Pool(
        Token1,
        Token2,
        fee,
        state.sqrtPriceX96.toString(),
        state.liquidity.toString(),
        state.tick
    );

    const position = Position.fromAmounts({
        pool: configuredPool,
        tickLower:
            nearestUsableTick(configuredPool.tickCurrent, configuredPool.tickSpacing) -
            configuredPool.tickSpacing * 2,
        tickUpper:
            nearestUsableTick(configuredPool.tickCurrent, configuredPool.tickSpacing) +
            configuredPool.tickSpacing * 2,
        amount0: amount0.toString(),
        amount1: amount1.toString(),
        useFullPrecision: false,
    });

    const mintOptions = {
        recipient: signer.address,
        deadline: Math.floor(Date.now() / 1000) + 60 * 20,
        slippageTolerance: new Percent(50, 10_000),
    };

    const { calldata, value } = NonfungiblePositionManager.addCallParameters(position, mintOptions);

    const transaction = {
        data: calldata,
        to: npmca,
        value: value,
        from: signer.address,
        gasLimit: 10000000
    };
    console.log('Transacting');
    const txRes = await signer.sendTransaction(transaction);
    await txRes.wait();
    console.log('Added liquidity');
}

async function main() {
    const signer = new ethers.Wallet("fb61ae9ea723f1bff3f7bd183ffbaa730127d9a7ba4fab24340b64fb1904ee5f", provider);

    const poolAddress = "0x9f82Dec2dB0Ae3657b574166Ac4B2D89c629F098";
    const chainID = 1;
    const token0Decimals = WETH.decimals;
    const token1Decimals = USDC.decimals;
    const token0 = WETH;
    const token1 = USDC;
    const fee=500;
    const npmca = "0xa46F04F08Ea3AA4e1D22dFEe7f1C014C85Fc2EF9";
    const amount0 = ethers.utils.parseUnits('0.0000001', token0Decimals);
    const amount1 = ethers.utils.parseUnits('1', token1Decimals);


    await addLiquidityToPool(poolAddress, signer, chainID, token0Decimals, token1Decimals, token0, token1, amount0, amount1, fee, npmca);


}


main()
    .then(() => process.exit(0))
    .catch((error) => {
        console.error(error);
        process.exit(1);
    });