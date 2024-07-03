// SPDX-License-Identifier: MIT
pragma solidity >=0.8.21;

library Utility {
    function addressToEntityKey(address addr) internal pure returns (bytes32) {
        return bytes32(uint256(uint160(addr)));
    }
}
