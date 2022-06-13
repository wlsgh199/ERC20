# Solidity API

## docgen_test

이 컨트랙트는 docgen 테스트용으로 만들었습니다.
test 토큰을 보낼때 발생하는 이벤트입니다.
    /

_개발자에게 추가 세부정보를 설명할때.
contract docgen_test{_

### Transfer

```solidity
event Transfer(address from, address to, uint256 value)
```

er address

| Name | Type | Description |
| ---- | ---- | ----------- |
| from | address |  |
| to | address | test 받는사람 주소 |
| value | uint256 | test 보낼양         event Transfer(address indexed from, address indexed to, uint256 value);          constructor(uint256 a1){             } |

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

