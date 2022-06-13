# Solidity API

## docgen_test

이 컨트랙트는 docgen 테스트용으로 만들었습니다.

_개발자에게 추가 세부정보를 설명할때.
contract docgen_test{

    /* ========== EVENTS ========== */
    
    /**_

### Transfer

```solidity
event Transfer(address from, address to, uint256 value)
```

to 받는사람 주소

| Name | Type | Description |
| ---- | ---- | ----------- |
| from | address |  |
| to | address |  |
| value | uint256 | 보낼양         event Transfer(address indexed from, address indexed to, uint256 value);          constructor(uint256 a1){             } |

### constructor

```solidity
constructor(uint256 a1) public
```

### transfer

```solidity
function transfer(address to, uint256 amount) public pure returns (bool)
```

allowances. See {Transfer}.
/
    function transfer(address to, uint256 amount) public pure returns (bool){
        return true;
    }

}

