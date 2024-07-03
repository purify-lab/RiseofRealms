// SPDX-License-Identifier: MIT
pragma solidity >=0.8.21;

/* Autogenerated file. Do not edit manually. */

// Import schema type
import { SchemaType } from "@latticexyz/schema-type/src/solidity/SchemaType.sol";

// Import store internals
import { IStore } from "@latticexyz/store/src/IStore.sol";
import { StoreSwitch } from "@latticexyz/store/src/StoreSwitch.sol";
import { StoreCore } from "@latticexyz/store/src/StoreCore.sol";
import { Bytes } from "@latticexyz/store/src/Bytes.sol";
import { Memory } from "@latticexyz/store/src/Memory.sol";
import { SliceLib } from "@latticexyz/store/src/Slice.sol";
import { EncodeArray } from "@latticexyz/store/src/tightcoder/EncodeArray.sol";
import { FieldLayout, FieldLayoutLib } from "@latticexyz/store/src/FieldLayout.sol";
import { Schema, SchemaLib } from "@latticexyz/store/src/Schema.sol";
import { PackedCounter, PackedCounterLib } from "@latticexyz/store/src/PackedCounter.sol";
import { ResourceId } from "@latticexyz/store/src/ResourceId.sol";
import { RESOURCE_TABLE, RESOURCE_OFFCHAIN_TABLE } from "@latticexyz/store/src/storeResourceTypes.sol";

ResourceId constant _tableId = ResourceId.wrap(bytes32(abi.encodePacked(RESOURCE_TABLE, bytes14(""), bytes16("Army"))));
ResourceId constant ArmyTableId = _tableId;

FieldLayout constant _fieldLayout = FieldLayout.wrap(
  0x00a2060020202020200200000000000000000000000000000000000000000000
);

struct ArmyData {
  uint256 infantry;
  uint256 cavalryA;
  uint256 cavalryB;
  uint256 cavalryC;
  uint256 lastTime;
  uint16 destination;
}

library Army {
  /**
   * @notice Get the table values' field layout.
   * @return _fieldLayout The field layout for the table.
   */
  function getFieldLayout() internal pure returns (FieldLayout) {
    return _fieldLayout;
  }

  /**
   * @notice Get the table's key schema.
   * @return _keySchema The key schema for the table.
   */
  function getKeySchema() internal pure returns (Schema) {
    SchemaType[] memory _keySchema = new SchemaType[](2);
    _keySchema[0] = SchemaType.BYTES32;
    _keySchema[1] = SchemaType.UINT8;

    return SchemaLib.encode(_keySchema);
  }

  /**
   * @notice Get the table's value schema.
   * @return _valueSchema The value schema for the table.
   */
  function getValueSchema() internal pure returns (Schema) {
    SchemaType[] memory _valueSchema = new SchemaType[](6);
    _valueSchema[0] = SchemaType.UINT256;
    _valueSchema[1] = SchemaType.UINT256;
    _valueSchema[2] = SchemaType.UINT256;
    _valueSchema[3] = SchemaType.UINT256;
    _valueSchema[4] = SchemaType.UINT256;
    _valueSchema[5] = SchemaType.UINT16;

    return SchemaLib.encode(_valueSchema);
  }

  /**
   * @notice Get the table's key field names.
   * @return keyNames An array of strings with the names of key fields.
   */
  function getKeyNames() internal pure returns (string[] memory keyNames) {
    keyNames = new string[](2);
    keyNames[0] = "owner";
    keyNames[1] = "id";
  }

  /**
   * @notice Get the table's value field names.
   * @return fieldNames An array of strings with the names of value fields.
   */
  function getFieldNames() internal pure returns (string[] memory fieldNames) {
    fieldNames = new string[](6);
    fieldNames[0] = "infantry";
    fieldNames[1] = "cavalryA";
    fieldNames[2] = "cavalryB";
    fieldNames[3] = "cavalryC";
    fieldNames[4] = "lastTime";
    fieldNames[5] = "destination";
  }

  /**
   * @notice Register the table with its config.
   */
  function register() internal {
    StoreSwitch.registerTable(_tableId, _fieldLayout, getKeySchema(), getValueSchema(), getKeyNames(), getFieldNames());
  }

  /**
   * @notice Register the table with its config.
   */
  function _register() internal {
    StoreCore.registerTable(_tableId, _fieldLayout, getKeySchema(), getValueSchema(), getKeyNames(), getFieldNames());
  }

  /**
   * @notice Get infantry.
   */
  function getInfantry(bytes32 owner, uint8 id) internal view returns (uint256 infantry) {
    bytes32[] memory _keyTuple = new bytes32[](2);
    _keyTuple[0] = owner;
    _keyTuple[1] = bytes32(uint256(id));

    bytes32 _blob = StoreSwitch.getStaticField(_tableId, _keyTuple, 0, _fieldLayout);
    return (uint256(bytes32(_blob)));
  }

  /**
   * @notice Get infantry.
   */
  function _getInfantry(bytes32 owner, uint8 id) internal view returns (uint256 infantry) {
    bytes32[] memory _keyTuple = new bytes32[](2);
    _keyTuple[0] = owner;
    _keyTuple[1] = bytes32(uint256(id));

    bytes32 _blob = StoreCore.getStaticField(_tableId, _keyTuple, 0, _fieldLayout);
    return (uint256(bytes32(_blob)));
  }

  /**
   * @notice Set infantry.
   */
  function setInfantry(bytes32 owner, uint8 id, uint256 infantry) internal {
    bytes32[] memory _keyTuple = new bytes32[](2);
    _keyTuple[0] = owner;
    _keyTuple[1] = bytes32(uint256(id));

    StoreSwitch.setStaticField(_tableId, _keyTuple, 0, abi.encodePacked((infantry)), _fieldLayout);
  }

  /**
   * @notice Set infantry.
   */
  function _setInfantry(bytes32 owner, uint8 id, uint256 infantry) internal {
    bytes32[] memory _keyTuple = new bytes32[](2);
    _keyTuple[0] = owner;
    _keyTuple[1] = bytes32(uint256(id));

    StoreCore.setStaticField(_tableId, _keyTuple, 0, abi.encodePacked((infantry)), _fieldLayout);
  }

  /**
   * @notice Get cavalryA.
   */
  function getCavalryA(bytes32 owner, uint8 id) internal view returns (uint256 cavalryA) {
    bytes32[] memory _keyTuple = new bytes32[](2);
    _keyTuple[0] = owner;
    _keyTuple[1] = bytes32(uint256(id));

    bytes32 _blob = StoreSwitch.getStaticField(_tableId, _keyTuple, 1, _fieldLayout);
    return (uint256(bytes32(_blob)));
  }

  /**
   * @notice Get cavalryA.
   */
  function _getCavalryA(bytes32 owner, uint8 id) internal view returns (uint256 cavalryA) {
    bytes32[] memory _keyTuple = new bytes32[](2);
    _keyTuple[0] = owner;
    _keyTuple[1] = bytes32(uint256(id));

    bytes32 _blob = StoreCore.getStaticField(_tableId, _keyTuple, 1, _fieldLayout);
    return (uint256(bytes32(_blob)));
  }

  /**
   * @notice Set cavalryA.
   */
  function setCavalryA(bytes32 owner, uint8 id, uint256 cavalryA) internal {
    bytes32[] memory _keyTuple = new bytes32[](2);
    _keyTuple[0] = owner;
    _keyTuple[1] = bytes32(uint256(id));

    StoreSwitch.setStaticField(_tableId, _keyTuple, 1, abi.encodePacked((cavalryA)), _fieldLayout);
  }

  /**
   * @notice Set cavalryA.
   */
  function _setCavalryA(bytes32 owner, uint8 id, uint256 cavalryA) internal {
    bytes32[] memory _keyTuple = new bytes32[](2);
    _keyTuple[0] = owner;
    _keyTuple[1] = bytes32(uint256(id));

    StoreCore.setStaticField(_tableId, _keyTuple, 1, abi.encodePacked((cavalryA)), _fieldLayout);
  }

  /**
   * @notice Get cavalryB.
   */
  function getCavalryB(bytes32 owner, uint8 id) internal view returns (uint256 cavalryB) {
    bytes32[] memory _keyTuple = new bytes32[](2);
    _keyTuple[0] = owner;
    _keyTuple[1] = bytes32(uint256(id));

    bytes32 _blob = StoreSwitch.getStaticField(_tableId, _keyTuple, 2, _fieldLayout);
    return (uint256(bytes32(_blob)));
  }

  /**
   * @notice Get cavalryB.
   */
  function _getCavalryB(bytes32 owner, uint8 id) internal view returns (uint256 cavalryB) {
    bytes32[] memory _keyTuple = new bytes32[](2);
    _keyTuple[0] = owner;
    _keyTuple[1] = bytes32(uint256(id));

    bytes32 _blob = StoreCore.getStaticField(_tableId, _keyTuple, 2, _fieldLayout);
    return (uint256(bytes32(_blob)));
  }

  /**
   * @notice Set cavalryB.
   */
  function setCavalryB(bytes32 owner, uint8 id, uint256 cavalryB) internal {
    bytes32[] memory _keyTuple = new bytes32[](2);
    _keyTuple[0] = owner;
    _keyTuple[1] = bytes32(uint256(id));

    StoreSwitch.setStaticField(_tableId, _keyTuple, 2, abi.encodePacked((cavalryB)), _fieldLayout);
  }

  /**
   * @notice Set cavalryB.
   */
  function _setCavalryB(bytes32 owner, uint8 id, uint256 cavalryB) internal {
    bytes32[] memory _keyTuple = new bytes32[](2);
    _keyTuple[0] = owner;
    _keyTuple[1] = bytes32(uint256(id));

    StoreCore.setStaticField(_tableId, _keyTuple, 2, abi.encodePacked((cavalryB)), _fieldLayout);
  }

  /**
   * @notice Get cavalryC.
   */
  function getCavalryC(bytes32 owner, uint8 id) internal view returns (uint256 cavalryC) {
    bytes32[] memory _keyTuple = new bytes32[](2);
    _keyTuple[0] = owner;
    _keyTuple[1] = bytes32(uint256(id));

    bytes32 _blob = StoreSwitch.getStaticField(_tableId, _keyTuple, 3, _fieldLayout);
    return (uint256(bytes32(_blob)));
  }

  /**
   * @notice Get cavalryC.
   */
  function _getCavalryC(bytes32 owner, uint8 id) internal view returns (uint256 cavalryC) {
    bytes32[] memory _keyTuple = new bytes32[](2);
    _keyTuple[0] = owner;
    _keyTuple[1] = bytes32(uint256(id));

    bytes32 _blob = StoreCore.getStaticField(_tableId, _keyTuple, 3, _fieldLayout);
    return (uint256(bytes32(_blob)));
  }

  /**
   * @notice Set cavalryC.
   */
  function setCavalryC(bytes32 owner, uint8 id, uint256 cavalryC) internal {
    bytes32[] memory _keyTuple = new bytes32[](2);
    _keyTuple[0] = owner;
    _keyTuple[1] = bytes32(uint256(id));

    StoreSwitch.setStaticField(_tableId, _keyTuple, 3, abi.encodePacked((cavalryC)), _fieldLayout);
  }

  /**
   * @notice Set cavalryC.
   */
  function _setCavalryC(bytes32 owner, uint8 id, uint256 cavalryC) internal {
    bytes32[] memory _keyTuple = new bytes32[](2);
    _keyTuple[0] = owner;
    _keyTuple[1] = bytes32(uint256(id));

    StoreCore.setStaticField(_tableId, _keyTuple, 3, abi.encodePacked((cavalryC)), _fieldLayout);
  }

  /**
   * @notice Get lastTime.
   */
  function getLastTime(bytes32 owner, uint8 id) internal view returns (uint256 lastTime) {
    bytes32[] memory _keyTuple = new bytes32[](2);
    _keyTuple[0] = owner;
    _keyTuple[1] = bytes32(uint256(id));

    bytes32 _blob = StoreSwitch.getStaticField(_tableId, _keyTuple, 4, _fieldLayout);
    return (uint256(bytes32(_blob)));
  }

  /**
   * @notice Get lastTime.
   */
  function _getLastTime(bytes32 owner, uint8 id) internal view returns (uint256 lastTime) {
    bytes32[] memory _keyTuple = new bytes32[](2);
    _keyTuple[0] = owner;
    _keyTuple[1] = bytes32(uint256(id));

    bytes32 _blob = StoreCore.getStaticField(_tableId, _keyTuple, 4, _fieldLayout);
    return (uint256(bytes32(_blob)));
  }

  /**
   * @notice Set lastTime.
   */
  function setLastTime(bytes32 owner, uint8 id, uint256 lastTime) internal {
    bytes32[] memory _keyTuple = new bytes32[](2);
    _keyTuple[0] = owner;
    _keyTuple[1] = bytes32(uint256(id));

    StoreSwitch.setStaticField(_tableId, _keyTuple, 4, abi.encodePacked((lastTime)), _fieldLayout);
  }

  /**
   * @notice Set lastTime.
   */
  function _setLastTime(bytes32 owner, uint8 id, uint256 lastTime) internal {
    bytes32[] memory _keyTuple = new bytes32[](2);
    _keyTuple[0] = owner;
    _keyTuple[1] = bytes32(uint256(id));

    StoreCore.setStaticField(_tableId, _keyTuple, 4, abi.encodePacked((lastTime)), _fieldLayout);
  }

  /**
   * @notice Get destination.
   */
  function getDestination(bytes32 owner, uint8 id) internal view returns (uint16 destination) {
    bytes32[] memory _keyTuple = new bytes32[](2);
    _keyTuple[0] = owner;
    _keyTuple[1] = bytes32(uint256(id));

    bytes32 _blob = StoreSwitch.getStaticField(_tableId, _keyTuple, 5, _fieldLayout);
    return (uint16(bytes2(_blob)));
  }

  /**
   * @notice Get destination.
   */
  function _getDestination(bytes32 owner, uint8 id) internal view returns (uint16 destination) {
    bytes32[] memory _keyTuple = new bytes32[](2);
    _keyTuple[0] = owner;
    _keyTuple[1] = bytes32(uint256(id));

    bytes32 _blob = StoreCore.getStaticField(_tableId, _keyTuple, 5, _fieldLayout);
    return (uint16(bytes2(_blob)));
  }

  /**
   * @notice Set destination.
   */
  function setDestination(bytes32 owner, uint8 id, uint16 destination) internal {
    bytes32[] memory _keyTuple = new bytes32[](2);
    _keyTuple[0] = owner;
    _keyTuple[1] = bytes32(uint256(id));

    StoreSwitch.setStaticField(_tableId, _keyTuple, 5, abi.encodePacked((destination)), _fieldLayout);
  }

  /**
   * @notice Set destination.
   */
  function _setDestination(bytes32 owner, uint8 id, uint16 destination) internal {
    bytes32[] memory _keyTuple = new bytes32[](2);
    _keyTuple[0] = owner;
    _keyTuple[1] = bytes32(uint256(id));

    StoreCore.setStaticField(_tableId, _keyTuple, 5, abi.encodePacked((destination)), _fieldLayout);
  }

  /**
   * @notice Get the full data.
   */
  function get(bytes32 owner, uint8 id) internal view returns (ArmyData memory _table) {
    bytes32[] memory _keyTuple = new bytes32[](2);
    _keyTuple[0] = owner;
    _keyTuple[1] = bytes32(uint256(id));

    (bytes memory _staticData, PackedCounter _encodedLengths, bytes memory _dynamicData) = StoreSwitch.getRecord(
      _tableId,
      _keyTuple,
      _fieldLayout
    );
    return decode(_staticData, _encodedLengths, _dynamicData);
  }

  /**
   * @notice Get the full data.
   */
  function _get(bytes32 owner, uint8 id) internal view returns (ArmyData memory _table) {
    bytes32[] memory _keyTuple = new bytes32[](2);
    _keyTuple[0] = owner;
    _keyTuple[1] = bytes32(uint256(id));

    (bytes memory _staticData, PackedCounter _encodedLengths, bytes memory _dynamicData) = StoreCore.getRecord(
      _tableId,
      _keyTuple,
      _fieldLayout
    );
    return decode(_staticData, _encodedLengths, _dynamicData);
  }

  /**
   * @notice Set the full data using individual values.
   */
  function set(
    bytes32 owner,
    uint8 id,
    uint256 infantry,
    uint256 cavalryA,
    uint256 cavalryB,
    uint256 cavalryC,
    uint256 lastTime,
    uint16 destination
  ) internal {
    bytes memory _staticData = encodeStatic(infantry, cavalryA, cavalryB, cavalryC, lastTime, destination);

    PackedCounter _encodedLengths;
    bytes memory _dynamicData;

    bytes32[] memory _keyTuple = new bytes32[](2);
    _keyTuple[0] = owner;
    _keyTuple[1] = bytes32(uint256(id));

    StoreSwitch.setRecord(_tableId, _keyTuple, _staticData, _encodedLengths, _dynamicData);
  }

  /**
   * @notice Set the full data using individual values.
   */
  function _set(
    bytes32 owner,
    uint8 id,
    uint256 infantry,
    uint256 cavalryA,
    uint256 cavalryB,
    uint256 cavalryC,
    uint256 lastTime,
    uint16 destination
  ) internal {
    bytes memory _staticData = encodeStatic(infantry, cavalryA, cavalryB, cavalryC, lastTime, destination);

    PackedCounter _encodedLengths;
    bytes memory _dynamicData;

    bytes32[] memory _keyTuple = new bytes32[](2);
    _keyTuple[0] = owner;
    _keyTuple[1] = bytes32(uint256(id));

    StoreCore.setRecord(_tableId, _keyTuple, _staticData, _encodedLengths, _dynamicData, _fieldLayout);
  }

  /**
   * @notice Set the full data using the data struct.
   */
  function set(bytes32 owner, uint8 id, ArmyData memory _table) internal {
    bytes memory _staticData = encodeStatic(
      _table.infantry,
      _table.cavalryA,
      _table.cavalryB,
      _table.cavalryC,
      _table.lastTime,
      _table.destination
    );

    PackedCounter _encodedLengths;
    bytes memory _dynamicData;

    bytes32[] memory _keyTuple = new bytes32[](2);
    _keyTuple[0] = owner;
    _keyTuple[1] = bytes32(uint256(id));

    StoreSwitch.setRecord(_tableId, _keyTuple, _staticData, _encodedLengths, _dynamicData);
  }

  /**
   * @notice Set the full data using the data struct.
   */
  function _set(bytes32 owner, uint8 id, ArmyData memory _table) internal {
    bytes memory _staticData = encodeStatic(
      _table.infantry,
      _table.cavalryA,
      _table.cavalryB,
      _table.cavalryC,
      _table.lastTime,
      _table.destination
    );

    PackedCounter _encodedLengths;
    bytes memory _dynamicData;

    bytes32[] memory _keyTuple = new bytes32[](2);
    _keyTuple[0] = owner;
    _keyTuple[1] = bytes32(uint256(id));

    StoreCore.setRecord(_tableId, _keyTuple, _staticData, _encodedLengths, _dynamicData, _fieldLayout);
  }

  /**
   * @notice Decode the tightly packed blob of static data using this table's field layout.
   */
  function decodeStatic(
    bytes memory _blob
  )
    internal
    pure
    returns (
      uint256 infantry,
      uint256 cavalryA,
      uint256 cavalryB,
      uint256 cavalryC,
      uint256 lastTime,
      uint16 destination
    )
  {
    infantry = (uint256(Bytes.slice32(_blob, 0)));

    cavalryA = (uint256(Bytes.slice32(_blob, 32)));

    cavalryB = (uint256(Bytes.slice32(_blob, 64)));

    cavalryC = (uint256(Bytes.slice32(_blob, 96)));

    lastTime = (uint256(Bytes.slice32(_blob, 128)));

    destination = (uint16(Bytes.slice2(_blob, 160)));
  }

  /**
   * @notice Decode the tightly packed blobs using this table's field layout.
   * @param _staticData Tightly packed static fields.
   *
   *
   */
  function decode(
    bytes memory _staticData,
    PackedCounter,
    bytes memory
  ) internal pure returns (ArmyData memory _table) {
    (
      _table.infantry,
      _table.cavalryA,
      _table.cavalryB,
      _table.cavalryC,
      _table.lastTime,
      _table.destination
    ) = decodeStatic(_staticData);
  }

  /**
   * @notice Delete all data for given keys.
   */
  function deleteRecord(bytes32 owner, uint8 id) internal {
    bytes32[] memory _keyTuple = new bytes32[](2);
    _keyTuple[0] = owner;
    _keyTuple[1] = bytes32(uint256(id));

    StoreSwitch.deleteRecord(_tableId, _keyTuple);
  }

  /**
   * @notice Delete all data for given keys.
   */
  function _deleteRecord(bytes32 owner, uint8 id) internal {
    bytes32[] memory _keyTuple = new bytes32[](2);
    _keyTuple[0] = owner;
    _keyTuple[1] = bytes32(uint256(id));

    StoreCore.deleteRecord(_tableId, _keyTuple, _fieldLayout);
  }

  /**
   * @notice Tightly pack static (fixed length) data using this table's schema.
   * @return The static data, encoded into a sequence of bytes.
   */
  function encodeStatic(
    uint256 infantry,
    uint256 cavalryA,
    uint256 cavalryB,
    uint256 cavalryC,
    uint256 lastTime,
    uint16 destination
  ) internal pure returns (bytes memory) {
    return abi.encodePacked(infantry, cavalryA, cavalryB, cavalryC, lastTime, destination);
  }

  /**
   * @notice Encode all of a record's fields.
   * @return The static (fixed length) data, encoded into a sequence of bytes.
   * @return The lengths of the dynamic fields (packed into a single bytes32 value).
   * @return The dyanmic (variable length) data, encoded into a sequence of bytes.
   */
  function encode(
    uint256 infantry,
    uint256 cavalryA,
    uint256 cavalryB,
    uint256 cavalryC,
    uint256 lastTime,
    uint16 destination
  ) internal pure returns (bytes memory, PackedCounter, bytes memory) {
    bytes memory _staticData = encodeStatic(infantry, cavalryA, cavalryB, cavalryC, lastTime, destination);

    PackedCounter _encodedLengths;
    bytes memory _dynamicData;

    return (_staticData, _encodedLengths, _dynamicData);
  }

  /**
   * @notice Encode keys as a bytes32 array using this table's field layout.
   */
  function encodeKeyTuple(bytes32 owner, uint8 id) internal pure returns (bytes32[] memory) {
    bytes32[] memory _keyTuple = new bytes32[](2);
    _keyTuple[0] = owner;
    _keyTuple[1] = bytes32(uint256(id));

    return _keyTuple;
  }
}