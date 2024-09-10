import {
  createPublicClient,
  fallback,
  webSocket,
  http,
  createWalletClient,
  Hex,
  parseEther,
  ClientConfig,
  getContract
} from "viem";
import {createFaucetService} from "@latticexyz/services/faucet";
import {encodeEntity, syncToRecs} from "@latticexyz/store-sync/recs";
import {getNetworkConfig} from "./getNetworkConfig";
import {world} from "./world";
import IWorldAbi from "../../../contracts/out/IWorld.sol/IWorld.abi.json";
import IERC20Abi from "../../../contracts/out/IERC20.sol/IERC20.abi.json";
import {createBurnerAccount, transportObserver, ContractWrite, createContract} from "@latticexyz/common";
import {Subject, share} from "rxjs";
import mudConfig from "../../../contracts/mud.config";
import {transactionQueue, writeObserver} from "@latticexyz/common/actions";
import {syncToZustand} from "@latticexyz/store-sync/zustand";

export type SetupNetworkResult = Awaited<ReturnType<typeof setupNetwork>>;

export async function setupNetwork() {
  const networkConfig = await getNetworkConfig();

  console.log("chain", networkConfig.chain)

  const clientOptions = {
    chain: networkConfig.chain,
    transport: transportObserver(fallback([webSocket(), http()])),
    pollingInterval: 1000,
  } as const satisfies ClientConfig;

  console.log("clientOptions", clientOptions)

  // const publicClient = createPublicClient(clientOptions);
  const publicClient = createPublicClient(clientOptions);
  console.log("publicClient", publicClient);
  const write$ = new Subject<ContractWrite>();

  const burnerAccount = createBurnerAccount(networkConfig.privateKey as Hex);
  // const burnerWalletClient = createWalletClient({
  //   ...clientOptions,
  //   account: burnerAccount,
  // });

  const burnerWalletClient = createWalletClient({
    ...clientOptions,
    account: burnerAccount,
  })
    .extend(transactionQueue())
    .extend(writeObserver({onWrite: (write) => write$.next(write)}));

  console.log("burnerAccount", burnerAccount);
  console.log("burnerWalletClient", burnerWalletClient);

  // const worldContract = createContract({
  //   address: networkConfig.worldAddress as Hex,
  //   abi: IWorldAbi,
  //   publicClient,
  //   walletClient: burnerWalletClient,
  //   onWrite: (write) => write$.next(write),
  // });

  const worldContract = getContract({
    address: networkConfig.worldAddress as Hex,
    abi: IWorldAbi,
    client: {public: publicClient, wallet: burnerWalletClient},
  });

  console.log("worldContract", worldContract);

  const tokenAContract = getContract({
    address: "0x88b985C5515B646D5ae4afc56d0855051cea5b48" as Hex,
    abi: IERC20Abi,
    client: {public: publicClient, wallet: burnerWalletClient},
  });

  const tokenBContract = getContract({
    address: "0x15772ec0dAd7848f243Ab4eAe022FfF2D642f078" as Hex,
    abi: IERC20Abi,
    client: {public: publicClient, wallet: burnerWalletClient},
  });

  const tokenCContract = getContract({
    address: "0x4444426ae66Efca568B519fF5c2Fd0351D0674fB" as Hex,
    abi: IERC20Abi,
    client: {public: publicClient, wallet: burnerWalletClient},
  });

  const {components, latestBlock$, storedBlockLogs$, waitForTransaction} = await syncToRecs({
    world,
    config: mudConfig,
    address: networkConfig.worldAddress as Hex,
    publicClient,
    startBlock: BigInt(networkConfig.initialBlockNumber),
  });

  const {useStore} = await syncToZustand({
    world,
    config: mudConfig,
    address: networkConfig.worldAddress as Hex,
    publicClient,
    startBlock: BigInt(networkConfig.initialBlockNumber)
  });

  // Request drip from faucet
  if (networkConfig.faucetServiceUrl) {
    const address = burnerAccount.address;
    console.info("[Dev Faucet]: Player address -> ", address);

    const faucet = createFaucetService(networkConfig.faucetServiceUrl);

    const requestDrip = async () => {
      const balance = await publicClient.getBalance({address});
      console.info(`[Dev Faucet]: Player balance -> ${balance}`);
      const lowBalance = balance < parseEther("1");
      if (lowBalance) {
        console.info("[Dev Faucet]: Balance is low, dripping funds to player");
        // Double drip
        await faucet.dripDev({address});
        await faucet.dripDev({address});
      }
    };

    requestDrip();
    // Request a drip every 20 seconds
    setInterval(requestDrip, 20000);
  }

  console.log("components", components)

  console.log("useStore", useStore)
  return {
    world,
    components,
    playerEntity: encodeEntity({address: "address"}, {address: burnerWalletClient.account.address}),
    publicClient,
    walletClient: burnerWalletClient,
    latestBlock$,
    storedBlockLogs$,
    waitForTransaction,
    worldContract,
    write$: write$.asObservable().pipe(share()),
    useStore,
    tokenAContract,
    tokenBContract,
    tokenCContract
    // tables
  };
}
