# Solidity API

## Tree

You can use this contract for only the most basic simulation

_All function calls are currently implemented without side effects_

### age

```solidity
function age(uint256 rings) external pure virtual returns (uint256)
```

Calculate tree age in years, rounded up, for live trees

_The Alexandr N. Tetearing algorithm could increase precision_

| Name | Type | Description |
| ---- | ---- | ----------- |
| rings | uint256 | The number of rings from dendrochronological sample |

| Name | Type | Description |
| ---- | ---- | ----------- |
| [0] | uint256 | Age in years, rounded up for partial years |

### leaves

```solidity
function leaves() external pure virtual returns (uint256)
```

Returns the amount of leaves the tree has.

_Returns only a fixed number._

## Plant

### leaves

```solidity
function leaves() external pure virtual returns (uint256)
```

## KumquatTree

### age

```solidity
function age(uint256 rings) external pure returns (uint256)
```

Calculate tree age in years, rounded up, for live trees

_The Alexandr N. Tetearing algorithm could increase precision_

| Name | Type | Description |
| ---- | ---- | ----------- |
| rings | uint256 | The number of rings from dendrochronological sample |

| Name | Type | Description |
| ---- | ---- | ----------- |
| [0] | uint256 | Age in years, rounded up for partial years |

### leaves

```solidity
function leaves() external pure returns (uint256)
```

Return the amount of leaves that this specific kind of tree has

_Returns only a fixed number._

