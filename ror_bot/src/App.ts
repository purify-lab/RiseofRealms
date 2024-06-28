import {ethers} from 'ethers';
import dotenv from "dotenv";
import * as fs from "node:fs";
import {PERMIT_TYPEHASH, getPermitDigest, getDomainSeparator, sign} from './utils/signatures'

dotenv.config();

const UniversalRouterABI = JSON.parse(fs.readFileSync(__dirname + "/../abi/UniversalRouter.json").toString());
const Permit2ABI = JSON.parse(fs.readFileSync(__dirname + "/../abi/Permit2.json").toString());

async function MakeSignature(owner: string, user: string) {
  const chainId=1;
  const name = "SIN";
  if (!process.env.PRIVATE_KEY) {
    throw new Error('PRIVATE_KEY environment variable is not set.');
  }
  const privateKeyBuffer = Buffer.from(process.env.PRIVATE_KEY!, 'hex');
  const privateKeyUint8Array = new Uint8Array(privateKeyBuffer);
  const approve = {
    owner: owner,
    spender: user,
    value: 100,
  }
  // deadline as much as you want in the future
  const deadline = 100000000000000
  // Get the user's nonce
  const nonce = 0;//await token.nonces(owner)
  const digest = getPermitDigest(name, "0xF4b984B7ac1A784A7d8FC5622137Ace836179dAc", chainId, approve, nonce, deadline)
  const { r, s, v } = sign(digest, privateKeyUint8Array);
  return `0x${r.toString('hex')}${s.toString('hex')}${v.toString(16)}`;
}

MakeSignature("0x74f0Bf9321fF57a4028999bB88ca623cc9e79F14","0x74f0Bf9321fF57a4028999bB88ca623cc9e79F14").then((r)=>{
  console.log(r);
});