/*
 * Create the system calls that the client can use to ask
 * for changes in the World state (using the System contracts).
 */

import {SetupNetworkResult} from "./setupNetwork";
import {ethers} from "ethers";

export type SystemCalls = ReturnType<typeof createSystemCalls>;

export function createSystemCalls(
  /*
   * The parameter list informs TypeScript that:
   *
   * - The first parameter is expected to be a
   *   SetupNetworkResult, as defined in setupNetwork.ts
   *
   *   Out of this parameter, we only care about two fields:
   *   - worldContract (which comes from getContract, see
   *     https://github.com/latticexyz/mud/blob/main/templates/react/packages/client/src/mud/setupNetwork.ts#L63-L69).
   *
   *   - waitForTransaction (which comes from syncToRecs, see
   *     https://github.com/latticexyz/mud/blob/main/templates/react/packages/client/src/mud/setupNetwork.ts#L77-L83).
   *
   * - From the second parameter, which is a ClientComponent,
   *   we only care about Counter. This parameter comes to use
   *   through createClientComponents.ts, but it originates in
   *   syncToRecs
   *   (https://github.com/latticexyz/mud/blob/main/templates/react/packages/client/src/mud/setupNetwork.ts#L77-L83).
   */
  {
    tables,
    walletClient,
    worldContract,
    waitForTransaction,
    tokenAContract,
    tokenBContract,
    tokenCContract
  }: SetupNetworkResult,
) {

  const spawnPlayer = async () => {
    const tx = await worldContract.write.spawnPlayer([]);
    await waitForTransaction(tx);
  };

  const marchArmy = async (destination: number, infantry: number, cavalryA: number, cavalryB: number, cavalryC: number, army_id: number) => {
    const tx = await worldContract.write.march([destination, infantry, cavalryA, cavalryB, cavalryC, army_id]);
    await waitForTransaction(tx);
  }

  const attack = async (army_id: number) => {
    const tx = await worldContract.write.attack([army_id]);
    await waitForTransaction(tx);
  }

  const garrison = async (capital_id: number, infantry: number, cavalryA: number, cavalryB: number, cavalryC: number) => {
    const tx = await worldContract.write.garrison([capital_id, infantry, cavalryA, cavalryB, cavalryC]);
    await waitForTransaction(tx);
  }

  const buyInfantry = async (amount: number) => {
    console.log("worldContract", worldContract)
    const tx = await worldContract.write.buyInfantry([amount]);
    await waitForTransaction(tx);
  }

  const buyCavalryA = async (amount: number) => {
    const tx = await worldContract.write.buyCavalryA([amount]);
    await waitForTransaction(tx);
  }

  const buyCavalryB = async (amount: number) => {
    const tx = await worldContract.write.buyCavalryB([amount]);
    await waitForTransaction(tx);
  }

  const buyCavalryC = async (amount: number) => {
    const tx = await worldContract.write.buyCavalryC([amount]);
    await waitForTransaction(tx);
  }

  const spawnCapital = async (capital_id: number) => {
    const tx = await worldContract.write.spawnCapital([capital_id], {
      value: 500000000000000//ethers.utils.parseEther("0.5"),
    });
    await waitForTransaction(tx);
  }

  const stakeTokenB = async (amount: number) => {
    const tx = await worldContract.write.stakeTokenB([amount]);
    await waitForTransaction(tx);
  }

  const stakeTokenC = async (amount: number) => {
    const tx = await worldContract.write.stakeTokenC([amount]);
    await waitForTransaction(tx);
  }

  const unStakeTokenB = async (staker: string, amount: number) => {
    const tx = await worldContract.write.unStakeTokenB([staker, amount]);
    await waitForTransaction(tx);
  }

  const unStakeTokenC = async (staker: string, amount: number) => {
    const tx = await worldContract.write.unStakeTokenC([staker, amount]);
    await waitForTransaction(tx);
  }

  const farming = async (capital_id: number) => {
    const tx = await worldContract.write.farming([capital_id]);
    await waitForTransaction(tx);
  }

  const setMerkleRoot = async (root: string) => {
    const tx = await worldContract.write.setMerkleRoot([root]);
    await waitForTransaction(tx);
  }

  const claim = async (proof: string[], amount: number) => {
    const tx = await worldContract.write.claim([proof, amount]);
    await waitForTransaction(tx);
  }

  const swapA2B = async (amount: number) => {
    const wallet_address = walletClient.account.address;
    const allowance_bignint = await tokenAContract.read.allowance([wallet_address, worldContract.address]);
    const allowance = (Number)(ethers.utils.formatEther(allowance_bignint.toString(), 18));
    console.log("allowance:", allowance);
    if (allowance < amount) {
      const approve_tx = await tokenAContract.write.approve([worldContract.address, ethers.constants.MaxUint256]);
      console.log("approve_tx:", approve_tx);
    }

    const tx = await worldContract.write.swapA2B([amount]);
    await waitForTransaction(tx);
  }

  const swapA2C = async (amount: number) => {
    const wallet_address = walletClient.account.address;
    const allowance_bignint = await tokenAContract.read.allowance([wallet_address, worldContract.address]);
    const allowance = (Number)(ethers.utils.formatEther(allowance_bignint.toString(), 18));
    console.log("allowance:", allowance);
    if (allowance < amount) {
      const approve_tx = await tokenAContract.write.approve([worldContract.address, ethers.constants.MaxUint256]);
      console.log("approve_tx:", approve_tx);
    }
    const tx = await worldContract.write.swapA2C([amount]);
    await waitForTransaction(tx);
  }

  const withdrawToken = async (token_address: string, amount: number) => {
    const tx = await worldContract.write.withdrawToken([token_address, amount]);
    await waitForTransaction(tx);
  }

  const transactionTokenA = async (to_address: string, amount: number) => {
    const tx = await tokenAContract.write.transfer([to_address, amount]);
    await waitForTransaction(tx);
  }

  const transactionTokenB = async (to_address: string, amount: number) => {
    const tx = await tokenBContract.write.transfer([to_address, amount]);
    await waitForTransaction(tx);
  }

  const transactionTokenC = async (to_address: string, amount: number) => {
    const tx = await tokenCContract.write.transfer([to_address, amount]);
    await waitForTransaction(tx);
  }

  const approveTokenA = async (owner: string, spender: string, amount: number) => {
    const tx = await tokenAContract.write.approve([owner, spender, amount]);
    await waitForTransaction(tx);
  }

  // const getCapitalPower = async (capital_id: number) => {
  //   const result = await worldContract.read.getCapitalPower([capital_id]);
  //   return result[0];
  // }

  return {
    spawnPlayer,
    marchArmy,
    attack,
    garrison,
    buyInfantry,
    buyCavalryA,
    buyCavalryB,
    buyCavalryC,
    spawnCapital,
    stakeTokenB,
    stakeTokenC,
    unStakeTokenB,
    unStakeTokenC,
    farming,
    setMerkleRoot,
    claim,
    swapA2B,
    swapA2C,
    withdrawToken,
    transactionTokenA,
    transactionTokenB,
    transactionTokenC,
    approveTokenA,
  };
}
