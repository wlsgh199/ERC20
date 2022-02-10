require('dotenv').config();
const web3 = require("./web3.js").web3;
const customCommon = require("./web3.js").customCommon;

const abi = require("../artifacts/contracts/ERC20.sol/ERC20.json").abi;
const bytecode = require("../artifacts/contracts/ERC20.sol/ERC20.json").bytecode;

const Tx = require("ethereumjs-tx").Transaction; 
const expect = require('chai').expect; 
const assert = require('chai').assert; 
    
const name = "jhtoken";
const symbol = "JHT";
const totalSupply = 1000;

const privateKey = Buffer.from(process.env.PRIVATE_KEY,'hex');

//assert(arr) = (!= null,!= undefined,!= '',!= 0) check
    describe('ERC20.js', () => {    

        it('module setting' , ()=>{           
            assert(Tx , "Tx is null");
            assert(abi, "abi is null");
            assert(bytecode, "bytecode is null");            
            assert(privateKey, "privateKey is null");            
            
        });        

        it('deploy' , async ()=>{  
                                   
            let Contract = await new web3.eth.Contract(abi);                                              
            //ABI encoding
            let txData = await Contract.deploy({data: bytecode, arguments: [name, symbol, totalSupply]}).encodeABI();  
            
            let _gasPrice = Number(await web3.eth.getGasPrice());    
            let txParams ={
                nonce : await getNonce() ,               
                from: process.env.ADMIN_ADDRESS,      
                gas: 3000000,
                gasPrice : _gasPrice,             
                data: txData,        
            }                                      
       
            let tx =  new Tx(txParams, {common : customCommon});              
            tx.sign(privateKey);
            let serializeTx =  "0x" + tx.serialize().toString("hex");         
                       
            //트랜잭션 전송                            
            const recipt = await web3.eth.sendSignedTransaction(serializeTx);
            expect(recipt.status).equal(true);             
        });       

    });    
    
    async function getNonce(){            
        return web3.utils.toHex( await web3.eth.getTransactionCount(process.env.ADMIN_ADDRESS));         
    }

    // it("should be ok", () =>{
    //     expext(1).to.equal(1);
    // });    

//  describe('Token contract', () => {
//      let Token, token, owner, addr1, addr2;

//      beforeEach(async() =>{
//          Token = await ethers.getContractFactory('Token');
//          token = await Token.deploy();
//          [owner, addr1, addr2, _] = await ethers.getSigners();
//      });


//     describe('Deployment', () => {
//         it('Should set the right owner' , async() =>{
//             expect(await token.owner()).to.equal(owner.address);
//         });

//         it('should assign the total supply of tokens to the owner', async() => {
//         expect(await token.totalSupply()).to.equal(ownerBalance);
//          });        
//     });

//     describe('Transactions', () => {
//         it('Should transfer tokens between accounts' , async() =>{
//             await token.transfer(addr1.address, 50);
//             const addr1Balance = await token.balanceOf(addr1.address);
//             expect(addr1Balance).to.equal(50);

//             await token.connect(addr1).transfer(addr2.address,50);            
//             const addr2Balance = await token.balanceOf(addr2.address);
//             expect(addr2Balance).to.equal(50);
//         });

//         it('Should fail if sender doesnt have enough tokens', async()=>{
//             const initialBalanceOwner = await token.balanceOf(owner.address);

//             await expert(
//                 token
//                 .connect(addr1)
//                 .transfer(owner.address,1)
//             ).to.be.revertedWith('Not enough tokens');

//         expext(
//             await token.balanceOf(owner.address)
//         )
//         .to
//         .equal(initialOwnerBalance);


//         });

//     });
//  });