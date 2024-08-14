pragma solidity >=0.8.0;

import {System} from "@latticexyz/world/src/System.sol";
import {GlobalConfig, PlayerAirdrop} from "../codegen/index.sol";
import {Utility} from "../utility/utility.sol";
import {IERC20} from "../utility/IERC20.sol";
import {IUniswapV2Router02} from "../utility/IUniswapV2Router02.sol";
import {IToken} from "../utility/IToken.sol";

contract TokenManagerSystem is System {

    address constant TokenA = 0x74f0Bf9321fF57a4028999bB88ca623cc9e79F14;
    address constant TokenB = 0x74f0Bf9321fF57a4028999bB88ca623cc9e79F14;
    address constant TokenC = 0x74f0Bf9321fF57a4028999bB88ca623cc9e79F14;
    address constant WETH = 0x4200000000000000000000000000000000000006;
    address constant UniswapV2Router02Address = 0xf9E6284f46E40c91F31dCe60A79d7aEb243afF6B;
    address constant TokenBPair = 0x74f0Bf9321fF57a4028999bB88ca623cc9e79F14;

    function UltraMintB(uint256 net_value) public {

        IToken(TokenB).mint(address(this), net_value);
        IERC20(TokenB).approve(UniswapV2Router02Address,net_value);

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

}