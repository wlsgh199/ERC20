const ERC20 = require("./ERC20.js");

function menuLog(){
  console.log(`ex) node scripts/main.js [Arg]`);
  console.log(`deploy : 토큰 생성                             ex) node scripts/main.js deploy [name] [symbol] [totalSupply] `);        
  console.log(`transfer : 토큰 전송                           ex) node scripts/main.js transfer [ca] [to] [amount] `);
  console.log(`approve : 위임량 설정                           ex) node scripts/main.js approve [ca] [spender] [amount] `);
  console.log(`transferfrom : A토큰을 위임량내 B에게 전송         ex) node scripts/main.js transferfrom [ca] [owner] [spender] [amount] `);        
  console.log(`balanceof : 토큰양 조회                         ex) node scripts/main.js balanceof [ca] [address] `);
  console.log(`totalsupply : 토큰 총발행량 조회                 ex) node scripts/main.js totalsupply [ca] `);
  console.log(`allowance : 토큰 위임량 조회                     ex) node scripts/main.js allowance [ca] [owner] [spender] `);
}


global.taskCount = 0;

/**
 * @notice ms만큼 딜레이를 수행한다.
 * @param {string} ms 딜레이 타임 (ms)
 * @return promise (setTimeout)
 * @author jhhong
 */
let delay = function(ms) {
  return new Promise(resolve => setTimeout(resolve, ms));
}

async function main(){      
    let arg = process.argv[2];
    
    if(arg == undefined){
      menuLog();
      return;
    }        
    
    let promises = [];

    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////       
    switch(arg.toLowerCase()){      

      case "deploy":                 
        throwCheck("deploy", 6);                          
          promises.push(await ERC20.deploy(process.argv[3], process.argv[4], process.argv[5]));              
        break;

      case "deploy10":                 
        throwCheck("deploy", 6);         
          for(let i = 0; i < 10; i++){                          
            promises.push(await ERC20.deploy(process.argv[3], process.argv[4], process.argv[5]));              
          }
        break;
      
      case "transfer":
        throwCheck("transfer", 6);
        promises.push(await ERC20.transfer(process.argv[3], process.argv[4], process.argv[5]));          
        break;

      case "approve":
        throwCheck("approve",6);
        promises.push(await ERC20.approve(process.argv[3] , process.argv[4], process.argv[5]));
        break;

      case "transferfrom":
        throwCheck("transferfrom",7);
        promises.push(await ERC20.transferFrom(process.argv[3], process.argv[4], process.argv[5], process.argv[6]));
        break;

      /*****************************************VIEW*****************************************/

      case "balanceof":         
        throwCheck("balanceof",5);              
        await ERC20.balanceOf(process.argv[3], process.argv[4]);                                               
        break;

      case "totalsupply":
        throwCheck("totalsupply",4);
        await ERC20.totalSupply(process.argv[3]);
        break;

      case "allowance":
        throwCheck("allowance",6);
        await ERC20.allowance(process.argv[3] , process.argv[4], process.argv[5]);
        break;

      default :
        menuLog();
        break;        
    }        
    
    let promiseLength = promises.length;    
    Promise.all(promises);
    
    while(true){                      
        if(promiseLength == global.taskCount){
          break;
        }else{
          await delay(300);
        }
        
    }
    
}



/**
 * 인자값 체크
 * @param {string} _name 메소드 이름 
 * @param {int} _argvLength Agument 길이
 */
function throwCheck(_name,  _argvLength){    
  if(_argvLength != process.argv.length){              
    console.error(`${_name} : Check Arguments `);
    process.exit(1);
  }      
}

main()
.then( () => process.exit(0)   //0은 어떤 종류의 오류도 없이 프로세스를 종료한다는 의미
.catch((error) => {
    console.error(`${error}`);
    process.exit(1);    //1은 일부 실패와 함께 프로세스를 종료한다는 의미입니다.
}));

