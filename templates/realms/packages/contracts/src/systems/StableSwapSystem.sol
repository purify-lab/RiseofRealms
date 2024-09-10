pragma solidity >=0.8.0;

import {System} from "@latticexyz/world/src/System.sol";
import {GlobalConfig, PlayerAirdrop} from "../codegen/index.sol";
import {Utility} from "../utility/utility.sol";
import {IERC20} from "../utility/IERC20.sol";
import {IUniswapV2Router02} from "../utility/IUniswapV2Router02.sol";
import {Addresses} from "../utility/Constant.sol";

contract StableSwapSystem is System {

    address constant UniswapV2Router02Address = 0xf9E6284f46E40c91F31dCe60A79d7aEb243afF6B;

    function swapA2B(uint256 amount) public whenNotPaused {
        IERC20(Addresses.TokenA).transferFrom(msg.sender, address(this), amount);
        IERC20(Addresses.TokenB).transfer(msg.sender, amount);
    }

    function swapA2C(uint256 amount) public whenNotPaused {
        IERC20(Addresses.TokenA).transferFrom(msg.sender, address(this), amount);
        IERC20(Addresses.TokenC).transfer(msg.sender, amount);
    }

//    function addLiq(){
//        IUniswapV2Router02(UniswapV2Router02Address).addLiquidityETH(
//
//        );
//
//        IUniswapV2Router02(UniswapV2Router02Address).removeLiquidityETH()(
//
//        );
//
//        IUniswapV2Router02(UniswapV2Router02Address).swapETHForExactTokens(
//
//        );

//    }

    bool public paused;

    modifier whenNotPaused() {
        require(!paused, "Contract is paused");
        _;
    }

    modifier onlyOwner() {
        require(_msgSender() == GlobalConfig.getOwner(), "Only the contract owner can call this function.");
        _;
    }

    function pause() public onlyOwner {
        paused = true;
    }

    function unpause() public onlyOwner {
        paused = false;
    }

    function withdrawToken(address tokenAddress, uint256 amount) public onlyOwner {
        IERC20 token = IERC20(tokenAddress);
        require(token.balanceOf(address(this)) >= amount, "Insufficient token balance");
        token.transfer(GlobalConfig.getOwner(), amount);
    }
}