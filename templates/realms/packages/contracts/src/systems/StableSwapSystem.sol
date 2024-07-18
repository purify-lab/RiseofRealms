pragma solidity >=0.8.0;

import {System} from "@latticexyz/world/src/System.sol";
import {GlobalConfig, PlayerAirdrop} from "../codegen/index.sol";
import {Utility} from "../utility/utility.sol";
import {IERC20} from "../utility/IERC20.sol";

contract StableSwapSystem is System {

    address constant TokenA = 0x74f0Bf9321fF57a4028999bB88ca623cc9e79F14;
    address constant TokenB = 0x74f0Bf9321fF57a4028999bB88ca623cc9e79F14;
    address constant TokenC = 0x74f0Bf9321fF57a4028999bB88ca623cc9e79F14;

    function swapA2B(uint256 amount) public whenNotPaused {
        IERC20(TokenA).transferFrom(msg.sender, address(this), amount);
        IERC20(TokenB).transfer(msg.sender, amount);
    }

    function swapA2C(uint256 amount) public whenNotPaused {
        IERC20(TokenA).transferFrom(msg.sender, address(this), amount);
        IERC20(TokenC).transfer(msg.sender, amount);
    }

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