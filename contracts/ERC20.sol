// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./Interface/IERC20.sol";

contract ERC20 is IERC20{
    
    //주소마다 토큰개수를 가지고있기위한
    mapping(address => uint256) private _balances;
    //위임양 가지고있는 
    mapping(address => mapping(address => uint256)) private _allowances;

    //토큰의 전채 양을 가지고있을 변수
    uint256 private _totalSupply;
    //토큰 이름을 반환한다.
    string public  name;
     // 토큰 이름을 줄여서 표현한것을 반환.
    string public  symbol;
      //사용자 표현을 위한 소숫자리수 변환.
    uint8 public constant decimals = 18;

    constructor(string memory _name , string memory _symbol, uint256 totalSupply_) {                 
        name = _name;
        symbol = _symbol;
        //decimals =  _decimals;
        _mint(msg.sender, totalSupply_ * (10 ** decimals));                
    }


    //존재하는 토큰의 양을 반환.
    function totalSupply() public view override(IERC20)  returns (uint256){
        return _totalSupply;
    }

    //주소를 받으면 그 주소에 대한 토큰의 양을 반환.
    function balanceOf(address account) public view  override(IERC20)  returns (uint256){
        return _balances[account];
    }
    //토큰을 호출자의 계정(msg.sender) 에서 받는사람 to 의 주소로 amount 토큰을 보낸다.
    function transfer(address to, uint256 amount) public override(IERC20) returns (bool){
        _transfer(msg.sender, to, amount);        
        return true;
    }

    //owner 가 spender 에게 인출을 허락한 토큰의 개수는 몇개인가?     
    function allowance(address owner, address spender) public view  override(IERC20) returns (uint256){
        return _allowances[owner][spender];
    }

    //spender의 계정으로부터 amount 한도정해주는것.
    function approve(address spender, uint256 amount) public  override(IERC20) returns (bool){
        _approve(msg.sender,spender,amount);
        return true;
    }

    //sender 주소에서 to주소로 위임양 넘지 않는 범위에서 전송.
    function transferFrom(address sender, address to ,uint256 amount) public  override(IERC20) returns (bool){
        
        //sender 토큰에 대해서 현재 위임량은 얼마인지.
        uint256 currentAllowance = _allowances[sender][msg.sender];
      
        //현재 허용된 잔액보다 보내는금액이 크면 에러.                        
        //require(currentAllowance >= amount, "ERC20: transfer amount exceeds allowance");           

        _approve(sender, msg.sender, currentAllowance - amount);            
        
        _transfer(sender, to, amount);

        return true;
    }

    //토큰을 생성하여 account에 할당.
    function _mint(address account ,uint256 amount) private {
        //require(account != address(0), "ERC20: mint to the zero address");

        _totalSupply += amount;
        _balances[account] += amount;

        emit Transfer(address(0), account,amount);
    }

    //실제 from에서 to amount 전송.
    function _transfer(address from, address to, uint256 amount) private {
        //require(from != address(0), "ERC20: transfer from the zero address");
        //require(to != address(0), "ERC20: transfer to the zero address");
              
        _balances[from] -=  amount;        
        _balances[to] += amount;
        
        emit Transfer(from, to, amount);
    }

     //owner 토큰을 spender 얼마나 쓸수있는지. 즉  위임량 설정.
    function _approve(address owner, address spender, uint256 amount) private {
        //require(owner != address(0),"ERC20: approve owner the zero address");
        //require(spender != address(0),"ERC20: approve spender the zero address");        
        _allowances[owner][spender] = amount;
        emit Approval(owner,spender,amount);
    }

    
           
  
    // //소각
    // function burn(address account , uint256 amount) public virtual{
    //     _burn(account, amount);
    // }

    // //토큰을 파괴하다. 소각
    // function _burn (address account, uint256 amount) internal virtual{
                
    //     require(account!=address(0), "ERC20: burn from the zero address");       
    //     uint256 accountBalance = _balances[account];
    //     require(accountBalance>=amount,"ERC20: burn amount exceeds balance");    
    
    //         _balances[account] = accountBalance - amount;    

    //     _totalSupply -= amount;

    //     emit Transfer(account, address(0), amount);    
    // }

     // //approve 로 정한 위임양에서 + 추가 한도 해서 저장함.
    // function increaseAllowance(address spender, uint256 addedValue)public virtual returns (bool){
    //     _approve(msg.sender,spender, _allowances[msg.sender][spender] + addedValue);
    //     return true;
    // }
    
    // //approve 로 정한 위임양에서 - 추가 한도 해서 저장함.
    // function decreaseAllowance(address spender, uint256 subtractedValue) public virtual returns (bool){
    //     uint256 currentAllowance = _allowances[msg.sender][spender];
    //     require(currentAllowance >= subtractedValue, "ERC20: decreased allowance below zero");    
    //         _approve(msg.sender,spender, currentAllowance - subtractedValue );    
    //     return true;
    // }
   
}