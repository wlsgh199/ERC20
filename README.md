# ERC20

# Solidity API

## Crowdsale

### token

```solidity
address token
```

### owner

```solidity
address owner
```

### rate

```solidity
uint256 rate
```

### weiRaised

```solidity
uint256 weiRaised
```

### salesClosed

```solidity
bool salesClosed
```

### deadline

```solidity
uint256 deadline
```

### TokenPurchase

```solidity
event TokenPurchase(address purchaser, uint256 value, uint256 amount)
```

### constructor

```solidity
constructor(address _token, uint256 _rate, uint256 _deadline) public
```

### receive

```solidity
receive() external payable
```

### tokenAmount

```solidity
function tokenAmount() public view returns (uint256)
```

### etherSend

```solidity
function etherSend() public
```

## ERC20

You can use this contract for only the most basic simulation

_All function calls are currently implemented without side effects_

### _balances

```solidity
mapping(address => uint256) _balances
```

### _allowances

```solidity
mapping(address => mapping(address => uint256)) _allowances
```

### _totalSupply

```solidity
uint256 _totalSupply
```

### name

```solidity
string name
```

### symbol

```solidity
string symbol
```

### decimals

```solidity
uint8 decimals
```

### constructor

```solidity
constructor(string _name, string _symbol, uint256 totalSupply_) public
```

### totalSupply

```solidity
function totalSupply() public view returns (uint256)
```

### balanceOf

```solidity
function balanceOf(address account) public view returns (uint256)
```

'files': one page per input Solidity file
More customization is possible by defining a function that returns a page
path given the AST node for the item and the source unit where it is
defined.
Defaults to 'single'.
/
    function balanceOf(address account) public view  override(IERC20)  returns (uint256){
        return _balances[account];
    }
    //토큰을 호출자의 계정(msg.sender) 에서 받는사람 to 의 주소로 amount 토큰을 보낸다.

_j_

### transfer

```solidity
function transfer(address to, uint256 amount) public returns (bool)
```

bool){
        _transfer(msg.sender, to, amount);        
        return true;
    }

    //owner 가 spender 에게 인출을 허락한 토큰의 개수는 몇개인가?     
    function allowance(address owner, addr

### allowance

```solidity
function allowance(address owner, address spender) public view returns (uint256)
```

### approve

```solidity
function approve(address spender, uint256 amount) public returns (bool)
```

### transferFrom

```solidity
function transferFrom(address sender, address to, uint256 amount) public returns (bool)
```

### _mint

```solidity
function _mint(address account, uint256 amount) private
```

### _transfer

```solidity
function _transfer(address from, address to, uint256 amount) private
```

### _approve

```solidity
function _approve(address owner, address spender, uint256 amount) private
```

## IERC20

### Transfer

```solidity
event Transfer(address from, address to, uint256 value)
```

### Approval

```solidity
event Approval(address owner, address spender, uint256 value)
```

### totalSupply

```solidity
function totalSupply() external view returns (uint256)
```

### balanceOf

```solidity
function balanceOf(address account) external view returns (uint256)
```

### allowance

```solidity
function allowance(address owner, address spender) external view returns (uint256)
```

### transfer

```solidity
function transfer(address to, uint256 amount) external returns (bool)
```

### approve

```solidity
function approve(address spender, uint256 amount) external returns (bool)
```

### transferFrom

```solidity
function transferFrom(address sender, address to, uint256 amount) external returns (bool)
```

## StackTooDeep

### UintPair

```solidity
struct UintPair {
  uint256 value1;
  uint256 value2;
}
```

### addUints

```solidity
function addUints(struct StackTooDeep.UintPair a, struct StackTooDeep.UintPair b, struct StackTooDeep.UintPair c, struct StackTooDeep.UintPair d, uint256 e) external pure returns (uint256)
```

## docgen_test

이 컨트랙트는 docgen 테스트용으로 만들었습니다.
토큰을 보낼때 발생하는 이벤트입니다.

_개발자에게 추가 세부정보를 설명할때.
contract docgen_test{_

### Transfer

```solidity
event Transfer(address from, address to, uint256 value)
```

to 받는사람 주소

| Name | Type | Description |
| ---- | ---- | ----------- |
| from | address |  |
| to | address |  |
| value | uint256 | 보낼양     event Transfer(address indexed from, address indexed to, uint256 value);        constructor(uint256 a1){             }      @n |

### constructor

```solidity
constructor(uint256 a1) public
```

### transfer

```solidity
function transfer(address to, uint256 amount) public returns (bool)
```

int256 amount) public returns (bool){
        return true;
    }

}

