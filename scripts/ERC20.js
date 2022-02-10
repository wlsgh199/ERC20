require('dotenv').config();
const web3 = require("./web3.js").web3;
const customCommon = require("./web3.js").customCommon;
const getNonce = require("./web3.js").getNonce;

const abi = require("../artifacts/contracts/ERC20.sol/ERC20.json").abi;
const bytecode = require("../artifacts/contracts/ERC20.sol/ERC20.json").bytecode;

const Tx = require("ethereumjs-tx").Transaction;

const privateKey = Buffer.from(process.env.PRIVATE_KEY,'hex');

/**
 * 토큰 발행
 * @param {string} _name 토큰이름
 * @param {string} _symbol 토큰심볼 
 * @param {int} _totalSupply 총발행양 
 */
async function deploy(_name, _symbol, _totalSupply ){ 
    
    //Contract 생성
    let Contract = await new web3.eth.Contract(abi);    

    //ABI encoding
    let txData = await Contract.deploy({data: bytecode, arguments: [_name, _symbol, _totalSupply]}).encodeABI();      
    let _gasPrice = await web3.eth.getGasPrice();    
  
    let nonce = await getNonce(process.env.ADMIN_ADDRESS);   

    let txParams ={     
        nonce : web3.utils.toHex(nonce),
        from: process.env.ADMIN_ADDRESS,      
        gas: web3.utils.toHex(3000000),
        gasPrice : web3.utils.toHex(_gasPrice),
        data: txData,
    }

    sendTx(txParams);                  
}

/**
 * 토큰 전송
 * @param {string} _ca 컨트랙트 주소
 * @param {string} _to 받는사람 주소
 * @param {number} _amount 토큰양
 */
async function transfer(_ca, _to , _amount){    
    //ABI encoding
    let txData = await getContract(_ca).methods.transfer(_to, _amount).encodeABI();
    let _gasPrice = await web3.eth.getGasPrice();    
  
    let nonce = await getNonce(process.env.ADMIN_ADDRESS);   
         
    let txParams ={     
        nonce : web3.utils.toHex(nonce),
        from: process.env.ADMIN_ADDRESS,      
        to: _ca,
        gas: web3.utils.toHex(3000000),
        gasPrice : web3.utils.toHex(_gasPrice),
        data: txData,
    }

    sendTx(txParams);            
}
 
/**
 * 위임량 설정
 * @param {*} _ca 컨트랙트 주소
 * @param {*} _sender 위임해줄 주소
 * @param {*} _amount 토큰양
 */
async function approve(_ca, _sender, _amount){
    //ABI encoding
    let txData = await getContract(_ca).methods.approve(_sender, _amount).encodeABI();   
    let _gasPrice = await web3.eth.getGasPrice();    
   
     let nonce = await getNonce(process.env.ADMIN_ADDRESS);   
          
     let txParams ={     
         nonce : web3.utils.toHex(nonce),
         from: process.env.ADMIN_ADDRESS,      
         to: _ca,
         gas: web3.utils.toHex(3000000),
         gasPrice : web3.utils.toHex(_gasPrice),
         data: txData,
     }
 
     sendTx(txParams);                  
}

/**
 * 위임량안에서 토큰 전송
 * @param {*} _ca 컨트랙트 주소 
 * @param {*} _sender 보내는사람 주소
 * @param {*} _to 받는사람 주소
 * @param {*} _amount 토큰양
 */
async function transferFrom(_ca, _sender, _to , _amount){
    //ABI encoding  
     let txData = await getContract(_ca).methods.transferFrom(_sender, _to , _amount).encodeABI();
    let _gasPrice = await web3.eth.getGasPrice();    
  
    let nonce = await getNonce(process.env.ADMIN_ADDRESS);   
         
    let txParams ={     
        nonce : web3.utils.toHex(nonce),
        from: process.env.ADMIN_ADDRESS,      
        to: _ca,
        gas: web3.utils.toHex(3000000),
        gasPrice : web3.utils.toHex(_gasPrice),
        data: txData,
    }

    sendTx(txParams);            
}


////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

/**
 * 토큰양 조회
 * @param {string} _ca 컨트랙트 주소 
 * @param {string} _address 토큰 조회할 주소
 */
async function balanceOf(_ca,_address){    
    await getContract(_ca).methods.balanceOf(_address)
    .call().then(console.log);
}

/**
 *  토큰 총발행양 조회
 * @param {string} _ca 컨트랙트 주소
 */
async function totalSupply(_ca){    
    await getContract(_ca).methods.totalSupply()
    .call().then(console.log);
}

/**
 * 위임량 조회
 * @param {string} _ca 컨트랙트 주소
 * @param {string} _owner 토큰 주인 주소
 * @param {string} _spender 위임자 주소
 */
async function allowance(_ca, _owner, _spender){
    await getContract(_ca).methods.allowance(_owner, _spender)
    .call().then(console.log);
}

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

/**
 * 사인 트랜잭션 전송
 * @param {struct} txParams 
 */
function sendTx(txParams){                    
    let tx =  new Tx(txParams, {common : customCommon});        
    //console.log(txParams.nonce);
    tx.sign(privateKey);
    let serializeTx =  "0x" + tx.serialize().toString("hex");            
    
    //트랜잭션 전송
    web3.eth.sendSignedTransaction(serializeTx)
    .on('receipt', (receipt)=>{
        console.log(receipt);
        global.taskCount++;
    });
}


/**
 * 컨트랙트 가져오기 
 * @param {string} _ca 컨트랙트주소 
 * @returns Contract
 */
function getContract(_ca){    
    return  new web3.eth.Contract(abi, _ca);
}


module.exports.deploy = deploy;


module.exports.transfer = transfer;
module.exports.approve = approve;
module.exports.transferFrom = transferFrom;


module.exports.balanceOf = balanceOf;
module.exports.totalSupply = totalSupply;
module.exports.allowance = allowance;    
