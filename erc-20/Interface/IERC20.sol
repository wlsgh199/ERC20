// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;


//ERC-20 이란 이더리움 블록체인 네트워크에서 정한 표준 토큰 스펙이다. 
//ERC-20 토큰은 이더리움과 교환 가능하며 이더리움 지갑으로 전송이 가능하다.

interface IERC20{
    //토큰이 한 계정에서 다른계정으로 이동할때 이벤트 발생용도.
    //이벤트를 검색할때 indexed 는 나중에 필터해서 볼수있습니다. 아니면 전체가다보임 
    event Transfer(address indexed from, address indexed to, uint256 value);
    event Approval(address indexed owner, address indexed spender, uint256 value);


    //view :  storage state 를 읽을 수 있지만, state 값을 변경할 수 없다. 즉 읽기만 가능합니다.
    //function 밖의 변수들을 읽을수 있으나 변경 불가능
    //pure :  storage state 를 읽으면 안되고, 그 state값을 변경할 수 도 없다.    
    //function 밖의 변수들을 읽지 못하고, 변경도 불가능
    //viwe 와 pure 둘다 명시 안할때: function 밖의 변수들을 읽어서, 변경을 해야함.


    //존재하는 토큰의 양을 반환.
    function totalSupply() external view returns (uint256);    
    //주소를 받으면 그 주소에 대한 토큰의 양을 반환.
    function balanceOf(address account) external view returns (uint256);  
    //코인 위임양.
    function allowance(address owner, address spender) external view returns (uint256);

    //토큰을 호출자의 계정(msg.sender) 에서 받는사람 recipient 의 주소로 amount 토큰을 보낸다.
    function transfer(address to, uint256 amount) external returns (bool); 
    //spender 가 당신의 계정으로부터 amount 한도 하에서 여러번 출금하는것을 허용합니다.
    function approve(address spender, uint256 amount) external returns (bool);
    //sender 주소에서 to주소로 얼마만큼 보내는 기능.
    function transferFrom(address sender, address to ,uint256 amount) external returns (bool);
}