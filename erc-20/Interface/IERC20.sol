// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

interface IERC20{

  //{transfer} 토큰이 한 계정에서 다른계정으로 이동할때 이벤트 발생용도.
    event Transfer(address indexed from, address indexed to, uint256 value);
    //{approve} 할때 이벤트 발생 : 새 허용량? 
    event Approval(address indexed owner, address indexed spender, uint256 value);

    //존재하는 토큰의 양을 반환.
    function totalSupply() external view returns (uint256);    
    //주소를 받으면 그 주소에 대한 토큰의 양을 반환.
    function balanceOf(address account) external view returns (uint256);  
    //코인 위임양.
    function allowance(address owner, address spender) external view returns (uint256);

    //토큰을 호출자의 계정(msg.sender) 에서 받는사람 recipient 의 주소로 amount 토큰을 보낸다.
    function transfer(address recipient, uint256 amount) external returns (bool); 
    //spender 가 당신의 계정으로부터 amount 한도 하에서 여러번 출금하는것을 허용합니다.
    function approve(address spender, uint256 amount) external returns (bool);
    //sender 주소에서 recipient주소로 얼마만큼 보내는 기능.
    function transferFrom(address sender, address recipient ,uint256 amount) external returns (bool);
} //123123