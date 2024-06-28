require("@nomicfoundation/hardhat-toolbox");

/** @type import('hardhat/config').HardhatUserConfig */
module.exports = {
  solidity: "0.8.24",
  defaultNetwork: "redstone",
  networks: {
    hardhat: {
    },
    redstone: {
      url: "https://sepolia.infura.io/v3/",
      accounts: [""]
    }
  },
};
