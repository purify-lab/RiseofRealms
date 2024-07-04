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

struct BattleReportData {
  address attacker;
  address defender;
  bool attackWin;
  uint256[8] losses;
}

library BattleReport {
  // Hex below is the result of `WorldResourceIdLib.encode({ namespace: "", name: "BattleReport", typeId: RESOURCE_TABLE });`
  ResourceId constant _tableId = ResourceId.wrap(0x74620000000000000000000000000000426174746c655265706f727400000000);

  FieldLayout constant _fieldLayout =
    FieldLayout.wrap(0x0029030114140100000000000000000000000000000000000000000000000000);

  // Hex-encoded key schema of (uint16, uint256)
  Schema constant _keySchema = Schema.wrap(0x00220200011f0000000000000000000000000000000000000000000000000000);
  // Hex-encoded value schema of (address, address, bool, uint256[])
  Schema constant _valueSchema = Schema.wrap(0x0029030161616081000000000000000000000000000000000000000000000000);

  /**
   * @notice Get the table's key field names.
   * @return keyNames An array of strings with the names of key fields.
   */
  function getKeyNames() internal pure returns (string[] memory keyNames) {
    keyNames = new string[](2);
    keyNames[0] = "capitalId";
    keyNames[1] = "timestamp";
  }

  /**
   * @notice Get the table's value field names.
   * @return fieldNames An array of strings with the names of value fields.
   */
  function getFieldNames() internal pure returns (string[] memory fieldNames) {
    fieldNames = new string[](4);
    fieldNames[0] = "attacker";
    fieldNames[1] = "defender";
    fieldNames[2] = "attackWin";
    fieldNames[3] = "losses";
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
   * @notice Get attacker.
   */
  function getAttacker(uint16 capitalId, uint256 timestamp) internal view returns (address attacker) {
    bytes32[] memory _keyTuple = new bytes32[](2);
    _keyTuple[0] = bytes32(uint256(capitalId));
    _keyTuple[1] = bytes32(uint256(timestamp));

    bytes32 _blob = StoreSwitch.getStaticField(_tableId, _keyTuple, 0, _fieldLayout);
    return (address(bytes20(_blob)));
  }

  /**
   * @notice Get attacker.
   */
  function _getAttacker(uint16 capitalId, uint256 timestamp) internal view returns (address attacker) {
    bytes32[] memory _keyTuple = new bytes32[](2);
    _keyTuple[0] = bytes32(uint256(capitalId));
    _keyTuple[1] = bytes32(uint256(timestamp));

    bytes32 _blob = StoreCore.getStaticField(_tableId, _keyTuple, 0, _fieldLayout);
    return (address(bytes20(_blob)));
  }

  /**
   * @notice Set attacker.
   */
  function setAttacker(uint16 capitalId, uint256 timestamp, address attacker) internal {
    bytes32[] memory _keyTuple = new bytes32[](2);
    _keyTuple[0] = bytes32(uint256(capitalId));
    _keyTuple[1] = bytes32(uint256(timestamp));

    StoreSwitch.setStaticField(_tableId, _keyTuple, 0, abi.encodePacked((attacker)), _fieldLayout);
  }

  /**
   * @notice Set attacker.
   */
  function _setAttacker(uint16 capitalId, uint256 timestamp, address attacker) internal {
    bytes32[] memory _keyTuple = new bytes32[](2);
    _keyTuple[0] = bytes32(uint256(capitalId));
    _keyTuple[1] = bytes32(uint256(timestamp));

    StoreCore.setStaticField(_tableId, _keyTuple, 0, abi.encodePacked((attacker)), _fieldLayout);
  }

  /**
   * @notice Get defender.
   */
  function getDefender(uint16 capitalId, uint256 timestamp) internal view returns (address defender) {
    bytes32[] memory _keyTuple = new bytes32[](2);
    _keyTuple[0] = bytes32(uint256(capitalId));
    _keyTuple[1] = bytes32(uint256(timestamp));

    bytes32 _blob = StoreSwitch.getStaticField(_tableId, _keyTuple, 1, _fieldLayout);
    return (address(bytes20(_blob)));
  }

  /**
   * @notice Get defender.
   */
  function _getDefender(uint16 capitalId, uint256 timestamp) internal view returns (address defender) {
    bytes32[] memory _keyTuple = new bytes32[](2);
    _keyTuple[0] = bytes32(uint256(capitalId));
    _keyTuple[1] = bytes32(uint256(timestamp));

    bytes32 _blob = StoreCore.getStaticField(_tableId, _keyTuple, 1, _fieldLayout);
    return (address(bytes20(_blob)));
  }

  /**
   * @notice Set defender.
   */
  function setDefender(uint16 capitalId, uint256 timestamp, address defender) internal {
    bytes32[] memory _keyTuple = new bytes32[](2);
    _keyTuple[0] = bytes32(uint256(capitalId));
    _keyTuple[1] = bytes32(uint256(timestamp));

    StoreSwitch.setStaticField(_tableId, _keyTuple, 1, abi.encodePacked((defender)), _fieldLayout);
  }

  /**
   * @notice Set defender.
   */
  function _setDefender(uint16 capitalId, uint256 timestamp, address defender) internal {
    bytes32[] memory _keyTuple = new bytes32[](2);
    _keyTuple[0] = bytes32(uint256(capitalId));
    _keyTuple[1] = bytes32(uint256(timestamp));

    StoreCore.setStaticField(_tableId, _keyTuple, 1, abi.encodePacked((defender)), _fieldLayout);
  }

  /**
   * @notice Get attackWin.
   */
  function getAttackWin(uint16 capitalId, uint256 timestamp) internal view returns (bool attackWin) {
    bytes32[] memory _keyTuple = new bytes32[](2);
    _keyTuple[0] = bytes32(uint256(capitalId));
    _keyTuple[1] = bytes32(uint256(timestamp));

    bytes32 _blob = StoreSwitch.getStaticField(_tableId, _keyTuple, 2, _fieldLayout);
    return (_toBool(uint8(bytes1(_blob))));
  }

  /**
   * @notice Get attackWin.
   */
  function _getAttackWin(uint16 capitalId, uint256 timestamp) internal view returns (bool attackWin) {
    bytes32[] memory _keyTuple = new bytes32[](2);
    _keyTuple[0] = bytes32(uint256(capitalId));
    _keyTuple[1] = bytes32(uint256(timestamp));

    bytes32 _blob = StoreCore.getStaticField(_tableId, _keyTuple, 2, _fieldLayout);
    return (_toBool(uint8(bytes1(_blob))));
  }

  /**
   * @notice Set attackWin.
   */
  function setAttackWin(uint16 capitalId, uint256 timestamp, bool attackWin) internal {
    bytes32[] memory _keyTuple = new bytes32[](2);
    _keyTuple[0] = bytes32(uint256(capitalId));
    _keyTuple[1] = bytes32(uint256(timestamp));

    StoreSwitch.setStaticField(_tableId, _keyTuple, 2, abi.encodePacked((attackWin)), _fieldLayout);
  }

  /**
   * @notice Set attackWin.
   */
  function _setAttackWin(uint16 capitalId, uint256 timestamp, bool attackWin) internal {
    bytes32[] memory _keyTuple = new bytes32[](2);
    _keyTuple[0] = bytes32(uint256(capitalId));
    _keyTuple[1] = bytes32(uint256(timestamp));

    StoreCore.setStaticField(_tableId, _keyTuple, 2, abi.encodePacked((attackWin)), _fieldLayout);
  }

  /**
   * @notice Get losses.
   */
  function getLosses(uint16 capitalId, uint256 timestamp) internal view returns (uint256[8] memory losses) {
    bytes32[] memory _keyTuple = new bytes32[](2);
    _keyTuple[0] = bytes32(uint256(capitalId));
    _keyTuple[1] = bytes32(uint256(timestamp));

    bytes memory _blob = StoreSwitch.getDynamicField(_tableId, _keyTuple, 0);
    return toStaticArray_uint256_8(SliceLib.getSubslice(_blob, 0, _blob.length).decodeArray_uint256());
  }

  /**
   * @notice Get losses.
   */
  function _getLosses(uint16 capitalId, uint256 timestamp) internal view returns (uint256[8] memory losses) {
    bytes32[] memory _keyTuple = new bytes32[](2);
    _keyTuple[0] = bytes32(uint256(capitalId));
    _keyTuple[1] = bytes32(uint256(timestamp));

    bytes memory _blob = StoreCore.getDynamicField(_tableId, _keyTuple, 0);
    return toStaticArray_uint256_8(SliceLib.getSubslice(_blob, 0, _blob.length).decodeArray_uint256());
  }

  /**
   * @notice Set losses.
   */
  function setLosses(uint16 capitalId, uint256 timestamp, uint256[8] memory losses) internal {
    bytes32[] memory _keyTuple = new bytes32[](2);
    _keyTuple[0] = bytes32(uint256(capitalId));
    _keyTuple[1] = bytes32(uint256(timestamp));

    StoreSwitch.setDynamicField(_tableId, _keyTuple, 0, EncodeArray.encode(fromStaticArray_uint256_8(losses)));
  }

  /**
   * @notice Set losses.
   */
  function _setLosses(uint16 capitalId, uint256 timestamp, uint256[8] memory losses) internal {
    bytes32[] memory _keyTuple = new bytes32[](2);
    _keyTuple[0] = bytes32(uint256(capitalId));
    _keyTuple[1] = bytes32(uint256(timestamp));

    StoreCore.setDynamicField(_tableId, _keyTuple, 0, EncodeArray.encode(fromStaticArray_uint256_8(losses)));
  }

  // The length of losses
  uint256 constant lengthLosses = 8;

  /**
   * @notice Get an item of losses.
   * @dev Reverts with Store_IndexOutOfBounds if `_index` is out of bounds for the array.
   */
  function getItemLosses(uint16 capitalId, uint256 timestamp, uint256 _index) internal view returns (uint256) {
    bytes32[] memory _keyTuple = new bytes32[](2);
    _keyTuple[0] = bytes32(uint256(capitalId));
    _keyTuple[1] = bytes32(uint256(timestamp));

    uint256 _byteLength = StoreSwitch.getDynamicFieldLength(_tableId, _keyTuple, 0);
    uint256 dynamicLength = _byteLength / 32;
    uint256 staticLength = 8;

    if (_index < staticLength && _index >= dynamicLength) {
      return (uint256(bytes32(new bytes(0))));
    }

    unchecked {
      bytes memory _blob = StoreSwitch.getDynamicFieldSlice(_tableId, _keyTuple, 0, _index * 32, (_index + 1) * 32);
      return (uint256(bytes32(_blob)));
    }
  }

  /**
   * @notice Get an item of losses.
   * @dev Reverts with Store_IndexOutOfBounds if `_index` is out of bounds for the array.
   */
  function _getItemLosses(uint16 capitalId, uint256 timestamp, uint256 _index) internal view returns (uint256) {
    bytes32[] memory _keyTuple = new bytes32[](2);
    _keyTuple[0] = bytes32(uint256(capitalId));
    _keyTuple[1] = bytes32(uint256(timestamp));

    uint256 _byteLength = StoreCore.getDynamicFieldLength(_tableId, _keyTuple, 0);
    uint256 dynamicLength = _byteLength / 32;
    uint256 staticLength = 8;

    if (_index < staticLength && _index >= dynamicLength) {
      return (uint256(bytes32(new bytes(0))));
    }

    unchecked {
      bytes memory _blob = StoreCore.getDynamicFieldSlice(_tableId, _keyTuple, 0, _index * 32, (_index + 1) * 32);
      return (uint256(bytes32(_blob)));
    }
  }

  /**
   * @notice Update an element of losses at `_index`.
   */
  function updateLosses(uint16 capitalId, uint256 timestamp, uint256 _index, uint256 _element) internal {
    bytes32[] memory _keyTuple = new bytes32[](2);
    _keyTuple[0] = bytes32(uint256(capitalId));
    _keyTuple[1] = bytes32(uint256(timestamp));

    unchecked {
      bytes memory _encoded = abi.encodePacked((_element));
      StoreSwitch.spliceDynamicData(_tableId, _keyTuple, 0, uint40(_index * 32), uint40(_encoded.length), _encoded);
    }
  }

  /**
   * @notice Update an element of losses at `_index`.
   */
  function _updateLosses(uint16 capitalId, uint256 timestamp, uint256 _index, uint256 _element) internal {
    bytes32[] memory _keyTuple = new bytes32[](2);
    _keyTuple[0] = bytes32(uint256(capitalId));
    _keyTuple[1] = bytes32(uint256(timestamp));

    unchecked {
      bytes memory _encoded = abi.encodePacked((_element));
      StoreCore.spliceDynamicData(_tableId, _keyTuple, 0, uint40(_index * 32), uint40(_encoded.length), _encoded);
    }
  }

  /**
   * @notice Get the full data.
   */
  function get(uint16 capitalId, uint256 timestamp) internal view returns (BattleReportData memory _table) {
    bytes32[] memory _keyTuple = new bytes32[](2);
    _keyTuple[0] = bytes32(uint256(capitalId));
    _keyTuple[1] = bytes32(uint256(timestamp));

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
  function _get(uint16 capitalId, uint256 timestamp) internal view returns (BattleReportData memory _table) {
    bytes32[] memory _keyTuple = new bytes32[](2);
    _keyTuple[0] = bytes32(uint256(capitalId));
    _keyTuple[1] = bytes32(uint256(timestamp));

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
    uint16 capitalId,
    uint256 timestamp,
    address attacker,
    address defender,
    bool attackWin,
    uint256[8] memory losses
  ) internal {
    bytes memory _staticData = encodeStatic(attacker, defender, attackWin);

    EncodedLengths _encodedLengths = encodeLengths(losses);
    bytes memory _dynamicData = encodeDynamic(losses);

    bytes32[] memory _keyTuple = new bytes32[](2);
    _keyTuple[0] = bytes32(uint256(capitalId));
    _keyTuple[1] = bytes32(uint256(timestamp));

    StoreSwitch.setRecord(_tableId, _keyTuple, _staticData, _encodedLengths, _dynamicData);
  }

  /**
   * @notice Set the full data using individual values.
   */
  function _set(
    uint16 capitalId,
    uint256 timestamp,
    address attacker,
    address defender,
    bool attackWin,
    uint256[8] memory losses
  ) internal {
    bytes memory _staticData = encodeStatic(attacker, defender, attackWin);

    EncodedLengths _encodedLengths = encodeLengths(losses);
    bytes memory _dynamicData = encodeDynamic(losses);

    bytes32[] memory _keyTuple = new bytes32[](2);
    _keyTuple[0] = bytes32(uint256(capitalId));
    _keyTuple[1] = bytes32(uint256(timestamp));

    StoreCore.setRecord(_tableId, _keyTuple, _staticData, _encodedLengths, _dynamicData, _fieldLayout);
  }

  /**
   * @notice Set the full data using the data struct.
   */
  function set(uint16 capitalId, uint256 timestamp, BattleReportData memory _table) internal {
    bytes memory _staticData = encodeStatic(_table.attacker, _table.defender, _table.attackWin);

    EncodedLengths _encodedLengths = encodeLengths(_table.losses);
    bytes memory _dynamicData = encodeDynamic(_table.losses);

    bytes32[] memory _keyTuple = new bytes32[](2);
    _keyTuple[0] = bytes32(uint256(capitalId));
    _keyTuple[1] = bytes32(uint256(timestamp));

    StoreSwitch.setRecord(_tableId, _keyTuple, _staticData, _encodedLengths, _dynamicData);
  }

  /**
   * @notice Set the full data using the data struct.
   */
  function _set(uint16 capitalId, uint256 timestamp, BattleReportData memory _table) internal {
    bytes memory _staticData = encodeStatic(_table.attacker, _table.defender, _table.attackWin);

    EncodedLengths _encodedLengths = encodeLengths(_table.losses);
    bytes memory _dynamicData = encodeDynamic(_table.losses);

    bytes32[] memory _keyTuple = new bytes32[](2);
    _keyTuple[0] = bytes32(uint256(capitalId));
    _keyTuple[1] = bytes32(uint256(timestamp));

    StoreCore.setRecord(_tableId, _keyTuple, _staticData, _encodedLengths, _dynamicData, _fieldLayout);
  }

  /**
   * @notice Decode the tightly packed blob of static data using this table's field layout.
   */
  function decodeStatic(bytes memory _blob) internal pure returns (address attacker, address defender, bool attackWin) {
    attacker = (address(Bytes.getBytes20(_blob, 0)));

    defender = (address(Bytes.getBytes20(_blob, 20)));

    attackWin = (_toBool(uint8(Bytes.getBytes1(_blob, 40))));
  }

  /**
   * @notice Decode the tightly packed blob of dynamic data using the encoded lengths.
   */
  function decodeDynamic(
    EncodedLengths _encodedLengths,
    bytes memory _blob
  ) internal pure returns (uint256[8] memory losses) {
    uint256 _start;
    uint256 _end;
    unchecked {
      _end = _encodedLengths.atIndex(0);
    }
    losses = toStaticArray_uint256_8(SliceLib.getSubslice(_blob, _start, _end).decodeArray_uint256());
  }

  /**
   * @notice Decode the tightly packed blobs using this table's field layout.
   * @param _staticData Tightly packed static fields.
   * @param _encodedLengths Encoded lengths of dynamic fields.
   * @param _dynamicData Tightly packed dynamic fields.
   */
  function decode(
    bytes memory _staticData,
    EncodedLengths _encodedLengths,
    bytes memory _dynamicData
  ) internal pure returns (BattleReportData memory _table) {
    (_table.attacker, _table.defender, _table.attackWin) = decodeStatic(_staticData);

    (_table.losses) = decodeDynamic(_encodedLengths, _dynamicData);
  }

  /**
   * @notice Delete all data for given keys.
   */
  function deleteRecord(uint16 capitalId, uint256 timestamp) internal {
    bytes32[] memory _keyTuple = new bytes32[](2);
    _keyTuple[0] = bytes32(uint256(capitalId));
    _keyTuple[1] = bytes32(uint256(timestamp));

    StoreSwitch.deleteRecord(_tableId, _keyTuple);
  }

  /**
   * @notice Delete all data for given keys.
   */
  function _deleteRecord(uint16 capitalId, uint256 timestamp) internal {
    bytes32[] memory _keyTuple = new bytes32[](2);
    _keyTuple[0] = bytes32(uint256(capitalId));
    _keyTuple[1] = bytes32(uint256(timestamp));

    StoreCore.deleteRecord(_tableId, _keyTuple, _fieldLayout);
  }

  /**
   * @notice Tightly pack static (fixed length) data using this table's schema.
   * @return The static data, encoded into a sequence of bytes.
   */
  function encodeStatic(address attacker, address defender, bool attackWin) internal pure returns (bytes memory) {
    return abi.encodePacked(attacker, defender, attackWin);
  }

  /**
   * @notice Tightly pack dynamic data lengths using this table's schema.
   * @return _encodedLengths The lengths of the dynamic fields (packed into a single bytes32 value).
   */
  function encodeLengths(uint256[8] memory losses) internal pure returns (EncodedLengths _encodedLengths) {
    // Lengths are effectively checked during copy by 2**40 bytes exceeding gas limits
    unchecked {
      _encodedLengths = EncodedLengthsLib.pack(losses.length * 32);
    }
  }

  /**
   * @notice Tightly pack dynamic (variable length) data using this table's schema.
   * @return The dynamic data, encoded into a sequence of bytes.
   */
  function encodeDynamic(uint256[8] memory losses) internal pure returns (bytes memory) {
    return abi.encodePacked(EncodeArray.encode(fromStaticArray_uint256_8(losses)));
  }

  /**
   * @notice Encode all of a record's fields.
   * @return The static (fixed length) data, encoded into a sequence of bytes.
   * @return The lengths of the dynamic fields (packed into a single bytes32 value).
   * @return The dynamic (variable length) data, encoded into a sequence of bytes.
   */
  function encode(
    address attacker,
    address defender,
    bool attackWin,
    uint256[8] memory losses
  ) internal pure returns (bytes memory, EncodedLengths, bytes memory) {
    bytes memory _staticData = encodeStatic(attacker, defender, attackWin);

    EncodedLengths _encodedLengths = encodeLengths(losses);
    bytes memory _dynamicData = encodeDynamic(losses);

    return (_staticData, _encodedLengths, _dynamicData);
  }

  /**
   * @notice Encode keys as a bytes32 array using this table's field layout.
   */
  function encodeKeyTuple(uint16 capitalId, uint256 timestamp) internal pure returns (bytes32[] memory) {
    bytes32[] memory _keyTuple = new bytes32[](2);
    _keyTuple[0] = bytes32(uint256(capitalId));
    _keyTuple[1] = bytes32(uint256(timestamp));

    return _keyTuple;
  }
}

/**
 * @notice Cast a dynamic array to a static array.
 * @dev In memory static arrays are just dynamic arrays without the 32 length bytes,
 * so this function moves the pointer to the first element of the dynamic array.
 * If the length of the dynamic array is smaller than the static length,
 * the function returns an uninitialized array to avoid memory corruption.
 * @param _value The dynamic array to cast.
 * @return _result The static array.
 */
function toStaticArray_uint256_8(uint256[] memory _value) pure returns (uint256[8] memory _result) {
  if (_value.length < 8) {
    // return an uninitialized array if the length is smaller than the fixed length to avoid memory corruption
    return _result;
  } else {
    // in memory static arrays are just dynamic arrays without the 32 length bytes
    // (without the length check this could lead to memory corruption)
    assembly {
      _result := add(_value, 0x20)
    }
  }
}

/**
 * @notice Copy a static array to a dynamic array.
 * @dev Static arrays don't have a length prefix, so this function copies the memory from the static array to a new dynamic array.
 * @param _value The static array to copy.
 * @return _result The dynamic array.
 */
function fromStaticArray_uint256_8(uint256[8] memory _value) pure returns (uint256[] memory _result) {
  _result = new uint256[](8);
  uint256 fromPointer;
  uint256 toPointer;
  assembly {
    fromPointer := _value
    toPointer := add(_result, 0x20)
  }
  Memory.copy(fromPointer, toPointer, 256);
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
