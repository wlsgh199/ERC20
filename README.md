# Solidity API

## docgen_test

this contract docgen test.

_all function calls are currentlu implement without side effects_

### Transfer

```solidity
event Transfer(address from, address to, uint256 value)
```

token transfer event.

| Name | Type | Description |
| ---- | ---- | ----------- |
| from | address | sender address |
| to | address | receiver address |
| value | uint256 | amount |

### constructor

```solidity
constructor(uint256 a1) public
```

### transfer

```solidity
function transfer(address to, uint256 amount) public pure returns (bool)
```

토큰을 보낼때 사용합니다.

| Name | Type | Description |
| ---- | ---- | ----------- |
| to | address | 받는사람 주소 |
| amount | uint256 | 보낼양 |

| Name | Type | Description |
| ---- | ---- | ----------- |
| [0] | bool | 성공 or 실패 여부     function transfer(address to, uint256 amount) p |

