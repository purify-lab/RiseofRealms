import {ethers} from 'ethers';
import dotenv from "dotenv";
import * as fs from "node:fs";

dotenv.config();

const UniversalRouterABI = JSON.parse(fs.readFileSync(__dirname + "/../abi/UniversalRouter.json").toString());
const Permit2ABI = JSON.parse(fs.readFileSync(__dirname + "/../abi/Permit2.json").toString());

async function MakeSignature() {

  if (!process.env.PRIVATE_KEY) {
    throw new Error('PRIVATE_KEY environment variable is not set.');
  }

  const provider = new ethers.JsonRpcProvider("");
  // 1. 获取用户的钱包实例
  const userWallet = new ethers.Wallet(process.env.PRIVATE_KEY, provider);
  // 2. 计算 permit 数据的 digest
  const owner = '0x0123456789012345678901234567890123456789';
  const spender = '0x9876543210987654321098765432109876543210';
  const value = ethers.parseEther('1.0');
  const deadline = Math.floor(Date.now() / 1000) + 3600; // 1 小时后过期
  const contract = new ethers.Contract("", Permit2ABI, userWallet);
  const nonce = await contract.nonces(owner);
  const digest = await contract.getPermitDigest(owner, spender, value, nonce, deadline);
  // 3. 使用用户的私钥对 digest 进行签名
  const signingKey = new ethers.SigningKey(userWallet.privateKey);
  const signature = await signingKey.sign(digest);
  console.log("signature", signature);
}

MakeSignature();