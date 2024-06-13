// SPDX-License-Identifier: MIT
pragma solidity >=0.8.21;
import { Script } from "forge-std/Script.sol";
import { IWorld } from "../src/codegen/world/IWorld.sol";

contract PostDeploy is Script {
  function run(address worldAddress) external {
    // Load the private key from the `PRIVATE_KEY` environment variable (in .env)
    uint256 deployerPrivateKey = vm.envUint("PRIVATE_KEY");
//    uint256 deployerPrivateKey = 0xfb61ae9ea723f1bff3f7bd183ffbaa730127d9a7ba4fab24340b64fb1904ee5f;

    // Start broadcasting transactions from the deployer account
    vm.startBroadcast(deployerPrivateKey);

    // ------------------ Add world spawn code ------------------
    IWorld world = IWorld(worldAddress);
    world.spawnToad(0,0,0);

    vm.stopBroadcast();
  }
}