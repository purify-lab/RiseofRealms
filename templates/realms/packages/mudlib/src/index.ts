import {setup} from "./mud/setup";
import mudConfig from "../../contracts/mud.config";
import {mount as mountDevTools} from "@latticexyz/dev-tools";
import {ethers} from "ethers";

class MudLib {
  public spawnPlayer: (() => Promise<void>) | undefined;
  public spawnCapital: ((capital_id: number) => Promise<void>) | undefined;
  public marchArmy: ((destination: number, infantry: number, cavalryA: number, cavalryB: number, cavalryC: number, army_id: number) => Promise<void>) | undefined;
  public attack: ((army_id: number) => Promise<void>) | undefined;
  public buyInfantry: ((amount: number) => Promise<void>) | undefined;
  public garrison: ((capital_id: number, infantry: number, cavalryA: number, cavalryB: number, cavalryC: number) => Promise<void>) | undefined;
  public buyCavalryA: ((amount: number) => Promise<void>) | undefined;
  public buyCavalryB: ((amount: number) => Promise<void>) | undefined;
  public buyCavalryC: ((amount: number) => Promise<void>) | undefined;
  public stakeTokenB: ((amount: number) => Promise<void>) | undefined;
  public stakeTokenC: ((amount: number) => Promise<void>) | undefined;
  public unStakeTokenB: ((staker: string, amount: number) => Promise<void>) | undefined;
  public unStakeTokenC: ((staker: string, amount: number) => Promise<void>) | undefined;
  public farming: ((capital_id: number) => Promise<void>) | undefined;

  public network: any;

  async setup() {
    const {
      components,
      systemCalls: {
        spawnPlayer, spawnCapital,
        marchArmy, attack, garrison,
        buyInfantry, buyCavalryA, buyCavalryB, buyCavalryC,
        stakeTokenB, stakeTokenC, unStakeTokenB, unStakeTokenC, farming,
        setMerkleRoot, claim, swapA2B, swapA2C, withdrawToken,
        transactionTokenA, transactionTokenB, transactionTokenC, approveTokenA,
      },
      network,
    } = await setup();

    async function checkBalance(token: any, address: string) {
      const balance = await token.read.balanceOf([address]);
      return balance;
    }

    const wallet_address = network.walletClient.account.address;

    let token_a_balance = -1;
    let token_b_balance = -1;
    let token_c_balance = -1;

    setInterval(async () => {
      const timestamp = new Date().toISOString(); // 获取当前时间戳
      const now_token_a_balance = (Number)(ethers.utils.formatUnits(await checkBalance(network.tokenAContract, wallet_address), 18));
      if (now_token_a_balance != token_a_balance) {
        token_a_balance = now_token_a_balance;
        console.log(`${timestamp} - tokena updated`, token_a_balance)
        this.tokena_updated(token_a_balance)
      }

      const now_token_b_balance = (Number)(ethers.utils.formatUnits(await checkBalance(network.tokenBContract, wallet_address), 18));
      if (now_token_b_balance != token_b_balance) {
        token_b_balance = now_token_b_balance;
        console.log(`${timestamp} - tokenb updated`, token_b_balance)
        this.tokenb_updated(token_b_balance)
      }

      const now_token_c_balance = (Number)(ethers.utils.formatUnits(await checkBalance(network.tokenCContract, wallet_address), 18));
      if (now_token_c_balance != token_c_balance) {
        token_c_balance = now_token_c_balance;
        console.log(`${timestamp} - tokenc updated`, token_c_balance)
        this.tokenc_updated(token_c_balance)
      }

    }, 3000);


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
    this.transactionTokenA = transactionTokenA;
    this.transactionTokenB = transactionTokenB;
    this.transactionTokenC = transactionTokenC;
    this.approveTokenA = approveTokenA;


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
  // eslint-disable-next-line @typescript-eslint/no-empty-function
  player_updated(update: any) {
  }
  // eslint-disable-next-line @typescript-eslint/no-empty-function
  player_detail_updated(update: any) {
  }
  // eslint-disable-next-line @typescript-eslint/no-empty-function
  land_updated(update: any) {
  }
  // eslint-disable-next-line @typescript-eslint/no-empty-function
  capital_updated(update: any) {
  }
  // eslint-disable-next-line @typescript-eslint/no-empty-function
  army_updated(update: any) {
  }
  // eslint-disable-next-line @typescript-eslint/no-empty-function
  battle_report_updated(update: any) {
  }
  // eslint-disable-next-line @typescript-eslint/no-empty-function
  stored_block_logs(update: any) {
  }
  // eslint-disable-next-line @typescript-eslint/no-empty-function
  setup_block(update: any) {

  }
  // eslint-disable-next-line @typescript-eslint/no-empty-function
  all_catch_up(update: any) {

  }
  // eslint-disable-next-line @typescript-eslint/no-empty-function
  tokena_updated(update: any) {

  }
  // eslint-disable-next-line @typescript-eslint/no-empty-function
  tokenb_updated(update: any) {

  }
  // eslint-disable-next-line @typescript-eslint/no-empty-function
  tokenc_updated(updated: any) {

  }
}

(window as any).mud = new MudLib()
