import ethers from 'ethers';

async  function make_signature() {
  // 1. 获取用户的钱包实例
  const userWallet = new ethers.Wallet('YOUR_PRIVATE_KEY', provider);
  // 2. 计算 permit 数据的 digest
  const owner = '0x0123456789012345678901234567890123456789';
  const spender = '0x9876543210987654321098765432109876543210';
  const value = ethers.parseEther('1.0');
  const deadline = Math.floor(Date.now() / 1000) + 3600; // 1 小时后过期
  const nonce = await contract.nonces(owner);
  const digest = await contract.getPermitDigest(owner, spender, value, nonce, deadline);
  // 3. 使用用户的私钥对 digest 进行签名
  const signingKey = new ethers.utils.SigningKey(userWallet.privateKey);
  const signature = await signingKey.signDigest(digest);
  console.log("signature", signature);
}