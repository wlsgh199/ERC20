// // SPDX-License-Identifier: MIT
 pragma solidity ^0.8.0;

import "./ERC20.sol";

contract Crowdsale{
   
    // CA주소
    address private token ;
    // 주인 주소
    address private constant owner = 0x911839F78770823Ee882Bd0e7c8645bF8FC7dc04;
   
    // 1 wei 당 토큰 비율
    uint256 public rate;
    // 현재 판매한 금액 .
    uint256 public weiRaised;

    // 세일즈 마감여부
    bool private salesClosed = false;  
    //얼마나 진행할건지 할건지 시간 설정.
    uint256 private deadline;   

    //토큰 구매 이벤트
    event TokenPurchase(
        address indexed purchaser,       
        uint256 value,
        uint256 amount
    );
    
    //생성자
    constructor(){
        //토큰주소.
        token = 0x75c5D4F243956572d9c980450A38C6c8f86c1B6D;               
        rate = 1;         
        deadline = block.timestamp + (10 * 60 ) ;
        //require(_rate > 0);
        //require(token != address(0));    
    }

    //이더를 받을때만 실행
    receive() external payable {       

        if(deadline < block.timestamp){
            salesClosed = true;
        }
    
        require(salesClosed == false, "-- Salse Closed. -- ");        

        address purchaser = msg.sender;              
        uint256 weiAmount = msg.value;

        require(weiAmount != 0 );
        require(tokenAmount() != 0);
        // calculate token amount to be created
        uint256 tokens = weiAmount * rate;

        // update state
        weiRaised += weiAmount;

        //들어온 웨이만큼 토큰계산해서 보내준다.
        ERC20(token).transfer(purchaser, tokens);                
             
        emit TokenPurchase(purchaser, weiAmount, tokens );       
    }

    //교환해줄수있는 토큰개수
    function tokenAmount() public view returns(uint256){
        return ERC20(token).balanceOf(address(this));
    }   
    
    //모아놓은 ETH -> 주인 주소로 전송
    function etherSend() public {
        require(msg.sender == owner , "only owner");
        payable(owner).transfer(weiRaised);
        salesClosed = true;
        weiRaised = 0;
    }

    

    // //남은 시간. 초(sec) 로 보여줌
    // function getRemainingTime_sec() public view returns(uint256){      
    //     if(deadline > block.timestamp){
    //         return deadline - block.timestamp;
    //     }else{
    //         return 0;
    //     }
    // }
       
}