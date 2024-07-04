// SPDX-License-Identifier: MIT
pragma solidity >=0.8.21;

library Utility {
    function addressToEntityKey(address addr) internal pure returns (bytes32) {
        return bytes32(uint256(uint160(addr)));
    }

    function entityKeyToAddress(bytes32 key) internal pure returns (address) {
        return address(uint160(uint256(key)));
    }

    function armyToEntityKey(bytes32 owner, uint8 id) internal pure returns (bytes32) {
        uint256 temp = uint256(owner);
        temp = temp * 10 * uint256(id);
        return bytes32(temp);
    }

    function battleReportToEntityKey(uint16 capitalId, uint32 timestamp) internal pure returns (bytes32) {
        uint256 temp = uint256(capitalId) * 11 + uint256(timestamp);
        return bytes32(temp);
    }
}
