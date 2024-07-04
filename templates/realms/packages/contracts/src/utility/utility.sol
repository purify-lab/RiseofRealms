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
        temp = (temp << 8) + uint256(id);
        return bytes32(temp);
    }

    function battleReportToEntityKey(uint16 capitalId, uint32 timestamp) internal pure returns (bytes32) {
        uint256 temp = (uint256(capitalId) << 32) + uint256(timestamp);
        return bytes32(temp);
    }

    function getArmyId(bytes32 entityKey) internal pure returns (bytes32 owner, uint8 id) {
        uint256 temp = uint256(entityKey);
        id = uint8(temp);
        owner = bytes32(temp >> 8);
        return (owner, id);
    }

    function getBattleReportId(bytes32 entityKey) internal pure returns (uint16 capitalId, uint32 timestamp) {
        uint256 temp = uint256(entityKey);
        timestamp = uint32(temp);
        capitalId = uint16(temp >> 32);
        return (capitalId, timestamp);
    }
}
