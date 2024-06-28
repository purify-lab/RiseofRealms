const { SwapRouter } = require('@uniswap/universal-router-sdk')
const { TradeType, Ether, Token, CurrencyAmount, Percent } = require('@uniswap/sdk-core')
const { Trade: V2Trade } = require('@uniswap/v2-sdk')
const { Pool, nearestUsableTick, TickMath, TICK_SPACINGS, FeeAmount, Trade: V3Trade, Route: RouteV3  } = require('@uniswap/v3-sdk')
const { MixedRouteTrade, Trade: RouterTrade } = require('@uniswap/router-sdk')
const IUniswapV3Pool = require('@uniswap/v3-core/artifacts/contracts/UniswapV3Pool.sol/UniswapV3Pool.json')
const JSBI = require('jsbi')
const erc20Abi = require('../abi/erc20.json')


// const hardhat = require("hardhat");
const ethers = require("ethers");
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

    let { sqrtPriceX96, tick } = await contract.slot0()

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


function swapOptions(options) {
    return Object.assign(
        {
            slippageTolerance: new Percent(5, 100),
            recipient: RECIPIENT,
        },
        options
    )
}


function buildTrade(trades) {
    return new RouterTrade({
        v2Routes: trades
            .filter((trade) => trade instanceof V2Trade)
            .map((trade) => ({
                routev2: trade.route,
                inputAmount: trade.inputAmount,
                outputAmount: trade.outputAmount,
            })),
        v3Routes: trades
            .filter((trade) => trade instanceof V3Trade)
            .map((trade) => ({
                routev3: trade.route,
                inputAmount: trade.inputAmount,
                outputAmount: trade.outputAmount,
            })),
        mixedRoutes: trades
            .filter((trade) => trade instanceof MixedRouteTrade)
            .map((trade) => ({
                mixedRoute: trade.route,
                inputAmount: trade.inputAmount,
                outputAmount: trade.outputAmount,
            })),
        tradeType: trades[0].tradeType,
    })
}


const RECIPIENT = '0x74f0Bf9321fF57a4028999bB88ca623cc9e79F14'


async function main() {
    const signer = new ethers.Wallet("fb61ae9ea723f1bff3f7bd183ffbaa730127d9a7ba4fab24340b64fb1904ee5f",provider);

    const WETH_USDC_V3 = await getPool(WETH, USDC, FeeAmount.LOW)

    const inputEther = ethers.utils.parseEther('1000').toString()

    const router =  new RouteV3([WETH_USDC_V3], USDC,WETH);
    const trade = await V3Trade.fromRoute(
        router,
        CurrencyAmount.fromRawAmount(USDC, inputEther),
        TradeType.EXACT_INPUT
    )

    const routerTrade = buildTrade([trade])

    const opts = swapOptions({})

    const params = SwapRouter.swapERC20CallParameters(routerTrade, opts)

    let ethBalance
    let wethBalance
    let usdcBalance
    ethBalance = await provider.getBalance(RECIPIENT)
    wethBalance = await wethContract.balanceOf(RECIPIENT)
    usdcBalance = await usdcContract.balanceOf(RECIPIENT)
    console.log('---------------------------- BEFORE')
    console.log('ethBalance', ethers.utils.formatUnits(ethBalance, 18))
    console.log('wethBalance', ethers.utils.formatUnits(wethBalance, 18))
    console.log('usdcBalance', ethers.utils.formatUnits(usdcBalance, 6))

    const tx = await signer.sendTransaction({
        data: params.calldata,
        to: '0x02b36A5aCa3e51d2E73926E3D3bB59C979B60C78',
        value: params.value,
        from: RECIPIENT,
        gasLimit: 1000000 // Increase the gas limit
    })

    const receipt = await tx.wait()
    console.log('---------------------------- SUCCESS?')
    console.log('status', receipt.status)

    ethBalance = await provider.getBalance(RECIPIENT)
    wethBalance = await wethContract.balanceOf(RECIPIENT)
    usdcBalance = await usdcContract.balanceOf(RECIPIENT)
    console.log('---------------------------- AFTER')
    console.log('ethBalance', ethers.utils.formatUnits(ethBalance, 18))
    console.log('wethBalance', ethers.utils.formatUnits(wethBalance, 18))
    console.log('usdcBalance', ethers.utils.formatUnits(usdcBalance, 6))
}


/*
    node scripts/01_simpleSwap.js
*/



main()
    .then(() => process.exit(0))
    .catch((error) => {
        console.error(error);
        process.exit(1);
    });