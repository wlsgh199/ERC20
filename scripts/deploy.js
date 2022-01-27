
const { ethers, waffle } = require('hardhat');

async function main(){

    // const provider = waffle.provider;

    // const[ad1] = await ethers.getSigners();
    // console.log(ad1.address); 

    // const balance1 = await provider.getBalance(ad1.address);    
    // console.log('balance1: ',ethers.utils.formatEther(balance1));    

    const Token = await ethers.getContractFactory('ERC20');
    const token = await Token.deploy('Jin Ho Token', 'JHT', 18,  1000);

    console.log('JHT Token deployed to : ', token.address);
}

main()
.then( () => process.exit(0)   //0은 어떤 종류의 오류도 없이 프로세스를 종료한다는 의미
.catch((error) => {
    console.error(error);
    process.exit(1);    //1은 일부 실패와 함께 프로세스를 종료한다는 의미입니다.
}));

