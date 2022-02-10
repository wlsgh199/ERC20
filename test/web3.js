require('dotenv').config();
let Web3 = require('web3');
let Common = require("ethereumjs-common").default;
const assert = require('chai').assert; 

let web3 = new Web3(new Web3.providers.HttpProvider(process.env.RPC_SERVER));

let customCommon = Common.forCustomChain(
    //실제 운영하는 네트워크.
        'mainnet',
        {
        name: 'my-network',        
        chainId: 31337,
        },
        'istanbul'
    );

describe("web3.js" ,()=>{
    it("module setting", ()=>{
        assert(web3 , "web3 null");
        assert(customCommon,"customCommon null" );
    });
});

module.exports.web3 = web3;
module.exports.customCommon = customCommon;