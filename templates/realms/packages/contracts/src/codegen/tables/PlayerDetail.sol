// SPDX-License-Identifier: MIT
pragma solidity >=0.8.24;

/* Autogenerated file. Do not edit manually. */

// Import store internals
import { IStore } from "@latticexyz/store/src/IStore.sol";
import { StoreSwitch } from "@latticexyz/store/src/StoreSwitch.sol";
import { StoreCore } from "@latticexyz/store/src/StoreCore.sol";
import { Bytes } from "@latticexyz/store/src/Bytes.sol";
import { Memory } from "@latticexyz/store/src/Memory.sol";
import { SliceLib } from "@latticexyz/store/src/Slice.sol";
import { EncodeArray } from "@latticexyz/store/src/tightcoder/EncodeArray.sol";
import { FieldLayout } from "@latticexyz/store/src/FieldLayout.sol";
import { Schema } from "@latticexyz/store/src/Schema.sol";
import { EncodedLengths, EncodedLengthsLib } from "@latticexyz/store/src/EncodedLengths.sol";
import { ResourceId } from "@latticexyz/store/src/ResourceId.sol";

struct PlayerDetailData {
  address wallet;
  uint256 gold;
  uint256 infantry;
  uint256 cavalryA;
  uint256 cavalryB;
  uint256 cavalryC;
  uint16 lands;
  bool isSpawnCapital;
}

library PlayerDetail {
  // Hex below is the result of `WorldResourceIdLib.encode({ namespace: "", name: "PlayerDetail", typeId: RESOURCE_TABLE });`
  ResourceId constant _tableId = ResourceId.wrap(0x74620000000000000000000000000000506c6179657244657461696c00000000);

  FieldLayout constant _fieldLayout =
    FieldLayout.wrap(0x00b7080014202020202002010000000000000000000000000000000000000000);

  // Hex-encoded key schema of (bytes32)
  Schema constant _keySchema = Schema.wrap(0x002001005f000000000000000000000000000000000000000000000000000000);
  // Hex-encoded value schema of (address, uint256, uint256, uint256, uint256, uint256, uint16, bool)
  Schema constant _valueSchema = Schema.wrap(0x00b70800611f1f1f1f1f01600000000000000000000000000000000000000000);

  /**
   * @notice Get the table's key field names.
   * @return keyNames An array of strings with the names of key fields.
   */
  function getKeyNames() internal pure returns (string[] memory keyNames) {
    keyNames = new string[](1);
    keyNames[0] = "id";
  }

  /**
   * @notice Get the table's value field names.
   * @return fieldNames An array of strings with the names of value fields.
   */
  function getFieldNames() internal pure returns (string[] memory fieldNames) {
    fieldNames = new string[](8);
    fieldNames[0] = "wallet";
    fieldNames[1] = "gold";
    fieldNames[2] = "infantry";
    fieldNames[3] = "cavalryA";
    fieldNames[4] = "cavalryB";
    fieldNames[5] = "cavalryC";
    fieldNames[6] = "lands";
    fieldNames[7] = "isSpawnCapital";
  }

  /**
   * @notice Register the table with its config.
   */
  function register() internal {
    StoreSwitch.registerTable(_tableId, _fieldLayout, _keySchema, _valueSchema, getKeyNames(), getFieldNames());
  }

  /**
   * @notice Register the table with its config.
   */
  function _register() internal {
    StoreCore.registerTable(_tableId, _fieldLayout, _keySchema, _valueSchema, getKeyNames(), getFieldNames());
  }

  /**
   * @notice Get wallet.
   */
  function getWallet(bytes32 id) internal view returns (address wallet) {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = id;

    bytes32 _blob = StoreSwitch.getStaticField(_tableId, _keyTuple, 0, _fieldLayout);
    return (address(bytes20(_blob)));
  }

  /**
   * @notice Get wallet.
   */
  function _getWallet(bytes32 id) internal view returns (address wallet) {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = id;

    bytes32 _blob = StoreCore.getStaticField(_tableId, _keyTuple, 0, _fieldLayout);
    return (address(bytes20(_blob)));
  }

  /**
   * @notice Set wallet.
   */
  function setWallet(bytes32 id, address wallet) internal {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = id;

    StoreSwitch.setStaticField(_tableId, _keyTuple, 0, abi.encodePacked((wallet)), _fieldLayout);
  }

  /**
   * @notice Set wallet.
   */
  function _setWallet(bytes32 id, address wallet) internal {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = id;

    StoreCore.setStaticField(_tableId, _keyTuple, 0, abi.encodePacked((wallet)), _fieldLayout);
  }

  /**
   * @notice Get gold.
   */
  function getGold(bytes32 id) internal view returns (uint256 gold) {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = id;

    bytes32 _blob = StoreSwitch.getStaticField(_tableId, _keyTuple, 1, _fieldLayout);
    return (uint256(bytes32(_blob)));
  }

  /**
   * @notice Get gold.
   */
  function _getGold(bytes32 id) internal view returns (uint256 gold) {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = id;

    bytes32 _blob = StoreCore.getStaticField(_tableId, _keyTuple, 1, _fieldLayout);
    return (uint256(bytes32(_blob)));
  }

  /**
   * @notice Set gold.
   */
  function setGold(bytes32 id, uint256 gold) internal {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = id;

    StoreSwitch.setStaticField(_tableId, _keyTuple, 1, abi.encodePacked((gold)), _fieldLayout);
  }

  /**
   * @notice Set gold.
   */
  function _setGold(bytes32 id, uint256 gold) internal {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = id;

    StoreCore.setStaticField(_tableId, _keyTuple, 1, abi.encodePacked((gold)), _fieldLayout);
  }

  /**
   * @notice Get infantry.
   */
  function getInfantry(bytes32 id) internal view returns (uint256 infantry) {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = id;

    bytes32 _blob = StoreSwitch.getStaticField(_tableId, _keyTuple, 2, _fieldLayout);
    return (uint256(bytes32(_blob)));
  }

  /**
   * @notice Get infantry.
   */
  function _getInfantry(bytes32 id) internal view returns (uint256 infantry) {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = id;

    bytes32 _blob = StoreCore.getStaticField(_tableId, _keyTuple, 2, _fieldLayout);
    return (uint256(bytes32(_blob)));
  }

  /**
   * @notice Set infantry.
   */
  function setInfantry(bytes32 id, uint256 infantry) internal {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = id;

    StoreSwitch.setStaticField(_tableId, _keyTuple, 2, abi.encodePacked((infantry)), _fieldLayout);
  }

  /**
   * @notice Set infantry.
   */
  function _setInfantry(bytes32 id, uint256 infantry) internal {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = id;

    StoreCore.setStaticField(_tableId, _keyTuple, 2, abi.encodePacked((infantry)), _fieldLayout);
  }

  /**
   * @notice Get cavalryA.
   */
  function getCavalryA(bytes32 id) internal view returns (uint256 cavalryA) {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = id;

    bytes32 _blob = StoreSwitch.getStaticField(_tableId, _keyTuple, 3, _fieldLayout);
    return (uint256(bytes32(_blob)));
  }

  /**
   * @notice Get cavalryA.
   */
  function _getCavalryA(bytes32 id) internal view returns (uint256 cavalryA) {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = id;

    bytes32 _blob = StoreCore.getStaticField(_tableId, _keyTuple, 3, _fieldLayout);
    return (uint256(bytes32(_blob)));
  }

  /**
   * @notice Set cavalryA.
   */
  function setCavalryA(bytes32 id, uint256 cavalryA) internal {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = id;

    StoreSwitch.setStaticField(_tableId, _keyTuple, 3, abi.encodePacked((cavalryA)), _fieldLayout);
  }

  /**
   * @notice Set cavalryA.
   */
  function _setCavalryA(bytes32 id, uint256 cavalryA) internal {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = id;

    StoreCore.setStaticField(_tableId, _keyTuple, 3, abi.encodePacked((cavalryA)), _fieldLayout);
  }

  /**
   * @notice Get cavalryB.
   */
  function getCavalryB(bytes32 id) internal view returns (uint256 cavalryB) {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = id;

    bytes32 _blob = StoreSwitch.getStaticField(_tableId, _keyTuple, 4, _fieldLayout);
    return (uint256(bytes32(_blob)));
  }

  /**
   * @notice Get cavalryB.
   */
  function _getCavalryB(bytes32 id) internal view returns (uint256 cavalryB) {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = id;

    bytes32 _blob = StoreCore.getStaticField(_tableId, _keyTuple, 4, _fieldLayout);
    return (uint256(bytes32(_blob)));
  }

  /**
   * @notice Set cavalryB.
   */
  function setCavalryB(bytes32 id, uint256 cavalryB) internal {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = id;

    StoreSwitch.setStaticField(_tableId, _keyTuple, 4, abi.encodePacked((cavalryB)), _fieldLayout);
  }

  /**
   * @notice Set cavalryB.
   */
  function _setCavalryB(bytes32 id, uint256 cavalryB) internal {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = id;

    StoreCore.setStaticField(_tableId, _keyTuple, 4, abi.encodePacked((cavalryB)), _fieldLayout);
  }

  /**
   * @notice Get cavalryC.
   */
  function getCavalryC(bytes32 id) internal view returns (uint256 cavalryC) {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = id;

    bytes32 _blob = StoreSwitch.getStaticField(_tableId, _keyTuple, 5, _fieldLayout);
    return (uint256(bytes32(_blob)));
  }

  /**
   * @notice Get cavalryC.
   */
  function _getCavalryC(bytes32 id) internal view returns (uint256 cavalryC) {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = id;

    bytes32 _blob = StoreCore.getStaticField(_tableId, _keyTuple, 5, _fieldLayout);
    return (uint256(bytes32(_blob)));
  }

  /**
   * @notice Set cavalryC.
   */
  function setCavalryC(bytes32 id, uint256 cavalryC) internal {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = id;

    StoreSwitch.setStaticField(_tableId, _keyTuple, 5, abi.encodePacked((cavalryC)), _fieldLayout);
  }

  /**
   * @notice Set cavalryC.
   */
  function _setCavalryC(bytes32 id, uint256 cavalryC) internal {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = id;

    StoreCore.setStaticField(_tableId, _keyTuple, 5, abi.encodePacked((cavalryC)), _fieldLayout);
  }

  /**
   * @notice Get lands.
   */
  function getLands(bytes32 id) internal view returns (uint16 lands) {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = id;

    bytes32 _blob = StoreSwitch.getStaticField(_tableId, _keyTuple, 6, _fieldLayout);
    return (uint16(bytes2(_blob)));
  }

  /**
   * @notice Get lands.
   */
  function _getLands(bytes32 id) internal view returns (uint16 lands) {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = id;

    bytes32 _blob = StoreCore.getStaticField(_tableId, _keyTuple, 6, _fieldLayout);
    return (uint16(bytes2(_blob)));
  }

  /**
   * @notice Set lands.
   */
  function setLands(bytes32 id, uint16 lands) internal {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = id;

    StoreSwitch.setStaticField(_tableId, _keyTuple, 6, abi.encodePacked((lands)), _fieldLayout);
  }

  /**
   * @notice Set lands.
   */
  function _setLands(bytes32 id, uint16 lands) internal {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = id;

    StoreCore.setStaticField(_tableId, _keyTuple, 6, abi.encodePacked((lands)), _fieldLayout);
  }

  /**
   * @notice Get isSpawnCapital.
   */
  function getIsSpawnCapital(bytes32 id) internal view returns (bool isSpawnCapital) {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = id;

    bytes32 _blob = StoreSwitch.getStaticField(_tableId, _keyTuple, 7, _fieldLayout);
    return (_toBool(uint8(bytes1(_blob))));
  }

  /**
   * @notice Get isSpawnCapital.
   */
  function _getIsSpawnCapital(bytes32 id) internal view returns (bool isSpawnCapital) {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = id;

    bytes32 _blob = StoreCore.getStaticField(_tableId, _keyTuple, 7, _fieldLayout);
    return (_toBool(uint8(bytes1(_blob))));
  }

  /**
   * @notice Set isSpawnCapital.
   */
  function setIsSpawnCapital(bytes32 id, bool isSpawnCapital) internal {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = id;

    StoreSwitch.setStaticField(_tableId, _keyTuple, 7, abi.encodePacked((isSpawnCapital)), _fieldLayout);
  }

  /**
   * @notice Set isSpawnCapital.
   */
  function _setIsSpawnCapital(bytes32 id, bool isSpawnCapital) internal {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = id;

    StoreCore.setStaticField(_tableId, _keyTuple, 7, abi.encodePacked((isSpawnCapital)), _fieldLayout);
  }

  /**
   * @notice Get the full data.
   */
  function get(bytes32 id) internal view returns (PlayerDetailData memory _table) {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = id;

    (bytes memory _staticData, EncodedLengths _encodedLengths, bytes memory _dynamicData) = StoreSwitch.getRecord(
      _tableId,
      _keyTuple,
      _fieldLayout
    );
    return decode(_staticData, _encodedLengths, _dynamicData);
  }

  /**
   * @notice Get the full data.
   */
  function _get(bytes32 id) internal view returns (PlayerDetailData memory _table) {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = id;

    (bytes memory _staticData, EncodedLengths _encodedLengths, bytes memory _dynamicData) = StoreCore.getRecord(
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
    bytes32 id,
    address wallet,
    uint256 gold,
    uint256 infantry,
    uint256 cavalryA,
    uint256 cavalryB,
    uint256 cavalryC,
    uint16 lands,
    bool isSpawnCapital
  ) internal {
    bytes memory _staticData = encodeStatic(
      wallet,
      gold,
      infantry,
      cavalryA,
      cavalryB,
      cavalryC,
      lands,
      isSpawnCapital
    );

    EncodedLengths _encodedLengths;
    bytes memory _dynamicData;

    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = id;

    StoreSwitch.setRecord(_tableId, _keyTuple, _staticData, _encodedLengths, _dynamicData);
  }

  /**
   * @notice Set the full data using individual values.
   */
  function _set(
    bytes32 id,
    address wallet,
    uint256 gold,
    uint256 infantry,
    uint256 cavalryA,
    uint256 cavalryB,
    uint256 cavalryC,
    uint16 lands,
    bool isSpawnCapital
  ) internal {
    bytes memory _staticData = encodeStatic(
      wallet,
      gold,
      infantry,
      cavalryA,
      cavalryB,
      cavalryC,
      lands,
      isSpawnCapital
    );

    EncodedLengths _encodedLengths;
    bytes memory _dynamicData;

    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = id;

    StoreCore.setRecord(_tableId, _keyTuple, _staticData, _encodedLengths, _dynamicData, _fieldLayout);
  }

  /**
   * @notice Set the full data using the data struct.
   */
  function set(bytes32 id, PlayerDetailData memory _table) internal {
    bytes memory _staticData = encodeStatic(
      _table.wallet,
      _table.gold,
      _table.infantry,
      _table.cavalryA,
      _table.cavalryB,
      _table.cavalryC,
      _table.lands,
      _table.isSpawnCapital
    );

    EncodedLengths _encodedLengths;
    bytes memory _dynamicData;

    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = id;

    StoreSwitch.setRecord(_tableId, _keyTuple, _staticData, _encodedLengths, _dynamicData);
  }

  /**
   * @notice Set the full data using the data struct.
   */
  function _set(bytes32 id, PlayerDetailData memory _table) internal {
    bytes memory _staticData = encodeStatic(
      _table.wallet,
      _table.gold,
      _table.infantry,
      _table.cavalryA,
      _table.cavalryB,
      _table.cavalryC,
      _table.lands,
      _table.isSpawnCapital
    );

    EncodedLengths _encodedLengths;
    bytes memory _dynamicData;

    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = id;

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
      address wallet,
      uint256 gold,
      uint256 infantry,
      uint256 cavalryA,
      uint256 cavalryB,
      uint256 cavalryC,
      uint16 lands,
      bool isSpawnCapital
    )
  {
    wallet = (address(Bytes.getBytes20(_blob, 0)));

    gold = (uint256(Bytes.getBytes32(_blob, 20)));

    infantry = (uint256(Bytes.getBytes32(_blob, 52)));

    cavalryA = (uint256(Bytes.getBytes32(_blob, 84)));

    cavalryB = (uint256(Bytes.getBytes32(_blob, 116)));

    cavalryC = (uint256(Bytes.getBytes32(_blob, 148)));

    lands = (uint16(Bytes.getBytes2(_blob, 180)));

    isSpawnCapital = (_toBool(uint8(Bytes.getBytes1(_blob, 182))));
  }

  /**
   * @notice Decode the tightly packed blobs using this table's field layout.
   * @param _staticData Tightly packed static fields.
   *
   *
   */
  function decode(
    bytes memory _staticData,
    EncodedLengths,
    bytes memory
  ) internal pure returns (PlayerDetailData memory _table) {
    (
      _table.wallet,
      _table.gold,
      _table.infantry,
      _table.cavalryA,
      _table.cavalryB,
      _table.cavalryC,
      _table.lands,
      _table.isSpawnCapital
    ) = decodeStatic(_staticData);
  }

  /**
   * @notice Delete all data for given keys.
   */
  function deleteRecord(bytes32 id) internal {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = id;

    StoreSwitch.deleteRecord(_tableId, _keyTuple);
  }

  /**
   * @notice Delete all data for given keys.
   */
  function _deleteRecord(bytes32 id) internal {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = id;

    StoreCore.deleteRecord(_tableId, _keyTuple, _fieldLayout);
  }

  /**
   * @notice Tightly pack static (fixed length) data using this table's schema.
   * @return The static data, encoded into a sequence of bytes.
   */
  function encodeStatic(
    address wallet,
    uint256 gold,
    uint256 infantry,
    uint256 cavalryA,
    uint256 cavalryB,
    uint256 cavalryC,
    uint16 lands,
    bool isSpawnCapital
  ) internal pure returns (bytes memory) {
    return abi.encodePacked(wallet, gold, infantry, cavalryA, cavalryB, cavalryC, lands, isSpawnCapital);
  }

  /**
   * @notice Encode all of a record's fields.
   * @return The static (fixed length) data, encoded into a sequence of bytes.
   * @return The lengths of the dynamic fields (packed into a single bytes32 value).
   * @return The dynamic (variable length) data, encoded into a sequence of bytes.
   */
  function encode(
    address wallet,
    uint256 gold,
    uint256 infantry,
    uint256 cavalryA,
    uint256 cavalryB,
    uint256 cavalryC,
    uint16 lands,
    bool isSpawnCapital
  ) internal pure returns (bytes memory, EncodedLengths, bytes memory) {
    bytes memory _staticData = encodeStatic(
      wallet,
      gold,
      infantry,
      cavalryA,
      cavalryB,
      cavalryC,
      lands,
      isSpawnCapital
    );

    EncodedLengths _encodedLengths;
    bytes memory _dynamicData;

    return (_staticData, _encodedLengths, _dynamicData);
  }

  /**
   * @notice Encode keys as a bytes32 array using this table's field layout.
   */
  function encodeKeyTuple(bytes32 id) internal pure returns (bytes32[] memory) {
    bytes32[] memory _keyTuple = new bytes32[](1);
    _keyTuple[0] = id;

    return _keyTuple;
  }
}

/**
 * @notice Cast a value to a bool.
 * @dev Boolean values are encoded as uint8 (1 = true, 0 = false), but Solidity doesn't allow casting between uint8 and bool.
 * @param value The uint8 value to convert.
 * @return result The boolean value.
 */
function _toBool(uint8 value) pure returns (bool result) {
  assembly {
    result := value
  }
}
