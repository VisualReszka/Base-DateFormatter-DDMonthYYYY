
# DateFormatter Solidity Contract

A Solidity utility for converting Unix timestamps into a human-readable `DD Month YYYY` format. Simple and efficient, this contract is designed for seamless integration into your smart contracts.

## Features

- Converts Unix timestamps to `DD Month YYYY`.
- Compatible with Base Sepolia Testnet and Base Mainnet.
- Easy integration with existing Solidity projects.

## Deployed Addresses

- **Base Sepolia Testnet**: `0x30A80121F22FBdF236218F54E6c6ad3CBCF9DBa0`
- **Base Mainnet**: `0x6ACb06deDd7B19B34c128D4757e4f3d642e10D27`

## Quick Start

### 1. Import the Contract

Add this line to your Solidity file:

```solidity
import "./DateFormatter.sol";
```

### 2. Initialize the Contract

Set up an instance in your constructor:

```solidity
DateFormatter private formatter;

constructor(address formatterAddress) {
    formatter = DateFormatter(formatterAddress); // formatterAddress <- Replace with the correct address
}
```

### 3. Format a Date

Use the `formatDate` function to convert a timestamp:

```solidity
function getFormattedDate(uint256 timestamp) public view returns (string memory) {
    return formatter.formatDate(timestamp);
}
```

### Example Code

```solidity
function exampleUsage() public view returns (string memory) {
    uint256 timestamp = 1733909348; // Example Unix timestamp
    return formatter.formatDate(timestamp);
}
```

### Expected Output

- Input: `1733909348`
- Output: `11 December 2024`

## Best Practices

- Verify the deployed contract address matches your target network.
- Test the functionality in a development environment before deploying.

## Support

If you'd like to support my work, any small contribution helps:  
**visualreszka.base.eth**

/////////////// /////////////// ///////////////
ビジュアルの裏側
/////////////// /////////////// /////////////// 

BASE • BASE • BASE