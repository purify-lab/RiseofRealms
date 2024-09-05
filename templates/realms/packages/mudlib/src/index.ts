import {setup} from "./mud/setup";
import mudConfig from "../../contracts/mud.config";
import {mount as mountDevTools} from "@latticexyz/dev-tools";

class MudLib {
  async setup() {
    const {
      components,
      systemCalls: {
        spawnPlayer, spawnCapital,
        marchArmy, attack, garrison,
        buyInfantry, buyCavalryA, buyCavalryB, buyCavalryC,
        stakeTokenB, stakeTokenC, unStakeTokenB, unStakeTokenC, farming,
        setMerkleRoot, claim, swapA2B, swapA2C, withdrawToken,
      },
      network,
    } = await setup();

    const setupBlockNumber = await network.publicClient.getBlockNumber()

    this.spawnPlayer = spawnPlayer;
    this.spawnCapital = spawnCapital;
    this.marchArmy = marchArmy;
    this.attack = attack;
    this.garrison = garrison;
    this.buyInfantry = buyInfantry;
    this.buyCavalryA = buyCavalryA;
    this.buyCavalryB = buyCavalryB;
    this.buyCavalryC = buyCavalryC;
    this.stakeTokenB = stakeTokenB;
    this.stakeTokenC = stakeTokenC;
    this.unStakeTokenB = unStakeTokenB;
    this.unStakeTokenC = unStakeTokenC;
    this.farming = farming;
    this.setMerkleRoot = setMerkleRoot;
    this.claim = claim;
    this.swapA2B = swapA2B;
    this.swapA2C = swapA2C;
    this.withdrawToken = withdrawToken;


    // this.increment = increment
    // mountDevTools({
    //   config: mudConfig,
    //   publicClient: network.publicClient,
    //   walletClient: network.walletClient,
    //   latestBlock$: network.latestBlock$,
    //   blockStorageOperations$: network.blockStorageOperations$,
    //   worldAddress: network.worldContract.address,
    //   worldAbi: network.worldContract.abi,
    //   write$: network.write$,
    //   recsWorld: network.world,
    // });

    // console.log("mudConfig",mudConfig)


    mountDevTools({
      config: mudConfig,
      publicClient: network.publicClient,
      walletClient: network.walletClient,
      latestBlock$: network.latestBlock$,
      storedBlockLogs$: network.storedBlockLogs$,
      worldAddress: network.worldContract.address,
      worldAbi: network.worldContract.abi,
      write$: network.write$,
      // tables:mudConfig.tables
      useStore: network.useStore,
    });

    this.network = network;

    // Components expose a stream that triggers when the component is updated.

    components.Player.update$.subscribe((update) => {
      const timestamp = new Date().toISOString(); // 获取当前时间戳
      console.log(`${timestamp} -Player updated`, update)
      this.player_updated(({
        entity: update.entity,
        value: update.value
      }))
    })

    components.PlayerDetail.update$.subscribe((update) => {
      const timestamp = new Date().toISOString(); // 获取当前时间戳
      console.log(`${timestamp} -PlayerDetails updated`, update)
      this.player_detail_updated(({
        entity: update.entity,
        value: update.value
      }))
    });

    components.Land.update$.subscribe((update) => {
      const timestamp = new Date().toISOString(); // 获取当前时间戳
      console.log(`${timestamp} -Land updated`, update)
      this.land_updated(({
        entity: update.entity,
        value: update.value
      }))
    });

    components.Capital.update$.subscribe((update) => {
      const timestamp = new Date().toISOString(); // 获取当前时间戳
      console.log(`${timestamp} -Capital updated`, update)
      this.capital_updated(({
        entity: update.entity,
        value: update.value
      }))
    });

    components.Army.update$.subscribe((update) => {
      const timestamp = new Date().toISOString(); // 获取当前时间戳
      console.log(`${timestamp} -Army updated`, update)
      this.army_updated(({
        entity: update.entity,
        value: update.value
      }))
    });

    components.BattleReport.update$.subscribe((update) => {
      const timestamp = new Date().toISOString(); // 获取当前时间戳
      console.log(`${timestamp} -BattleReport updated`, update)
      this.battle_report_updated(({
        entity: update.entity,
        value: update.value
      }))
    })

    let all_catch_up = false;

    network.storedBlockLogs$.subscribe((update) => {
      if (!all_catch_up && update.blockNumber >= setupBlockNumber) {
        all_catch_up = true;
        setTimeout(() => {
          const timestamp = new Date().toISOString(); // 获取当前时间戳
          console.log(`${timestamp} -all catch up`, setupBlockNumber, '=>', update.blockNumber);
          this.all_catch_up({})
        }, 2000);
      }

      // console.log("Stored block logs", update)
      //   this.stored_block_logs(({
      //     blockNumber: (Number)(update.blockNumber.toString())
      //   }))
    });
    //
    // // return blockNumber;
    //
    // console.log("setup block logs", update)
    // this.setup_block(({
    //   blockNumber: (Number)(blockNumber.toString())
    // }));
  }


  // To be overwritten by Godot callback
  player_updated(update: any) {
  }

  player_detail_updated(update: any) {
  }

  land_updated(update: any) {
  }

  capital_updated(update: any) {
  }

  army_updated(update: any) {
  }

  battle_report_updated(update: any) {
  }

  stored_block_logs(update: any) {
  }

  setup_block(update: any) {

  }

  all_catch_up(update: any) {

  }
}

(window as any).mud = new MudLib()
