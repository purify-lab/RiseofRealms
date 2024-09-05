import {setup} from "./mud/setup";
import mudConfig from "../../contracts/mud.config";
import {mount as mountDevTools} from "@latticexyz/dev-tools";
import { stringify, parse } from 'flatted';


function convertFieldsToString(obj: Record<string, any>): Record<string, string> {
  const result: Record<string, string> = {};

  for (const key in obj) {
    if (typeof obj[key] === 'bigint' || typeof obj[key] === 'number') {
      result[key] = obj[key].toString();
    } else {
      result[key] = obj[key]; // 可以选择保留原始值，或根据需要处理其他类型
    }
  }

  return result;
}

class MudLib {
  increment: any

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
      console.log("Player updated", update)
      this.player_updated(stringify(convertFieldsToString(update)))
    })

    components.PlayerDetail.update$.subscribe((update) => {
      console.log("PlayerDetails updated", update)
      this.player_detail_updated(stringify(convertFieldsToString(update)))
    });

    components.Land.update$.subscribe((update) => {
      console.log("Land updated", update)
      this.land_updated(stringify(convertFieldsToString(update)))
    });

    components.Capital.update$.subscribe((update) => {
      console.log("Capital updated", update)
      this.capital_updated(stringify(convertFieldsToString(update)))
    });

    components.Army.update$.subscribe((update) => {
      console.log("Army updated", update)
      this.army_updated(stringify(convertFieldsToString(update)))
    });

    components.BattleReport.update$.subscribe((update) => {
      console.log("BattleReport updated", update)
      this.battle_report_updated(stringify(convertFieldsToString(update)))
    })

    network.storedBlockLogs$.subscribe((update) => {
      console.log("Stored block logs", update)
      this.stored_block_logs(stringify(convertFieldsToString(update)))
    });

    const blockNumber = await network.publicClient.getBlockNumber()
    return blockNumber;
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

  battle_report_updated(update:any){
  }

  stored_block_logs(update: any) {
  }
}

(window as any).mud = new MudLib()
