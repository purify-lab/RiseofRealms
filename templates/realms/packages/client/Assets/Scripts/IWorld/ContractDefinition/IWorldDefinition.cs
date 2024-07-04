using System;
using System.Threading.Tasks;
using System.Collections.Generic;
using System.Numerics;
using Nethereum.Hex.HexTypes;
using Nethereum.ABI.FunctionEncoding.Attributes;
using Nethereum.RPC.Eth.DTOs;
using Nethereum.Contracts.CQS;
using Nethereum.Contracts;
using System.Threading;

namespace IWorld.ContractDefinition
{


    public partial class IWorldDeployment : IWorldDeploymentBase
    {
        public IWorldDeployment() : base(BYTECODE) { }
        public IWorldDeployment(string byteCode) : base(byteCode) { }
    }

    public class IWorldDeploymentBase : ContractDeploymentMessage
    {
        public static string BYTECODE = "";
        public IWorldDeploymentBase() : base(BYTECODE) { }
        public IWorldDeploymentBase(string byteCode) : base(byteCode) { }

    }

    public partial class AttackFunction : AttackFunctionBase { }

    [Function("attack")]
    public class AttackFunctionBase : FunctionMessage
    {
        [Parameter("uint8", "army_id", 1)]
        public virtual byte ArmyId { get; set; }
    }

    public partial class BatchCallFunction : BatchCallFunctionBase { }

    [Function("batchCall", "bytes[]")]
    public class BatchCallFunctionBase : FunctionMessage
    {
        [Parameter("tuple[]", "systemCalls", 1)]
        public virtual List<SystemCallData> SystemCalls { get; set; }
    }

    public partial class BatchCallFromFunction : BatchCallFromFunctionBase { }

    [Function("batchCallFrom", "bytes[]")]
    public class BatchCallFromFunctionBase : FunctionMessage
    {
        [Parameter("tuple[]", "systemCalls", 1)]
        public virtual List<SystemCallFromData> SystemCalls { get; set; }
    }

    public partial class BuyCavalryAFunction : BuyCavalryAFunctionBase { }

    [Function("buyCavalryA")]
    public class BuyCavalryAFunctionBase : FunctionMessage
    {
        [Parameter("uint256", "amount", 1)]
        public virtual BigInteger Amount { get; set; }
    }

    public partial class BuyCavalryBFunction : BuyCavalryBFunctionBase { }

    [Function("buyCavalryB")]
    public class BuyCavalryBFunctionBase : FunctionMessage
    {
        [Parameter("uint256", "amount", 1)]
        public virtual BigInteger Amount { get; set; }
    }

    public partial class BuyCavalryCFunction : BuyCavalryCFunctionBase { }

    [Function("buyCavalryC")]
    public class BuyCavalryCFunctionBase : FunctionMessage
    {
        [Parameter("uint256", "amount", 1)]
        public virtual BigInteger Amount { get; set; }
    }

    public partial class BuyInfantryFunction : BuyInfantryFunctionBase { }

    [Function("buyInfantry")]
    public class BuyInfantryFunctionBase : FunctionMessage
    {
        [Parameter("uint256", "amount", 1)]
        public virtual BigInteger Amount { get; set; }
    }

    public partial class BuyInfantryByTokenFunction : BuyInfantryByTokenFunctionBase { }

    [Function("buyInfantryByToken")]
    public class BuyInfantryByTokenFunctionBase : FunctionMessage
    {
        [Parameter("uint8", "token_type", 1)]
        public virtual byte TokenType { get; set; }
        [Parameter("uint256", "amount", 2)]
        public virtual BigInteger Amount { get; set; }
    }

    public partial class CallFunction : CallFunctionBase { }

    [Function("call", "bytes")]
    public class CallFunctionBase : FunctionMessage
    {
        [Parameter("bytes32", "systemId", 1)]
        public virtual byte[] SystemId { get; set; }
        [Parameter("bytes", "callData", 2)]
        public virtual byte[] CallData { get; set; }
    }

    public partial class CallFromFunction : CallFromFunctionBase { }

    [Function("callFrom", "bytes")]
    public class CallFromFunctionBase : FunctionMessage
    {
        [Parameter("address", "delegator", 1)]
        public virtual string Delegator { get; set; }
        [Parameter("bytes32", "systemId", 2)]
        public virtual byte[] SystemId { get; set; }
        [Parameter("bytes", "callData", 3)]
        public virtual byte[] CallData { get; set; }
    }

    public partial class CreatorFunction : CreatorFunctionBase { }

    [Function("creator", "address")]
    public class CreatorFunctionBase : FunctionMessage
    {

    }

    public partial class DeleteRecordFunction : DeleteRecordFunctionBase { }

    [Function("deleteRecord")]
    public class DeleteRecordFunctionBase : FunctionMessage
    {
        [Parameter("bytes32", "tableId", 1)]
        public virtual byte[] TableId { get; set; }
        [Parameter("bytes32[]", "keyTuple", 2)]
        public virtual List<byte[]> KeyTuple { get; set; }
    }

    public partial class FarmingFunction : FarmingFunctionBase { }

    [Function("farming")]
    public class FarmingFunctionBase : FunctionMessage
    {
        [Parameter("uint16", "capital_id", 1)]
        public virtual ushort CapitalId { get; set; }
    }

    public partial class GarrisonFunction : GarrisonFunctionBase { }

    [Function("garrison")]
    public class GarrisonFunctionBase : FunctionMessage
    {
        [Parameter("uint16", "capital_id", 1)]
        public virtual ushort CapitalId { get; set; }
        [Parameter("uint256", "infantry", 2)]
        public virtual BigInteger Infantry { get; set; }
        [Parameter("uint256", "cavalryA", 3)]
        public virtual BigInteger CavalryA { get; set; }
        [Parameter("uint256", "cavalryB", 4)]
        public virtual BigInteger CavalryB { get; set; }
        [Parameter("uint256", "cavalryC", 5)]
        public virtual BigInteger CavalryC { get; set; }
    }

    public partial class GetDynamicFieldFunction : GetDynamicFieldFunctionBase { }

    [Function("getDynamicField", "bytes")]
    public class GetDynamicFieldFunctionBase : FunctionMessage
    {
        [Parameter("bytes32", "tableId", 1)]
        public virtual byte[] TableId { get; set; }
        [Parameter("bytes32[]", "keyTuple", 2)]
        public virtual List<byte[]> KeyTuple { get; set; }
        [Parameter("uint8", "dynamicFieldIndex", 3)]
        public virtual byte DynamicFieldIndex { get; set; }
    }

    public partial class GetDynamicFieldLengthFunction : GetDynamicFieldLengthFunctionBase { }

    [Function("getDynamicFieldLength", "uint256")]
    public class GetDynamicFieldLengthFunctionBase : FunctionMessage
    {
        [Parameter("bytes32", "tableId", 1)]
        public virtual byte[] TableId { get; set; }
        [Parameter("bytes32[]", "keyTuple", 2)]
        public virtual List<byte[]> KeyTuple { get; set; }
        [Parameter("uint8", "dynamicFieldIndex", 3)]
        public virtual byte DynamicFieldIndex { get; set; }
    }

    public partial class GetDynamicFieldSliceFunction : GetDynamicFieldSliceFunctionBase { }

    [Function("getDynamicFieldSlice", "bytes")]
    public class GetDynamicFieldSliceFunctionBase : FunctionMessage
    {
        [Parameter("bytes32", "tableId", 1)]
        public virtual byte[] TableId { get; set; }
        [Parameter("bytes32[]", "keyTuple", 2)]
        public virtual List<byte[]> KeyTuple { get; set; }
        [Parameter("uint8", "dynamicFieldIndex", 3)]
        public virtual byte DynamicFieldIndex { get; set; }
        [Parameter("uint256", "start", 4)]
        public virtual BigInteger Start { get; set; }
        [Parameter("uint256", "end", 5)]
        public virtual BigInteger End { get; set; }
    }

    public partial class GetField1Function : GetField1FunctionBase { }

    [Function("getField", "bytes")]
    public class GetField1FunctionBase : FunctionMessage
    {
        [Parameter("bytes32", "tableId", 1)]
        public virtual byte[] TableId { get; set; }
        [Parameter("bytes32[]", "keyTuple", 2)]
        public virtual List<byte[]> KeyTuple { get; set; }
        [Parameter("uint8", "fieldIndex", 3)]
        public virtual byte FieldIndex { get; set; }
        [Parameter("bytes32", "fieldLayout", 4)]
        public virtual byte[] FieldLayout { get; set; }
    }

    public partial class GetFieldFunction : GetFieldFunctionBase { }

    [Function("getField", "bytes")]
    public class GetFieldFunctionBase : FunctionMessage
    {
        [Parameter("bytes32", "tableId", 1)]
        public virtual byte[] TableId { get; set; }
        [Parameter("bytes32[]", "keyTuple", 2)]
        public virtual List<byte[]> KeyTuple { get; set; }
        [Parameter("uint8", "fieldIndex", 3)]
        public virtual byte FieldIndex { get; set; }
    }

    public partial class GetFieldLayoutFunction : GetFieldLayoutFunctionBase { }

    [Function("getFieldLayout", "bytes32")]
    public class GetFieldLayoutFunctionBase : FunctionMessage
    {
        [Parameter("bytes32", "tableId", 1)]
        public virtual byte[] TableId { get; set; }
    }

    public partial class GetFieldLength1Function : GetFieldLength1FunctionBase { }

    [Function("getFieldLength", "uint256")]
    public class GetFieldLength1FunctionBase : FunctionMessage
    {
        [Parameter("bytes32", "tableId", 1)]
        public virtual byte[] TableId { get; set; }
        [Parameter("bytes32[]", "keyTuple", 2)]
        public virtual List<byte[]> KeyTuple { get; set; }
        [Parameter("uint8", "fieldIndex", 3)]
        public virtual byte FieldIndex { get; set; }
        [Parameter("bytes32", "fieldLayout", 4)]
        public virtual byte[] FieldLayout { get; set; }
    }

    public partial class GetFieldLengthFunction : GetFieldLengthFunctionBase { }

    [Function("getFieldLength", "uint256")]
    public class GetFieldLengthFunctionBase : FunctionMessage
    {
        [Parameter("bytes32", "tableId", 1)]
        public virtual byte[] TableId { get; set; }
        [Parameter("bytes32[]", "keyTuple", 2)]
        public virtual List<byte[]> KeyTuple { get; set; }
        [Parameter("uint8", "fieldIndex", 3)]
        public virtual byte FieldIndex { get; set; }
    }

    public partial class GetKeySchemaFunction : GetKeySchemaFunctionBase { }

    [Function("getKeySchema", "bytes32")]
    public class GetKeySchemaFunctionBase : FunctionMessage
    {
        [Parameter("bytes32", "tableId", 1)]
        public virtual byte[] TableId { get; set; }
    }

    public partial class GetRecord1Function : GetRecord1FunctionBase { }

    [Function("getRecord", typeof(GetRecord1OutputDTO))]
    public class GetRecord1FunctionBase : FunctionMessage
    {
        [Parameter("bytes32", "tableId", 1)]
        public virtual byte[] TableId { get; set; }
        [Parameter("bytes32[]", "keyTuple", 2)]
        public virtual List<byte[]> KeyTuple { get; set; }
        [Parameter("bytes32", "fieldLayout", 3)]
        public virtual byte[] FieldLayout { get; set; }
    }

    public partial class GetRecordFunction : GetRecordFunctionBase { }

    [Function("getRecord", typeof(GetRecordOutputDTO))]
    public class GetRecordFunctionBase : FunctionMessage
    {
        [Parameter("bytes32", "tableId", 1)]
        public virtual byte[] TableId { get; set; }
        [Parameter("bytes32[]", "keyTuple", 2)]
        public virtual List<byte[]> KeyTuple { get; set; }
    }

    public partial class GetStageOneEndTimeFunction : GetStageOneEndTimeFunctionBase { }

    [Function("getStageOneEndTime", "uint256")]
    public class GetStageOneEndTimeFunctionBase : FunctionMessage
    {

    }

    public partial class GetStaticFieldFunction : GetStaticFieldFunctionBase { }

    [Function("getStaticField", "bytes32")]
    public class GetStaticFieldFunctionBase : FunctionMessage
    {
        [Parameter("bytes32", "tableId", 1)]
        public virtual byte[] TableId { get; set; }
        [Parameter("bytes32[]", "keyTuple", 2)]
        public virtual List<byte[]> KeyTuple { get; set; }
        [Parameter("uint8", "fieldIndex", 3)]
        public virtual byte FieldIndex { get; set; }
        [Parameter("bytes32", "fieldLayout", 4)]
        public virtual byte[] FieldLayout { get; set; }
    }

    public partial class GetValueSchemaFunction : GetValueSchemaFunctionBase { }

    [Function("getValueSchema", "bytes32")]
    public class GetValueSchemaFunctionBase : FunctionMessage
    {
        [Parameter("bytes32", "tableId", 1)]
        public virtual byte[] TableId { get; set; }
    }

    public partial class GrantAccessFunction : GrantAccessFunctionBase { }

    [Function("grantAccess")]
    public class GrantAccessFunctionBase : FunctionMessage
    {
        [Parameter("bytes32", "resourceId", 1)]
        public virtual byte[] ResourceId { get; set; }
        [Parameter("address", "grantee", 2)]
        public virtual string Grantee { get; set; }
    }

    public partial class InitializeFunction : InitializeFunctionBase { }

    [Function("initialize")]
    public class InitializeFunctionBase : FunctionMessage
    {
        [Parameter("address", "initModule", 1)]
        public virtual string InitModule { get; set; }
    }

    public partial class InstallModuleFunction : InstallModuleFunctionBase { }

    [Function("installModule")]
    public class InstallModuleFunctionBase : FunctionMessage
    {
        [Parameter("address", "module", 1)]
        public virtual string Module { get; set; }
        [Parameter("bytes", "encodedArgs", 2)]
        public virtual byte[] EncodedArgs { get; set; }
    }

    public partial class InstallRootModuleFunction : InstallRootModuleFunctionBase { }

    [Function("installRootModule")]
    public class InstallRootModuleFunctionBase : FunctionMessage
    {
        [Parameter("address", "module", 1)]
        public virtual string Module { get; set; }
        [Parameter("bytes", "encodedArgs", 2)]
        public virtual byte[] EncodedArgs { get; set; }
    }

    public partial class MarchFunction : MarchFunctionBase { }

    [Function("march")]
    public class MarchFunctionBase : FunctionMessage
    {
        [Parameter("uint16", "destination", 1)]
        public virtual ushort Destination { get; set; }
        [Parameter("uint256", "infantry", 2)]
        public virtual BigInteger Infantry { get; set; }
        [Parameter("uint256", "cavalryA", 3)]
        public virtual BigInteger CavalryA { get; set; }
        [Parameter("uint256", "cavalryB", 4)]
        public virtual BigInteger CavalryB { get; set; }
        [Parameter("uint256", "cavalryC", 5)]
        public virtual BigInteger CavalryC { get; set; }
        [Parameter("uint8", "army_id", 6)]
        public virtual byte ArmyId { get; set; }
    }

    public partial class PopFromDynamicFieldFunction : PopFromDynamicFieldFunctionBase { }

    [Function("popFromDynamicField")]
    public class PopFromDynamicFieldFunctionBase : FunctionMessage
    {
        [Parameter("bytes32", "tableId", 1)]
        public virtual byte[] TableId { get; set; }
        [Parameter("bytes32[]", "keyTuple", 2)]
        public virtual List<byte[]> KeyTuple { get; set; }
        [Parameter("uint8", "dynamicFieldIndex", 3)]
        public virtual byte DynamicFieldIndex { get; set; }
        [Parameter("uint256", "byteLengthToPop", 4)]
        public virtual BigInteger ByteLengthToPop { get; set; }
    }

    public partial class PushToDynamicFieldFunction : PushToDynamicFieldFunctionBase { }

    [Function("pushToDynamicField")]
    public class PushToDynamicFieldFunctionBase : FunctionMessage
    {
        [Parameter("bytes32", "tableId", 1)]
        public virtual byte[] TableId { get; set; }
        [Parameter("bytes32[]", "keyTuple", 2)]
        public virtual List<byte[]> KeyTuple { get; set; }
        [Parameter("uint8", "dynamicFieldIndex", 3)]
        public virtual byte DynamicFieldIndex { get; set; }
        [Parameter("bytes", "dataToPush", 4)]
        public virtual byte[] DataToPush { get; set; }
    }

    public partial class RegisterDelegationFunction : RegisterDelegationFunctionBase { }

    [Function("registerDelegation")]
    public class RegisterDelegationFunctionBase : FunctionMessage
    {
        [Parameter("address", "delegatee", 1)]
        public virtual string Delegatee { get; set; }
        [Parameter("bytes32", "delegationControlId", 2)]
        public virtual byte[] DelegationControlId { get; set; }
        [Parameter("bytes", "initCallData", 3)]
        public virtual byte[] InitCallData { get; set; }
    }

    public partial class RegisterFunctionSelectorFunction : RegisterFunctionSelectorFunctionBase { }

    [Function("registerFunctionSelector", "bytes4")]
    public class RegisterFunctionSelectorFunctionBase : FunctionMessage
    {
        [Parameter("bytes32", "systemId", 1)]
        public virtual byte[] SystemId { get; set; }
        [Parameter("string", "systemFunctionSignature", 2)]
        public virtual string SystemFunctionSignature { get; set; }
    }

    public partial class RegisterNamespaceFunction : RegisterNamespaceFunctionBase { }

    [Function("registerNamespace")]
    public class RegisterNamespaceFunctionBase : FunctionMessage
    {
        [Parameter("bytes32", "namespaceId", 1)]
        public virtual byte[] NamespaceId { get; set; }
    }

    public partial class RegisterNamespaceDelegationFunction : RegisterNamespaceDelegationFunctionBase { }

    [Function("registerNamespaceDelegation")]
    public class RegisterNamespaceDelegationFunctionBase : FunctionMessage
    {
        [Parameter("bytes32", "namespaceId", 1)]
        public virtual byte[] NamespaceId { get; set; }
        [Parameter("bytes32", "delegationControlId", 2)]
        public virtual byte[] DelegationControlId { get; set; }
        [Parameter("bytes", "initCallData", 3)]
        public virtual byte[] InitCallData { get; set; }
    }

    public partial class RegisterRootFunctionSelectorFunction : RegisterRootFunctionSelectorFunctionBase { }

    [Function("registerRootFunctionSelector", "bytes4")]
    public class RegisterRootFunctionSelectorFunctionBase : FunctionMessage
    {
        [Parameter("bytes32", "systemId", 1)]
        public virtual byte[] SystemId { get; set; }
        [Parameter("string", "worldFunctionSignature", 2)]
        public virtual string WorldFunctionSignature { get; set; }
        [Parameter("string", "systemFunctionSignature", 3)]
        public virtual string SystemFunctionSignature { get; set; }
    }

    public partial class RegisterStoreHookFunction : RegisterStoreHookFunctionBase { }

    [Function("registerStoreHook")]
    public class RegisterStoreHookFunctionBase : FunctionMessage
    {
        [Parameter("bytes32", "tableId", 1)]
        public virtual byte[] TableId { get; set; }
        [Parameter("address", "hookAddress", 2)]
        public virtual string HookAddress { get; set; }
        [Parameter("uint8", "enabledHooksBitmap", 3)]
        public virtual byte EnabledHooksBitmap { get; set; }
    }

    public partial class RegisterSystemFunction : RegisterSystemFunctionBase { }

    [Function("registerSystem")]
    public class RegisterSystemFunctionBase : FunctionMessage
    {
        [Parameter("bytes32", "systemId", 1)]
        public virtual byte[] SystemId { get; set; }
        [Parameter("address", "system", 2)]
        public virtual string System { get; set; }
        [Parameter("bool", "publicAccess", 3)]
        public virtual bool PublicAccess { get; set; }
    }

    public partial class RegisterSystemHookFunction : RegisterSystemHookFunctionBase { }

    [Function("registerSystemHook")]
    public class RegisterSystemHookFunctionBase : FunctionMessage
    {
        [Parameter("bytes32", "systemId", 1)]
        public virtual byte[] SystemId { get; set; }
        [Parameter("address", "hookAddress", 2)]
        public virtual string HookAddress { get; set; }
        [Parameter("uint8", "enabledHooksBitmap", 3)]
        public virtual byte EnabledHooksBitmap { get; set; }
    }

    public partial class RegisterTableFunction : RegisterTableFunctionBase { }

    [Function("registerTable")]
    public class RegisterTableFunctionBase : FunctionMessage
    {
        [Parameter("bytes32", "tableId", 1)]
        public virtual byte[] TableId { get; set; }
        [Parameter("bytes32", "fieldLayout", 2)]
        public virtual byte[] FieldLayout { get; set; }
        [Parameter("bytes32", "keySchema", 3)]
        public virtual byte[] KeySchema { get; set; }
        [Parameter("bytes32", "valueSchema", 4)]
        public virtual byte[] ValueSchema { get; set; }
        [Parameter("string[]", "keyNames", 5)]
        public virtual List<string> KeyNames { get; set; }
        [Parameter("string[]", "fieldNames", 6)]
        public virtual List<string> FieldNames { get; set; }
    }

    public partial class RenounceOwnershipFunction : RenounceOwnershipFunctionBase { }

    [Function("renounceOwnership")]
    public class RenounceOwnershipFunctionBase : FunctionMessage
    {
        [Parameter("bytes32", "namespaceId", 1)]
        public virtual byte[] NamespaceId { get; set; }
    }

    public partial class RevokeAccessFunction : RevokeAccessFunctionBase { }

    [Function("revokeAccess")]
    public class RevokeAccessFunctionBase : FunctionMessage
    {
        [Parameter("bytes32", "resourceId", 1)]
        public virtual byte[] ResourceId { get; set; }
        [Parameter("address", "grantee", 2)]
        public virtual string Grantee { get; set; }
    }

    public partial class SetDynamicFieldFunction : SetDynamicFieldFunctionBase { }

    [Function("setDynamicField")]
    public class SetDynamicFieldFunctionBase : FunctionMessage
    {
        [Parameter("bytes32", "tableId", 1)]
        public virtual byte[] TableId { get; set; }
        [Parameter("bytes32[]", "keyTuple", 2)]
        public virtual List<byte[]> KeyTuple { get; set; }
        [Parameter("uint8", "dynamicFieldIndex", 3)]
        public virtual byte DynamicFieldIndex { get; set; }
        [Parameter("bytes", "data", 4)]
        public virtual byte[] Data { get; set; }
    }

    public partial class SetFieldFunction : SetFieldFunctionBase { }

    [Function("setField")]
    public class SetFieldFunctionBase : FunctionMessage
    {
        [Parameter("bytes32", "tableId", 1)]
        public virtual byte[] TableId { get; set; }
        [Parameter("bytes32[]", "keyTuple", 2)]
        public virtual List<byte[]> KeyTuple { get; set; }
        [Parameter("uint8", "fieldIndex", 3)]
        public virtual byte FieldIndex { get; set; }
        [Parameter("bytes", "data", 4)]
        public virtual byte[] Data { get; set; }
    }

    public partial class SetField1Function : SetField1FunctionBase { }

    [Function("setField")]
    public class SetField1FunctionBase : FunctionMessage
    {
        [Parameter("bytes32", "tableId", 1)]
        public virtual byte[] TableId { get; set; }
        [Parameter("bytes32[]", "keyTuple", 2)]
        public virtual List<byte[]> KeyTuple { get; set; }
        [Parameter("uint8", "fieldIndex", 3)]
        public virtual byte FieldIndex { get; set; }
        [Parameter("bytes", "data", 4)]
        public virtual byte[] Data { get; set; }
        [Parameter("bytes32", "fieldLayout", 5)]
        public virtual byte[] FieldLayout { get; set; }
    }

    public partial class SetRecordFunction : SetRecordFunctionBase { }

    [Function("setRecord")]
    public class SetRecordFunctionBase : FunctionMessage
    {
        [Parameter("bytes32", "tableId", 1)]
        public virtual byte[] TableId { get; set; }
        [Parameter("bytes32[]", "keyTuple", 2)]
        public virtual List<byte[]> KeyTuple { get; set; }
        [Parameter("bytes", "staticData", 3)]
        public virtual byte[] StaticData { get; set; }
        [Parameter("bytes32", "encodedLengths", 4)]
        public virtual byte[] EncodedLengths { get; set; }
        [Parameter("bytes", "dynamicData", 5)]
        public virtual byte[] DynamicData { get; set; }
    }

    public partial class SetStaticFieldFunction : SetStaticFieldFunctionBase { }

    [Function("setStaticField")]
    public class SetStaticFieldFunctionBase : FunctionMessage
    {
        [Parameter("bytes32", "tableId", 1)]
        public virtual byte[] TableId { get; set; }
        [Parameter("bytes32[]", "keyTuple", 2)]
        public virtual List<byte[]> KeyTuple { get; set; }
        [Parameter("uint8", "fieldIndex", 3)]
        public virtual byte FieldIndex { get; set; }
        [Parameter("bytes", "data", 4)]
        public virtual byte[] Data { get; set; }
        [Parameter("bytes32", "fieldLayout", 5)]
        public virtual byte[] FieldLayout { get; set; }
    }

    public partial class SetUnStakeFeeFunction : SetUnStakeFeeFunctionBase { }

    [Function("setUnStakeFee")]
    public class SetUnStakeFeeFunctionBase : FunctionMessage
    {
        [Parameter("uint256", "fee", 1)]
        public virtual BigInteger Fee { get; set; }
    }

    public partial class SpawnCapitalFunction : SpawnCapitalFunctionBase { }

    [Function("spawnCapital")]
    public class SpawnCapitalFunctionBase : FunctionMessage
    {
        [Parameter("uint16", "capital_id", 1)]
        public virtual ushort CapitalId { get; set; }
    }

    public partial class SpawnPlayerFunction : SpawnPlayerFunctionBase { }

    [Function("spawnPlayer")]
    public class SpawnPlayerFunctionBase : FunctionMessage
    {

    }

    public partial class SpliceDynamicDataFunction : SpliceDynamicDataFunctionBase { }

    [Function("spliceDynamicData")]
    public class SpliceDynamicDataFunctionBase : FunctionMessage
    {
        [Parameter("bytes32", "tableId", 1)]
        public virtual byte[] TableId { get; set; }
        [Parameter("bytes32[]", "keyTuple", 2)]
        public virtual List<byte[]> KeyTuple { get; set; }
        [Parameter("uint8", "dynamicFieldIndex", 3)]
        public virtual byte DynamicFieldIndex { get; set; }
        [Parameter("uint40", "startWithinField", 4)]
        public virtual ulong StartWithinField { get; set; }
        [Parameter("uint40", "deleteCount", 5)]
        public virtual ulong DeleteCount { get; set; }
        [Parameter("bytes", "data", 6)]
        public virtual byte[] Data { get; set; }
    }

    public partial class SpliceStaticDataFunction : SpliceStaticDataFunctionBase { }

    [Function("spliceStaticData")]
    public class SpliceStaticDataFunctionBase : FunctionMessage
    {
        [Parameter("bytes32", "tableId", 1)]
        public virtual byte[] TableId { get; set; }
        [Parameter("bytes32[]", "keyTuple", 2)]
        public virtual List<byte[]> KeyTuple { get; set; }
        [Parameter("uint48", "start", 3)]
        public virtual ulong Start { get; set; }
        [Parameter("bytes", "data", 4)]
        public virtual byte[] Data { get; set; }
    }

    public partial class StakeTokenBFunction : StakeTokenBFunctionBase { }

    [Function("stakeTokenB")]
    public class StakeTokenBFunctionBase : FunctionMessage
    {
        [Parameter("uint256", "amount", 1)]
        public virtual BigInteger Amount { get; set; }
    }

    public partial class StakeTokenCFunction : StakeTokenCFunctionBase { }

    [Function("stakeTokenC")]
    public class StakeTokenCFunctionBase : FunctionMessage
    {
        [Parameter("uint256", "amount", 1)]
        public virtual BigInteger Amount { get; set; }
    }

    public partial class StoreVersionFunction : StoreVersionFunctionBase { }

    [Function("storeVersion", "bytes32")]
    public class StoreVersionFunctionBase : FunctionMessage
    {

    }

    public partial class TransferBalanceToAddressFunction : TransferBalanceToAddressFunctionBase { }

    [Function("transferBalanceToAddress")]
    public class TransferBalanceToAddressFunctionBase : FunctionMessage
    {
        [Parameter("bytes32", "fromNamespaceId", 1)]
        public virtual byte[] FromNamespaceId { get; set; }
        [Parameter("address", "toAddress", 2)]
        public virtual string ToAddress { get; set; }
        [Parameter("uint256", "amount", 3)]
        public virtual BigInteger Amount { get; set; }
    }

    public partial class TransferBalanceToNamespaceFunction : TransferBalanceToNamespaceFunctionBase { }

    [Function("transferBalanceToNamespace")]
    public class TransferBalanceToNamespaceFunctionBase : FunctionMessage
    {
        [Parameter("bytes32", "fromNamespaceId", 1)]
        public virtual byte[] FromNamespaceId { get; set; }
        [Parameter("bytes32", "toNamespaceId", 2)]
        public virtual byte[] ToNamespaceId { get; set; }
        [Parameter("uint256", "amount", 3)]
        public virtual BigInteger Amount { get; set; }
    }

    public partial class TransferOwnershipFunction : TransferOwnershipFunctionBase { }

    [Function("transferOwnership")]
    public class TransferOwnershipFunctionBase : FunctionMessage
    {
        [Parameter("bytes32", "namespaceId", 1)]
        public virtual byte[] NamespaceId { get; set; }
        [Parameter("address", "newOwner", 2)]
        public virtual string NewOwner { get; set; }
    }

    public partial class UnStakeTokenBFunction : UnStakeTokenBFunctionBase { }

    [Function("unStakeTokenB")]
    public class UnStakeTokenBFunctionBase : FunctionMessage
    {
        [Parameter("address", "staker", 1)]
        public virtual string Staker { get; set; }
        [Parameter("uint256", "amount", 2)]
        public virtual BigInteger Amount { get; set; }
    }

    public partial class UnregisterDelegationFunction : UnregisterDelegationFunctionBase { }

    [Function("unregisterDelegation")]
    public class UnregisterDelegationFunctionBase : FunctionMessage
    {
        [Parameter("address", "delegatee", 1)]
        public virtual string Delegatee { get; set; }
    }

    public partial class UnregisterNamespaceDelegationFunction : UnregisterNamespaceDelegationFunctionBase { }

    [Function("unregisterNamespaceDelegation")]
    public class UnregisterNamespaceDelegationFunctionBase : FunctionMessage
    {
        [Parameter("bytes32", "namespaceId", 1)]
        public virtual byte[] NamespaceId { get; set; }
    }

    public partial class UnregisterStoreHookFunction : UnregisterStoreHookFunctionBase { }

    [Function("unregisterStoreHook")]
    public class UnregisterStoreHookFunctionBase : FunctionMessage
    {
        [Parameter("bytes32", "tableId", 1)]
        public virtual byte[] TableId { get; set; }
        [Parameter("address", "hookAddress", 2)]
        public virtual string HookAddress { get; set; }
    }

    public partial class UnregisterSystemHookFunction : UnregisterSystemHookFunctionBase { }

    [Function("unregisterSystemHook")]
    public class UnregisterSystemHookFunctionBase : FunctionMessage
    {
        [Parameter("bytes32", "systemId", 1)]
        public virtual byte[] SystemId { get; set; }
        [Parameter("address", "hookAddress", 2)]
        public virtual string HookAddress { get; set; }
    }

    public partial class WorldVersionFunction : WorldVersionFunctionBase { }

    [Function("worldVersion", "bytes32")]
    public class WorldVersionFunctionBase : FunctionMessage
    {

    }

    public partial class HelloStoreEventDTO : HelloStoreEventDTOBase { }

    [Event("HelloStore")]
    public class HelloStoreEventDTOBase : IEventDTO
    {
        [Parameter("bytes32", "storeVersion", 1, true )]
        public virtual byte[] StoreVersion { get; set; }
    }

    public partial class HelloWorldEventDTO : HelloWorldEventDTOBase { }

    [Event("HelloWorld")]
    public class HelloWorldEventDTOBase : IEventDTO
    {
        [Parameter("bytes32", "worldVersion", 1, true )]
        public virtual byte[] WorldVersion { get; set; }
    }

    public partial class StoreDeleterecordEventDTO : StoreDeleterecordEventDTOBase { }

    [Event("Store_DeleteRecord")]
    public class StoreDeleterecordEventDTOBase : IEventDTO
    {
        [Parameter("bytes32", "tableId", 1, true )]
        public virtual byte[] TableId { get; set; }
        [Parameter("bytes32[]", "keyTuple", 2, false )]
        public virtual List<byte[]> KeyTuple { get; set; }
    }

    public partial class StoreSetrecordEventDTO : StoreSetrecordEventDTOBase { }

    [Event("Store_SetRecord")]
    public class StoreSetrecordEventDTOBase : IEventDTO
    {
        [Parameter("bytes32", "tableId", 1, true )]
        public virtual byte[] TableId { get; set; }
        [Parameter("bytes32[]", "keyTuple", 2, false )]
        public virtual List<byte[]> KeyTuple { get; set; }
        [Parameter("bytes", "staticData", 3, false )]
        public virtual byte[] StaticData { get; set; }
        [Parameter("bytes32", "encodedLengths", 4, false )]
        public virtual byte[] EncodedLengths { get; set; }
        [Parameter("bytes", "dynamicData", 5, false )]
        public virtual byte[] DynamicData { get; set; }
    }

    public partial class StoreSplicedynamicdataEventDTO : StoreSplicedynamicdataEventDTOBase { }

    [Event("Store_SpliceDynamicData")]
    public class StoreSplicedynamicdataEventDTOBase : IEventDTO
    {
        [Parameter("bytes32", "tableId", 1, true )]
        public virtual byte[] TableId { get; set; }
        [Parameter("bytes32[]", "keyTuple", 2, false )]
        public virtual List<byte[]> KeyTuple { get; set; }
        [Parameter("uint8", "dynamicFieldIndex", 3, false )]
        public virtual byte DynamicFieldIndex { get; set; }
        [Parameter("uint48", "start", 4, false )]
        public virtual ulong Start { get; set; }
        [Parameter("uint40", "deleteCount", 5, false )]
        public virtual ulong DeleteCount { get; set; }
        [Parameter("bytes32", "encodedLengths", 6, false )]
        public virtual byte[] EncodedLengths { get; set; }
        [Parameter("bytes", "data", 7, false )]
        public virtual byte[] Data { get; set; }
    }

    public partial class StoreSplicestaticdataEventDTO : StoreSplicestaticdataEventDTOBase { }

    [Event("Store_SpliceStaticData")]
    public class StoreSplicestaticdataEventDTOBase : IEventDTO
    {
        [Parameter("bytes32", "tableId", 1, true )]
        public virtual byte[] TableId { get; set; }
        [Parameter("bytes32[]", "keyTuple", 2, false )]
        public virtual List<byte[]> KeyTuple { get; set; }
        [Parameter("uint48", "start", 3, false )]
        public virtual ulong Start { get; set; }
        [Parameter("bytes", "data", 4, false )]
        public virtual byte[] Data { get; set; }
    }

    public partial class EncodedlengthsInvalidlengthError : EncodedlengthsInvalidlengthErrorBase { }

    [Error("EncodedLengths_InvalidLength")]
    public class EncodedlengthsInvalidlengthErrorBase : IErrorDTO
    {
        [Parameter("uint256", "length", 1)]
        public virtual BigInteger Length { get; set; }
    }

    public partial class FieldlayoutEmptyError : FieldlayoutEmptyErrorBase { }
    [Error("FieldLayout_Empty")]
    public class FieldlayoutEmptyErrorBase : IErrorDTO
    {
    }

    public partial class FieldlayoutInvalidstaticdatalengthError : FieldlayoutInvalidstaticdatalengthErrorBase { }

    [Error("FieldLayout_InvalidStaticDataLength")]
    public class FieldlayoutInvalidstaticdatalengthErrorBase : IErrorDTO
    {
        [Parameter("uint256", "staticDataLength", 1)]
        public virtual BigInteger StaticDataLength { get; set; }
        [Parameter("uint256", "computedStaticDataLength", 2)]
        public virtual BigInteger ComputedStaticDataLength { get; set; }
    }

    public partial class FieldlayoutStaticlengthdoesnotfitinawordError : FieldlayoutStaticlengthdoesnotfitinawordErrorBase { }

    [Error("FieldLayout_StaticLengthDoesNotFitInAWord")]
    public class FieldlayoutStaticlengthdoesnotfitinawordErrorBase : IErrorDTO
    {
        [Parameter("uint256", "index", 1)]
        public virtual BigInteger Index { get; set; }
    }

    public partial class FieldlayoutStaticlengthisnotzeroError : FieldlayoutStaticlengthisnotzeroErrorBase { }

    [Error("FieldLayout_StaticLengthIsNotZero")]
    public class FieldlayoutStaticlengthisnotzeroErrorBase : IErrorDTO
    {
        [Parameter("uint256", "index", 1)]
        public virtual BigInteger Index { get; set; }
    }

    public partial class FieldlayoutStaticlengthiszeroError : FieldlayoutStaticlengthiszeroErrorBase { }

    [Error("FieldLayout_StaticLengthIsZero")]
    public class FieldlayoutStaticlengthiszeroErrorBase : IErrorDTO
    {
        [Parameter("uint256", "index", 1)]
        public virtual BigInteger Index { get; set; }
    }

    public partial class FieldlayoutToomanydynamicfieldsError : FieldlayoutToomanydynamicfieldsErrorBase { }

    [Error("FieldLayout_TooManyDynamicFields")]
    public class FieldlayoutToomanydynamicfieldsErrorBase : IErrorDTO
    {
        [Parameter("uint256", "numFields", 1)]
        public virtual BigInteger NumFields { get; set; }
        [Parameter("uint256", "maxFields", 2)]
        public virtual BigInteger MaxFields { get; set; }
    }

    public partial class FieldlayoutToomanyfieldsError : FieldlayoutToomanyfieldsErrorBase { }

    [Error("FieldLayout_TooManyFields")]
    public class FieldlayoutToomanyfieldsErrorBase : IErrorDTO
    {
        [Parameter("uint256", "numFields", 1)]
        public virtual BigInteger NumFields { get; set; }
        [Parameter("uint256", "maxFields", 2)]
        public virtual BigInteger MaxFields { get; set; }
    }

    public partial class ModuleAlreadyinstalledError : ModuleAlreadyinstalledErrorBase { }
    [Error("Module_AlreadyInstalled")]
    public class ModuleAlreadyinstalledErrorBase : IErrorDTO
    {
    }

    public partial class ModuleMissingdependencyError : ModuleMissingdependencyErrorBase { }

    [Error("Module_MissingDependency")]
    public class ModuleMissingdependencyErrorBase : IErrorDTO
    {
        [Parameter("address", "dependency", 1)]
        public virtual string Dependency { get; set; }
    }

    public partial class ModuleNonrootinstallnotsupportedError : ModuleNonrootinstallnotsupportedErrorBase { }
    [Error("Module_NonRootInstallNotSupported")]
    public class ModuleNonrootinstallnotsupportedErrorBase : IErrorDTO
    {
    }

    public partial class ModuleRootinstallnotsupportedError : ModuleRootinstallnotsupportedErrorBase { }
    [Error("Module_RootInstallNotSupported")]
    public class ModuleRootinstallnotsupportedErrorBase : IErrorDTO
    {
    }

    public partial class SchemaInvalidlengthError : SchemaInvalidlengthErrorBase { }

    [Error("Schema_InvalidLength")]
    public class SchemaInvalidlengthErrorBase : IErrorDTO
    {
        [Parameter("uint256", "length", 1)]
        public virtual BigInteger Length { get; set; }
    }

    public partial class SchemaStatictypeafterdynamictypeError : SchemaStatictypeafterdynamictypeErrorBase { }
    [Error("Schema_StaticTypeAfterDynamicType")]
    public class SchemaStatictypeafterdynamictypeErrorBase : IErrorDTO
    {
    }

    public partial class SliceOutofboundsError : SliceOutofboundsErrorBase { }

    [Error("Slice_OutOfBounds")]
    public class SliceOutofboundsErrorBase : IErrorDTO
    {
        [Parameter("bytes", "data", 1)]
        public virtual byte[] Data { get; set; }
        [Parameter("uint256", "start", 2)]
        public virtual BigInteger Start { get; set; }
        [Parameter("uint256", "end", 3)]
        public virtual BigInteger End { get; set; }
    }

    public partial class StoreIndexoutofboundsError : StoreIndexoutofboundsErrorBase { }

    [Error("Store_IndexOutOfBounds")]
    public class StoreIndexoutofboundsErrorBase : IErrorDTO
    {
        [Parameter("uint256", "length", 1)]
        public virtual BigInteger Length { get; set; }
        [Parameter("uint256", "accessedIndex", 2)]
        public virtual BigInteger AccessedIndex { get; set; }
    }

    public partial class StoreInvalidboundsError : StoreInvalidboundsErrorBase { }

    [Error("Store_InvalidBounds")]
    public class StoreInvalidboundsErrorBase : IErrorDTO
    {
        [Parameter("uint256", "start", 1)]
        public virtual BigInteger Start { get; set; }
        [Parameter("uint256", "end", 2)]
        public virtual BigInteger End { get; set; }
    }

    public partial class StoreInvalidfieldnameslengthError : StoreInvalidfieldnameslengthErrorBase { }

    [Error("Store_InvalidFieldNamesLength")]
    public class StoreInvalidfieldnameslengthErrorBase : IErrorDTO
    {
        [Parameter("uint256", "expected", 1)]
        public virtual BigInteger Expected { get; set; }
        [Parameter("uint256", "received", 2)]
        public virtual BigInteger Received { get; set; }
    }

    public partial class StoreInvalidkeynameslengthError : StoreInvalidkeynameslengthErrorBase { }

    [Error("Store_InvalidKeyNamesLength")]
    public class StoreInvalidkeynameslengthErrorBase : IErrorDTO
    {
        [Parameter("uint256", "expected", 1)]
        public virtual BigInteger Expected { get; set; }
        [Parameter("uint256", "received", 2)]
        public virtual BigInteger Received { get; set; }
    }

    public partial class StoreInvalidresourcetypeError : StoreInvalidresourcetypeErrorBase { }

    [Error("Store_InvalidResourceType")]
    public class StoreInvalidresourcetypeErrorBase : IErrorDTO
    {
        [Parameter("bytes2", "expected", 1)]
        public virtual byte[] Expected { get; set; }
        [Parameter("bytes32", "resourceId", 2)]
        public virtual byte[] ResourceId { get; set; }
        [Parameter("string", "resourceIdString", 3)]
        public virtual string ResourceIdString { get; set; }
    }

    public partial class StoreInvalidspliceError : StoreInvalidspliceErrorBase { }

    [Error("Store_InvalidSplice")]
    public class StoreInvalidspliceErrorBase : IErrorDTO
    {
        [Parameter("uint40", "startWithinField", 1)]
        public virtual ulong StartWithinField { get; set; }
        [Parameter("uint40", "deleteCount", 2)]
        public virtual ulong DeleteCount { get; set; }
        [Parameter("uint40", "fieldLength", 3)]
        public virtual ulong FieldLength { get; set; }
    }

    public partial class StoreInvalidstaticdatalengthError : StoreInvalidstaticdatalengthErrorBase { }

    [Error("Store_InvalidStaticDataLength")]
    public class StoreInvalidstaticdatalengthErrorBase : IErrorDTO
    {
        [Parameter("uint256", "expected", 1)]
        public virtual BigInteger Expected { get; set; }
        [Parameter("uint256", "received", 2)]
        public virtual BigInteger Received { get; set; }
    }

    public partial class StoreInvalidvalueschemadynamiclengthError : StoreInvalidvalueschemadynamiclengthErrorBase { }

    [Error("Store_InvalidValueSchemaDynamicLength")]
    public class StoreInvalidvalueschemadynamiclengthErrorBase : IErrorDTO
    {
        [Parameter("uint256", "expected", 1)]
        public virtual BigInteger Expected { get; set; }
        [Parameter("uint256", "received", 2)]
        public virtual BigInteger Received { get; set; }
    }

    public partial class StoreInvalidvalueschemalengthError : StoreInvalidvalueschemalengthErrorBase { }

    [Error("Store_InvalidValueSchemaLength")]
    public class StoreInvalidvalueschemalengthErrorBase : IErrorDTO
    {
        [Parameter("uint256", "expected", 1)]
        public virtual BigInteger Expected { get; set; }
        [Parameter("uint256", "received", 2)]
        public virtual BigInteger Received { get; set; }
    }

    public partial class StoreInvalidvalueschemastaticlengthError : StoreInvalidvalueschemastaticlengthErrorBase { }

    [Error("Store_InvalidValueSchemaStaticLength")]
    public class StoreInvalidvalueschemastaticlengthErrorBase : IErrorDTO
    {
        [Parameter("uint256", "expected", 1)]
        public virtual BigInteger Expected { get; set; }
        [Parameter("uint256", "received", 2)]
        public virtual BigInteger Received { get; set; }
    }

    public partial class StoreTablealreadyexistsError : StoreTablealreadyexistsErrorBase { }

    [Error("Store_TableAlreadyExists")]
    public class StoreTablealreadyexistsErrorBase : IErrorDTO
    {
        [Parameter("bytes32", "tableId", 1)]
        public virtual byte[] TableId { get; set; }
        [Parameter("string", "tableIdString", 2)]
        public virtual string TableIdString { get; set; }
    }

    public partial class StoreTablenotfoundError : StoreTablenotfoundErrorBase { }

    [Error("Store_TableNotFound")]
    public class StoreTablenotfoundErrorBase : IErrorDTO
    {
        [Parameter("bytes32", "tableId", 1)]
        public virtual byte[] TableId { get; set; }
        [Parameter("string", "tableIdString", 2)]
        public virtual string TableIdString { get; set; }
    }

    public partial class WorldAccessdeniedError : WorldAccessdeniedErrorBase { }

    [Error("World_AccessDenied")]
    public class WorldAccessdeniedErrorBase : IErrorDTO
    {
        [Parameter("string", "resource", 1)]
        public virtual string Resource { get; set; }
        [Parameter("address", "caller", 2)]
        public virtual string Caller { get; set; }
    }

    public partial class WorldAlreadyinitializedError : WorldAlreadyinitializedErrorBase { }
    [Error("World_AlreadyInitialized")]
    public class WorldAlreadyinitializedErrorBase : IErrorDTO
    {
    }

    public partial class WorldCallbacknotallowedError : WorldCallbacknotallowedErrorBase { }

    [Error("World_CallbackNotAllowed")]
    public class WorldCallbacknotallowedErrorBase : IErrorDTO
    {
        [Parameter("bytes4", "functionSelector", 1)]
        public virtual byte[] FunctionSelector { get; set; }
    }

    public partial class WorldDelegationnotfoundError : WorldDelegationnotfoundErrorBase { }

    [Error("World_DelegationNotFound")]
    public class WorldDelegationnotfoundErrorBase : IErrorDTO
    {
        [Parameter("address", "delegator", 1)]
        public virtual string Delegator { get; set; }
        [Parameter("address", "delegatee", 2)]
        public virtual string Delegatee { get; set; }
    }

    public partial class WorldFunctionselectoralreadyexistsError : WorldFunctionselectoralreadyexistsErrorBase { }

    [Error("World_FunctionSelectorAlreadyExists")]
    public class WorldFunctionselectoralreadyexistsErrorBase : IErrorDTO
    {
        [Parameter("bytes4", "functionSelector", 1)]
        public virtual byte[] FunctionSelector { get; set; }
    }

    public partial class WorldFunctionselectornotfoundError : WorldFunctionselectornotfoundErrorBase { }

    [Error("World_FunctionSelectorNotFound")]
    public class WorldFunctionselectornotfoundErrorBase : IErrorDTO
    {
        [Parameter("bytes4", "functionSelector", 1)]
        public virtual byte[] FunctionSelector { get; set; }
    }

    public partial class WorldInsufficientbalanceError : WorldInsufficientbalanceErrorBase { }

    [Error("World_InsufficientBalance")]
    public class WorldInsufficientbalanceErrorBase : IErrorDTO
    {
        [Parameter("uint256", "balance", 1)]
        public virtual BigInteger Balance { get; set; }
        [Parameter("uint256", "amount", 2)]
        public virtual BigInteger Amount { get; set; }
    }

    public partial class WorldInterfacenotsupportedError : WorldInterfacenotsupportedErrorBase { }

    [Error("World_InterfaceNotSupported")]
    public class WorldInterfacenotsupportedErrorBase : IErrorDTO
    {
        [Parameter("address", "contractAddress", 1)]
        public virtual string ContractAddress { get; set; }
        [Parameter("bytes4", "interfaceId", 2)]
        public virtual byte[] InterfaceId { get; set; }
    }

    public partial class WorldInvalidnamespaceError : WorldInvalidnamespaceErrorBase { }

    [Error("World_InvalidNamespace")]
    public class WorldInvalidnamespaceErrorBase : IErrorDTO
    {
        [Parameter("bytes14", "namespace", 1)]
        public virtual byte[] Namespace { get; set; }
    }

    public partial class WorldInvalidresourceidError : WorldInvalidresourceidErrorBase { }

    [Error("World_InvalidResourceId")]
    public class WorldInvalidresourceidErrorBase : IErrorDTO
    {
        [Parameter("bytes32", "resourceId", 1)]
        public virtual byte[] ResourceId { get; set; }
        [Parameter("string", "resourceIdString", 2)]
        public virtual string ResourceIdString { get; set; }
    }

    public partial class WorldInvalidresourcetypeError : WorldInvalidresourcetypeErrorBase { }

    [Error("World_InvalidResourceType")]
    public class WorldInvalidresourcetypeErrorBase : IErrorDTO
    {
        [Parameter("bytes2", "expected", 1)]
        public virtual byte[] Expected { get; set; }
        [Parameter("bytes32", "resourceId", 2)]
        public virtual byte[] ResourceId { get; set; }
        [Parameter("string", "resourceIdString", 3)]
        public virtual string ResourceIdString { get; set; }
    }

    public partial class WorldResourcealreadyexistsError : WorldResourcealreadyexistsErrorBase { }

    [Error("World_ResourceAlreadyExists")]
    public class WorldResourcealreadyexistsErrorBase : IErrorDTO
    {
        [Parameter("bytes32", "resourceId", 1)]
        public virtual byte[] ResourceId { get; set; }
        [Parameter("string", "resourceIdString", 2)]
        public virtual string ResourceIdString { get; set; }
    }

    public partial class WorldResourcenotfoundError : WorldResourcenotfoundErrorBase { }

    [Error("World_ResourceNotFound")]
    public class WorldResourcenotfoundErrorBase : IErrorDTO
    {
        [Parameter("bytes32", "resourceId", 1)]
        public virtual byte[] ResourceId { get; set; }
        [Parameter("string", "resourceIdString", 2)]
        public virtual string ResourceIdString { get; set; }
    }

    public partial class WorldSystemalreadyexistsError : WorldSystemalreadyexistsErrorBase { }

    [Error("World_SystemAlreadyExists")]
    public class WorldSystemalreadyexistsErrorBase : IErrorDTO
    {
        [Parameter("address", "system", 1)]
        public virtual string System { get; set; }
    }

    public partial class WorldUnlimiteddelegationnotallowedError : WorldUnlimiteddelegationnotallowedErrorBase { }
    [Error("World_UnlimitedDelegationNotAllowed")]
    public class WorldUnlimiteddelegationnotallowedErrorBase : IErrorDTO
    {
    }





















    public partial class CreatorOutputDTO : CreatorOutputDTOBase { }

    [FunctionOutput]
    public class CreatorOutputDTOBase : IFunctionOutputDTO 
    {
        [Parameter("address", "", 1)]
        public virtual string ReturnValue1 { get; set; }
    }







    public partial class GetDynamicFieldOutputDTO : GetDynamicFieldOutputDTOBase { }

    [FunctionOutput]
    public class GetDynamicFieldOutputDTOBase : IFunctionOutputDTO 
    {
        [Parameter("bytes", "", 1)]
        public virtual byte[] ReturnValue1 { get; set; }
    }

    public partial class GetDynamicFieldLengthOutputDTO : GetDynamicFieldLengthOutputDTOBase { }

    [FunctionOutput]
    public class GetDynamicFieldLengthOutputDTOBase : IFunctionOutputDTO 
    {
        [Parameter("uint256", "", 1)]
        public virtual BigInteger ReturnValue1 { get; set; }
    }

    public partial class GetDynamicFieldSliceOutputDTO : GetDynamicFieldSliceOutputDTOBase { }

    [FunctionOutput]
    public class GetDynamicFieldSliceOutputDTOBase : IFunctionOutputDTO 
    {
        [Parameter("bytes", "data", 1)]
        public virtual byte[] Data { get; set; }
    }

    public partial class GetField1OutputDTO : GetField1OutputDTOBase { }

    [FunctionOutput]
    public class GetField1OutputDTOBase : IFunctionOutputDTO 
    {
        [Parameter("bytes", "data", 1)]
        public virtual byte[] Data { get; set; }
    }

    public partial class GetFieldOutputDTO : GetFieldOutputDTOBase { }

    [FunctionOutput]
    public class GetFieldOutputDTOBase : IFunctionOutputDTO 
    {
        [Parameter("bytes", "data", 1)]
        public virtual byte[] Data { get; set; }
    }

    public partial class GetFieldLayoutOutputDTO : GetFieldLayoutOutputDTOBase { }

    [FunctionOutput]
    public class GetFieldLayoutOutputDTOBase : IFunctionOutputDTO 
    {
        [Parameter("bytes32", "fieldLayout", 1)]
        public virtual byte[] FieldLayout { get; set; }
    }

    public partial class GetFieldLength1OutputDTO : GetFieldLength1OutputDTOBase { }

    [FunctionOutput]
    public class GetFieldLength1OutputDTOBase : IFunctionOutputDTO 
    {
        [Parameter("uint256", "", 1)]
        public virtual BigInteger ReturnValue1 { get; set; }
    }

    public partial class GetFieldLengthOutputDTO : GetFieldLengthOutputDTOBase { }

    [FunctionOutput]
    public class GetFieldLengthOutputDTOBase : IFunctionOutputDTO 
    {
        [Parameter("uint256", "", 1)]
        public virtual BigInteger ReturnValue1 { get; set; }
    }

    public partial class GetKeySchemaOutputDTO : GetKeySchemaOutputDTOBase { }

    [FunctionOutput]
    public class GetKeySchemaOutputDTOBase : IFunctionOutputDTO 
    {
        [Parameter("bytes32", "keySchema", 1)]
        public virtual byte[] KeySchema { get; set; }
    }

    public partial class GetRecord1OutputDTO : GetRecord1OutputDTOBase { }

    [FunctionOutput]
    public class GetRecord1OutputDTOBase : IFunctionOutputDTO 
    {
        [Parameter("bytes", "staticData", 1)]
        public virtual byte[] StaticData { get; set; }
        [Parameter("bytes32", "encodedLengths", 2)]
        public virtual byte[] EncodedLengths { get; set; }
        [Parameter("bytes", "dynamicData", 3)]
        public virtual byte[] DynamicData { get; set; }
    }

    public partial class GetRecordOutputDTO : GetRecordOutputDTOBase { }

    [FunctionOutput]
    public class GetRecordOutputDTOBase : IFunctionOutputDTO 
    {
        [Parameter("bytes", "staticData", 1)]
        public virtual byte[] StaticData { get; set; }
        [Parameter("bytes32", "encodedLengths", 2)]
        public virtual byte[] EncodedLengths { get; set; }
        [Parameter("bytes", "dynamicData", 3)]
        public virtual byte[] DynamicData { get; set; }
    }

    public partial class GetStageOneEndTimeOutputDTO : GetStageOneEndTimeOutputDTOBase { }

    [FunctionOutput]
    public class GetStageOneEndTimeOutputDTOBase : IFunctionOutputDTO 
    {
        [Parameter("uint256", "timestamp", 1)]
        public virtual BigInteger Timestamp { get; set; }
    }

    public partial class GetStaticFieldOutputDTO : GetStaticFieldOutputDTOBase { }

    [FunctionOutput]
    public class GetStaticFieldOutputDTOBase : IFunctionOutputDTO 
    {
        [Parameter("bytes32", "", 1)]
        public virtual byte[] ReturnValue1 { get; set; }
    }

    public partial class GetValueSchemaOutputDTO : GetValueSchemaOutputDTOBase { }

    [FunctionOutput]
    public class GetValueSchemaOutputDTOBase : IFunctionOutputDTO 
    {
        [Parameter("bytes32", "valueSchema", 1)]
        public virtual byte[] ValueSchema { get; set; }
    }





























































    public partial class StoreVersionOutputDTO : StoreVersionOutputDTOBase { }

    [FunctionOutput]
    public class StoreVersionOutputDTOBase : IFunctionOutputDTO 
    {
        [Parameter("bytes32", "version", 1)]
        public virtual byte[] Version { get; set; }
    }

















    public partial class WorldVersionOutputDTO : WorldVersionOutputDTOBase { }

    [FunctionOutput]
    public class WorldVersionOutputDTOBase : IFunctionOutputDTO 
    {
        [Parameter("bytes32", "", 1)]
        public virtual byte[] ReturnValue1 { get; set; }
    }
}
