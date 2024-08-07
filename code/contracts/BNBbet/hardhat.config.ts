import { HardhatUserConfig } from "hardhat/config";
import "@nomicfoundation/hardhat-toolbox";
require("dotenv").config();

const config: HardhatUserConfig = {
  solidity: "0.8.24",
  networks: {
    Amoy: {
      chainId:80002,
      url: "https://rpc-amoy.polygon.technology",
      accounts: [
       `${process.env.PRIVATE_KEY}`
      ]
    },
    Polygon: {
      chainId:137,
      url: `https://polygon-mainnet.infura.io/v3/${process.env.INFURA_KEY}`,
      accounts: [
        `${process.env.PRIVATE_KEY}`
       ]
    }
  },
  etherscan: {
    apiKey: process.env.POLYGONSCAN_KEY,
  }
};

export default config;
