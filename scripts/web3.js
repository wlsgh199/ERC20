require('dotenv').config();
const Web3 = require('web3');
const Common = require("ethereumjs-common").default;

//provider 생성
const web3 = new Web3(new Web3.providers.HttpProvider(process.env.RPC_SERVER));
// console.log(await web3.eth.net.getId());
// console.log(await web3.eth.net.getNetworkType());

const customCommon = Common.forCustomChain(
  //실제 운영하는 네트워크.
    'mainnet',
    {
      name: 'my-network',        
      chainId: 31337,
    },
    'istanbul'
);

async function getNonce(addr) {
   return await web3.eth.getTransactionCount(addr,"pending");
}


module.exports.web3 = web3;
module.exports.customCommon = customCommon;
module.exports.getNonce = getNonce;