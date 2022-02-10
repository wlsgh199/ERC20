
require("@nomiclabs/hardhat-waffle");
require('dotenv').config();
/**
 * @type import('hardhat/config').HardhatUserConfig
 */
module.exports = {
  solidity: "0.8.0",
    // settings: {
    //   optimizer: {enabled: process.env.DEBUG ? false : true},
    // }
    // network:{
    //   localhost: {
    //     url: `${process.env.RPC_SERVER}`,
    //     //accounts: [`${process.env.PRIVATE_KEY}`]
    //   }
    // }
    networks: {
    hardhat: {
      mining: {
        auto: false,
        interval: 3000
      }
    }
}
};
// module.exports = {
//   solidity: {
//     version: "0.8.0",
//     settings: {
//       optimizer: {
//         enabled: true,
//         runs: 1000,
//       },
//     },
//   },
// };
