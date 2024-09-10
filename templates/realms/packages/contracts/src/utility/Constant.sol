// SPDX-License-Identifier: MIT
pragma solidity >=0.8.21;

import "./IUniswapV2Factory.sol";

library Addresses {
    address constant WETH = 0x4200000000000000000000000000000000000006;
    address constant UniswapV2Router02Address = 0xf9E6284f46E40c91F31dCe60A79d7aEb243afF6B;
    address constant Factory = 0x3B6cd946C2cCE6B827740dc9eEA76d4CC674b6af;

    address constant TokenA = 0x88b985C5515B646D5ae4afc56d0855051cea5b48;
    address constant TokenB = 0x15772ec0dAd7848f243Ab4eAe022FfF2D642f078;
    address constant TokenC = 0x4444426ae66Efca568B519fF5c2Fd0351D0674fB;

    function PairTokenA() public view returns (address){
        return IUniswapV2Factory(Factory).getPair(TokenA, WETH);
    }

    function PairTokenB() public view returns (address){
        return IUniswapV2Factory(Factory).getPair(TokenB, WETH);
    }

    function PairTokenC() public view returns (address){
        return IUniswapV2Factory(Factory).getPair(TokenC, WETH);
    }
}