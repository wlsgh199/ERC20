// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./Interface/IERC20.sol";



contract ERC20 is IERC20{
    //하드 용량에 따라 
    mapping(address => uint256) private _balances;
    mapping(address => mapping(address => uint256)) private _allowances;

    uint256 private _totalSupply;
    //토큰 이름을 반환한다.
    string public  _name;
     // 토큰 이름을 줄여서 표현한것을 반환.
    string public  _symbol;
      //사용자 표현을 위한 소숫자리수 변환.
    uint8 public _decimals;

    constructor() {                 
        _name = "jhpark Token";
        _symbol = "JHT6" ;          
        _decimals = 18;
        _mint(msg.sender, 1000 * (10 ** _decimals));                
    }

    //존재하는 토큰의 양을 반환.
    function totalSupply() public view virtual override(IERC20)  returns (uint256){
        return _totalSupply;
    }

    //주소를 받으면 그 주소에 대한 토큰의 양을 반환.
    function balanceOf(address account) public view virtual override(IERC20)  returns (uint256){
        return _balances[account];
    }
    //토큰을 호출자의 계정(msg.sender) 에서 받는사람 recipient 의 주소로 amount 토큰을 보낸다.
    function transfer(address recipient, uint256 amount) public virtual override(IERC20) returns (bool){
        _transfer(msg.sender, recipient, amount);        
        return true;
    }

    //owner 가 spender 에게 인출을 허락한 토큰의 개수는 몇개인가?
    function allowance(address owner, address spender) public view virtual override(IERC20) returns (uint256){
        return _allowances[owner][spender];
    }

    //spender의 계정으로부터 amount 한도정해주는것.
    function approve(address spender, uint256 amount) public virtual override(IERC20) returns (bool){
        _approve(msg.sender,spender,amount);
        return true;
    }

    //sender 주소에서 recipient주소로 위임양 넘지 않는 범위에서 전송.
    function transferFrom(address sender, address recipient ,uint256 amount) public virtual override(IERC20) returns (bool){

        //컨트랙트 안에서 보낼수있는 허용 한도. 
        //sender 에게서 나에게 얼마를 줄수있는지 확인.
        uint256 currentAllowance = _allowances[sender][msg.sender];
        if (currentAllowance != type(uint256).max) {
            //현재 허용된 잔액보다 보내는금액이 크면 에러.            
            require(currentAllowance >= amount, "ERC20: transfer amount exceeds allowance");
           unchecked {
             _approve(sender, msg.sender, currentAllowance - amount);
            }
        }
        _transfer(sender, recipient, amount);

        return true;
    }

    //실제 sender에서 recipient로 amount 전송.
    function _transfer(address sender, address recipient, uint256 amount) internal virtual{
        require(sender != address(0), "ERC20: transfer sender the zero address");
        require(recipient != address(0), "ERC20: transfer recipient the zero address");
        
        //_beforeTokenTransfer(sender, recipient, amount);
        uint256 senderBalance = _balances[sender];
        require(senderBalance >= amount,"ERC20: transfer amount exceeds balance");
        
        unchecked {
            _balances[sender] = senderBalance - amount;
        }

        _balances[recipient] += amount;

        emit Transfer(sender, recipient, amount);

        //_afterTokenTransfer(sender, recipient, amount);
    }

    //토큰을 생성하여 account에 할당.
    function _mint(address account ,uint256 amount) internal virtual{
        require(account != address(0), "ERC20: mint to the zero address");
        
        _totalSupply += amount;
        _balances[account] += amount;

        emit Transfer(address(0), account,amount);
    }
   
    //한도설정.
    function _approve(address owner, address spender, uint256 amount)internal virtual{
        require(owner != address(0),"ERC20: approve owner the zero address");
        require(spender != address(0),"ERC20: approve spender the zero address");        
        _allowances[owner][spender] = amount;
        emit Approval(owner,spender,amount);
    }

//    function CrowdSales(uint256 _rate, address _wallet) public{
//         CROWDSALE crowdsale = new CROWDSALE(_rate, _wallet, this);
//     }

    

    // //소각
    // function burn(address account , uint256 amount) public virtual{
    //     _burn(account, amount);
    // }

    // //토큰을 파괴하다. 소각
    // function _burn (address account, uint256 amount) internal virtual{
    //       require(account!=address(0), "ERC20: burn from the zero address");
    //     //_beforeTokenTransfer(account, address(0), amount);
    //     uint256 accountBalance = _balances[account];
    //     require(accountBalance>=amount,"ERC20: burn amount exceeds balance");    
    //     unchecked {
    //         _balances[account] = accountBalance - amount;
    //     }
    //     _totalSupply -= amount;
    //     emit Transfer(account, address(0), amount);
    //     //_afterTokenTransfer(account, address(0), amount);
    // }

     // //approve 로 정한 한도에서 + 추가 한도 해서 저장함.
    // function increaseAllowance(address spender, uint256 addedValue)public virtual returns (bool){
    //     _approve(msg.sender,spender, _allowances[msg.sender][spender] + addedValue);
    //     return true;
    // }
    
    // //approve 로 정한 한도에서 - 추가 한도 해서 저장함.
    // function decreaseAllowance(address spender, uint256 subtractedValue) public virtual returns (bool){
    //     uint256 currentAllowance = _allowances[msg.sender][spender];
    //     require(currentAllowance >= subtractedValue, "ERC20: decreased allowance below zero");
    //     unchecked {
    //         _approve(msg.sender,spender, currentAllowance - subtractedValue );
    //     }
    //     return true;
    // }



    // function _beforeTokenTransfer(address from, address to, uint256 amount) internal virtual{
    //     require(from != address(0),"ERC20: beforeTokenTransfer from the zero address");
    //     require(to != address(0),"ERC20: beforeTokenTransfer to the zero address");
    // }

    // function _afterTokenTransfer(address from, address to, uint256 amount) internal virtual{
    //     require(from != address(0),"ERC20: afterTokenTransfer from the zero address");
    //     require(to != address(0),"ERC20: afterTokenTransfer to the zero address");
    // }



   
}