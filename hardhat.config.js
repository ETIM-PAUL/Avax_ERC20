require("@nomicfoundation/hardhat-toolbox");
require('dotenv').config();

const FORK_FUJI = false;
const FORK_MAINNET = false;
let forkingData = undefined;

if (FORK_MAINNET) {
  forkingData = {
    url: "https://api.avax.network/ext/bc/C/rpcc",
  };
}
if (FORK_FUJI) {
  forkingData = {
    url: "https://api.sepolia.kroma.network",
  };
}

/** @type import('hardhat/config').HardhatUserConfig */
module.exports = {
  solidity: "0.8.18",
  networks: {
    hardhat: {
      gasPrice: 225000000000,
      chainId: !forkingData ? 43112 : undefined, //Only specify a chainId if we are not forking
      forking: forkingData,
    },
    sepolia: {
      url: "https://eth-sepolia.g.alchemy.com/v2/PN7ox_cWivKpFnRnE5YKoJ5Vyp8-Bx5j",
      gasPrice: 225000000000,
      chainId: 11155111,
      accounts: [process.env.WALLET_PRIVATE_KEY], // we use a .env file to hide our wallets private key
    },
    fuji: {
      url: "https://api.avax-test.network/ext/bc/C/rpc",
      gasPrice: 225000000000,
      chainId: 43113,
      accounts: [process.env.WALLET_PRIVATE_KEY], // we use a .env file to hide our wallets private key
    },
  },
  etherscan: {
    apiKey: {
      fuji: "avascan", // apiKey is not required, just set a placeholder
      sepolia: "8VWGCW9PI2P8QT1CTTDQPA5Y44YMMSJGCA"
    },
    customChains: [
      {
        network: "fuji",
        chainId: 43113,
        urls: {
          apiURL: "https://api.avascan.info/v2/network/testnet/evm/43113/etherscan",
          browserURL: "https://testnet.avascan.info/blockchain/c"
        }
      }
    ]
  },
};
