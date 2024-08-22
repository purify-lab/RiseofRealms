pragma solidity >=0.8.0;

import {System} from "@latticexyz/world/src/System.sol";
import {GlobalConfig, PlayerAirdrop} from "../codegen/index.sol";
import {Utility} from "../utility/utility.sol";
import {IERC20} from "../utility/IERC20.sol";
import {IUniswapV2Router02} from "../utility/IUniswapV2Router02.sol";
import {IUniswapV2Factory} from "../utility/IUniswapV2Factory.sol";
import {IToken} from "../utility/IToken.sol";

contract TokenManagerSystem is System {

    address constant TokenA = 0x74f0Bf9321fF57a4028999bB88ca623cc9e79F14;
    address constant TokenB = 0x74f0Bf9321fF57a4028999bB88ca623cc9e79F14;
    address constant TokenC = 0x74f0Bf9321fF57a4028999bB88ca623cc9e79F14;
    address constant WETH = 0x4200000000000000000000000000000000000006;
    address constant UniswapV2Router02Address = 0xf9E6284f46E40c91F31dCe60A79d7aEb243afF6B;
    address constant Factory = 0x3B6cd946C2cCE6B827740dc9eEA76d4CC674b6af;
    address constant TokenBPair = 0x74f0Bf9321fF57a4028999bB88ca623cc9e79F14;

    function initAllow() public {
        IERC20(TokenB).approve(UniswapV2Router02Address, type(uint256).max);
        IERC20(WETH).approve(UniswapV2Router02Address, type(uint256).max);

        address tokenBLP = IUniswapV2Factory(Factory).getPair(TokenB, WETH);
        IERC20(tokenBLP).approve(UniswapV2Router02Address, type(uint256).max);

        address tokenCLP = IUniswapV2Factory(Factory).getPair(TokenC, WETH);
        IERC20(tokenCLP).approve(UniswapV2Router02Address, type(uint256).max);

//        IERC20(LP).approve(UniswapV2Router02Address, type(uint256).max);
    }

    function UltraMintB(uint256 net_value) public {

        IToken(TokenB).mint(address(this), net_value);
        IERC20(TokenB).approve(UniswapV2Router02Address, net_value);

        address[] memory path = new address[](2);
        path[0] = TokenB;
        path[1] = WETH;

        IUniswapV2Router02 router = IUniswapV2Router02(UniswapV2Router02Address);
        uint[] memory amounts = router.swapExactTokensForETH(net_value * 100 / 60, 0, path, address(this), block.timestamp + 600);
//        return amounts;

//        router.addLiquidity(
//
//        );
    }

    function calculateLPAddress() public view returns (address) {
        return IUniswapV2Factory(Factory).getPair(TokenB, WETH);
    }
}