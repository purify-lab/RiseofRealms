using System;
using System.Threading.Tasks;
using System.Collections.Generic;
using System.Numerics;
using Nethereum.Hex.HexTypes;
using Nethereum.ABI.FunctionEncoding.Attributes;
using Nethereum.Web3;
using Nethereum.RPC.Eth.DTOs;
using Nethereum.Contracts.CQS;
using Nethereum.Contracts.ContractHandlers;
using Nethereum.Contracts;
using System.Threading;
using IWorld.ContractDefinition;

namespace IWorld.Service
{
    public partial class IWorldService
    {
        public static Task<TransactionReceipt> DeployContractAndWaitForReceiptAsync(Nethereum.Web3.Web3 web3, IWorldDeployment iWorldDeployment, CancellationTokenSource cancellationTokenSource = null)
        {
            return web3.Eth.GetContractDeploymentHandler<IWorldDeployment>().SendRequestAndWaitForReceiptAsync(iWorldDeployment, cancellationTokenSource);
        }

        public static Task<string> DeployContractAsync(Nethereum.Web3.Web3 web3, IWorldDeployment iWorldDeployment)
        {
            return web3.Eth.GetContractDeploymentHandler<IWorldDeployment>().SendRequestAsync(iWorldDeployment);
        }

        public static async Task<IWorldService> DeployContractAndGetServiceAsync(Nethereum.Web3.Web3 web3, IWorldDeployment iWorldDeployment, CancellationTokenSource cancellationTokenSource = null)
        {
            var receipt = await DeployContractAndWaitForReceiptAsync(web3, iWorldDeployment, cancellationTokenSource);
            return new IWorldService(web3, receipt.ContractAddress);
        }

        protected Nethereum.Web3.IWeb3 Web3{ get; }

        public ContractHandler ContractHandler { get; }

        public IWorldService(Nethereum.Web3.Web3 web3, string contractAddress)
        {
            Web3 = web3;
            ContractHandler = web3.Eth.GetContractHandler(contractAddress);
        }

        public IWorldService(Nethereum.Web3.IWeb3 web3, string contractAddress)
        {
            Web3 = web3;
            ContractHandler = web3.Eth.GetContractHandler(contractAddress);
        }

        public Task<string> AttackRequestAsync(AttackFunction attackFunction)
        {
             return ContractHandler.SendRequestAsync(attackFunction);
        }

        public Task<TransactionReceipt> AttackRequestAndWaitForReceiptAsync(AttackFunction attackFunction, CancellationTokenSource cancellationToken = null)
        {
             return ContractHandler.SendRequestAndWaitForReceiptAsync(attackFunction, cancellationToken);
        }

        public Task<string> AttackRequestAsync(byte armyId)
        {
            var attackFunction = new AttackFunction();
                attackFunction.ArmyId = armyId;
            
             return ContractHandler.SendRequestAsync(attackFunction);
        }

        public Task<TransactionReceipt> AttackRequestAndWaitForReceiptAsync(byte armyId, CancellationTokenSource cancellationToken = null)
        {
            var attackFunction = new AttackFunction();
                attackFunction.ArmyId = armyId;
            
             return ContractHandler.SendRequestAndWaitForReceiptAsync(attackFunction, cancellationToken);
        }

        public Task<string> BatchCallRequestAsync(BatchCallFunction batchCallFunction)
        {
             return ContractHandler.SendRequestAsync(batchCallFunction);
        }

        public Task<TransactionReceipt> BatchCallRequestAndWaitForReceiptAsync(BatchCallFunction batchCallFunction, CancellationTokenSource cancellationToken = null)
        {
             return ContractHandler.SendRequestAndWaitForReceiptAsync(batchCallFunction, cancellationToken);
        }

        public Task<string> BatchCallRequestAsync(List<SystemCallData> systemCalls)
        {
            var batchCallFunction = new BatchCallFunction();
                batchCallFunction.SystemCalls = systemCalls;
            
             return ContractHandler.SendRequestAsync(batchCallFunction);
        }

        public Task<TransactionReceipt> BatchCallRequestAndWaitForReceiptAsync(List<SystemCallData> systemCalls, CancellationTokenSource cancellationToken = null)
        {
            var batchCallFunction = new BatchCallFunction();
                batchCallFunction.SystemCalls = systemCalls;
            
             return ContractHandler.SendRequestAndWaitForReceiptAsync(batchCallFunction, cancellationToken);
        }

        public Task<string> BatchCallFromRequestAsync(BatchCallFromFunction batchCallFromFunction)
        {
             return ContractHandler.SendRequestAsync(batchCallFromFunction);
        }

        public Task<TransactionReceipt> BatchCallFromRequestAndWaitForReceiptAsync(BatchCallFromFunction batchCallFromFunction, CancellationTokenSource cancellationToken = null)
        {
             return ContractHandler.SendRequestAndWaitForReceiptAsync(batchCallFromFunction, cancellationToken);
        }

        public Task<string> BatchCallFromRequestAsync(List<SystemCallFromData> systemCalls)
        {
            var batchCallFromFunction = new BatchCallFromFunction();
                batchCallFromFunction.SystemCalls = systemCalls;
            
             return ContractHandler.SendRequestAsync(batchCallFromFunction);
        }

        public Task<TransactionReceipt> BatchCallFromRequestAndWaitForReceiptAsync(List<SystemCallFromData> systemCalls, CancellationTokenSource cancellationToken = null)
        {
            var batchCallFromFunction = new BatchCallFromFunction();
                batchCallFromFunction.SystemCalls = systemCalls;
            
             return ContractHandler.SendRequestAndWaitForReceiptAsync(batchCallFromFunction, cancellationToken);
        }

        public Task<string> BuyCavalryARequestAsync(BuyCavalryAFunction buyCavalryAFunction)
        {
             return ContractHandler.SendRequestAsync(buyCavalryAFunction);
        }

        public Task<TransactionReceipt> BuyCavalryARequestAndWaitForReceiptAsync(BuyCavalryAFunction buyCavalryAFunction, CancellationTokenSource cancellationToken = null)
        {
             return ContractHandler.SendRequestAndWaitForReceiptAsync(buyCavalryAFunction, cancellationToken);
        }

        public Task<string> BuyCavalryARequestAsync(BigInteger amount)
        {
            var buyCavalryAFunction = new BuyCavalryAFunction();
                buyCavalryAFunction.Amount = amount;
            
             return ContractHandler.SendRequestAsync(buyCavalryAFunction);
        }

        public Task<TransactionReceipt> BuyCavalryARequestAndWaitForReceiptAsync(BigInteger amount, CancellationTokenSource cancellationToken = null)
        {
            var buyCavalryAFunction = new BuyCavalryAFunction();
                buyCavalryAFunction.Amount = amount;
            
             return ContractHandler.SendRequestAndWaitForReceiptAsync(buyCavalryAFunction, cancellationToken);
        }

        public Task<string> BuyCavalryBRequestAsync(BuyCavalryBFunction buyCavalryBFunction)
        {
             return ContractHandler.SendRequestAsync(buyCavalryBFunction);
        }

        public Task<TransactionReceipt> BuyCavalryBRequestAndWaitForReceiptAsync(BuyCavalryBFunction buyCavalryBFunction, CancellationTokenSource cancellationToken = null)
        {
             return ContractHandler.SendRequestAndWaitForReceiptAsync(buyCavalryBFunction, cancellationToken);
        }

        public Task<string> BuyCavalryBRequestAsync(BigInteger amount)
        {
            var buyCavalryBFunction = new BuyCavalryBFunction();
                buyCavalryBFunction.Amount = amount;
            
             return ContractHandler.SendRequestAsync(buyCavalryBFunction);
        }

        public Task<TransactionReceipt> BuyCavalryBRequestAndWaitForReceiptAsync(BigInteger amount, CancellationTokenSource cancellationToken = null)
        {
            var buyCavalryBFunction = new BuyCavalryBFunction();
                buyCavalryBFunction.Amount = amount;
            
             return ContractHandler.SendRequestAndWaitForReceiptAsync(buyCavalryBFunction, cancellationToken);
        }

        public Task<string> BuyCavalryCRequestAsync(BuyCavalryCFunction buyCavalryCFunction)
        {
             return ContractHandler.SendRequestAsync(buyCavalryCFunction);
        }

        public Task<TransactionReceipt> BuyCavalryCRequestAndWaitForReceiptAsync(BuyCavalryCFunction buyCavalryCFunction, CancellationTokenSource cancellationToken = null)
        {
             return ContractHandler.SendRequestAndWaitForReceiptAsync(buyCavalryCFunction, cancellationToken);
        }

        public Task<string> BuyCavalryCRequestAsync(BigInteger amount)
        {
            var buyCavalryCFunction = new BuyCavalryCFunction();
                buyCavalryCFunction.Amount = amount;
            
             return ContractHandler.SendRequestAsync(buyCavalryCFunction);
        }

        public Task<TransactionReceipt> BuyCavalryCRequestAndWaitForReceiptAsync(BigInteger amount, CancellationTokenSource cancellationToken = null)
        {
            var buyCavalryCFunction = new BuyCavalryCFunction();
                buyCavalryCFunction.Amount = amount;
            
             return ContractHandler.SendRequestAndWaitForReceiptAsync(buyCavalryCFunction, cancellationToken);
        }

        public Task<string> BuyInfantryRequestAsync(BuyInfantryFunction buyInfantryFunction)
        {
             return ContractHandler.SendRequestAsync(buyInfantryFunction);
        }

        public Task<TransactionReceipt> BuyInfantryRequestAndWaitForReceiptAsync(BuyInfantryFunction buyInfantryFunction, CancellationTokenSource cancellationToken = null)
        {
             return ContractHandler.SendRequestAndWaitForReceiptAsync(buyInfantryFunction, cancellationToken);
        }

        public Task<string> BuyInfantryRequestAsync(BigInteger amount)
        {
            var buyInfantryFunction = new BuyInfantryFunction();
                buyInfantryFunction.Amount = amount;
            
             return ContractHandler.SendRequestAsync(buyInfantryFunction);
        }

        public Task<TransactionReceipt> BuyInfantryRequestAndWaitForReceiptAsync(BigInteger amount, CancellationTokenSource cancellationToken = null)
        {
            var buyInfantryFunction = new BuyInfantryFunction();
                buyInfantryFunction.Amount = amount;
            
             return ContractHandler.SendRequestAndWaitForReceiptAsync(buyInfantryFunction, cancellationToken);
        }

        public Task<string> BuyInfantryByTokenRequestAsync(BuyInfantryByTokenFunction buyInfantryByTokenFunction)
        {
             return ContractHandler.SendRequestAsync(buyInfantryByTokenFunction);
        }

        public Task<TransactionReceipt> BuyInfantryByTokenRequestAndWaitForReceiptAsync(BuyInfantryByTokenFunction buyInfantryByTokenFunction, CancellationTokenSource cancellationToken = null)
        {
             return ContractHandler.SendRequestAndWaitForReceiptAsync(buyInfantryByTokenFunction, cancellationToken);
        }

        public Task<string> BuyInfantryByTokenRequestAsync(byte tokenType, BigInteger amount)
        {
            var buyInfantryByTokenFunction = new BuyInfantryByTokenFunction();
                buyInfantryByTokenFunction.TokenType = tokenType;
                buyInfantryByTokenFunction.Amount = amount;
            
             return ContractHandler.SendRequestAsync(buyInfantryByTokenFunction);
        }

        public Task<TransactionReceipt> BuyInfantryByTokenRequestAndWaitForReceiptAsync(byte tokenType, BigInteger amount, CancellationTokenSource cancellationToken = null)
        {
            var buyInfantryByTokenFunction = new BuyInfantryByTokenFunction();
                buyInfantryByTokenFunction.TokenType = tokenType;
                buyInfantryByTokenFunction.Amount = amount;
            
             return ContractHandler.SendRequestAndWaitForReceiptAsync(buyInfantryByTokenFunction, cancellationToken);
        }

        public Task<string> CallRequestAsync(CallFunction callFunction)
        {
             return ContractHandler.SendRequestAsync(callFunction);
        }

        public Task<TransactionReceipt> CallRequestAndWaitForReceiptAsync(CallFunction callFunction, CancellationTokenSource cancellationToken = null)
        {
             return ContractHandler.SendRequestAndWaitForReceiptAsync(callFunction, cancellationToken);
        }

        public Task<string> CallRequestAsync(byte[] systemId, byte[] callData)
        {
            var callFunction = new CallFunction();
                callFunction.SystemId = systemId;
                callFunction.CallData = callData;
            
             return ContractHandler.SendRequestAsync(callFunction);
        }

        public Task<TransactionReceipt> CallRequestAndWaitForReceiptAsync(byte[] systemId, byte[] callData, CancellationTokenSource cancellationToken = null)
        {
            var callFunction = new CallFunction();
                callFunction.SystemId = systemId;
                callFunction.CallData = callData;
            
             return ContractHandler.SendRequestAndWaitForReceiptAsync(callFunction, cancellationToken);
        }

        public Task<string> CallFromRequestAsync(CallFromFunction callFromFunction)
        {
             return ContractHandler.SendRequestAsync(callFromFunction);
        }

        public Task<TransactionReceipt> CallFromRequestAndWaitForReceiptAsync(CallFromFunction callFromFunction, CancellationTokenSource cancellationToken = null)
        {
             return ContractHandler.SendRequestAndWaitForReceiptAsync(callFromFunction, cancellationToken);
        }

        public Task<string> CallFromRequestAsync(string delegator, byte[] systemId, byte[] callData)
        {
            var callFromFunction = new CallFromFunction();
                callFromFunction.Delegator = delegator;
                callFromFunction.SystemId = systemId;
                callFromFunction.CallData = callData;
            
             return ContractHandler.SendRequestAsync(callFromFunction);
        }

        public Task<TransactionReceipt> CallFromRequestAndWaitForReceiptAsync(string delegator, byte[] systemId, byte[] callData, CancellationTokenSource cancellationToken = null)
        {
            var callFromFunction = new CallFromFunction();
                callFromFunction.Delegator = delegator;
                callFromFunction.SystemId = systemId;
                callFromFunction.CallData = callData;
            
             return ContractHandler.SendRequestAndWaitForReceiptAsync(callFromFunction, cancellationToken);
        }

        public Task<string> CreatorQueryAsync(CreatorFunction creatorFunction, BlockParameter blockParameter = null)
        {
            return ContractHandler.QueryAsync<CreatorFunction, string>(creatorFunction, blockParameter);
        }

        
        public Task<string> CreatorQueryAsync(BlockParameter blockParameter = null)
        {
            return ContractHandler.QueryAsync<CreatorFunction, string>(null, blockParameter);
        }

        public Task<string> DeleteRecordRequestAsync(DeleteRecordFunction deleteRecordFunction)
        {
             return ContractHandler.SendRequestAsync(deleteRecordFunction);
        }

        public Task<TransactionReceipt> DeleteRecordRequestAndWaitForReceiptAsync(DeleteRecordFunction deleteRecordFunction, CancellationTokenSource cancellationToken = null)
        {
             return ContractHandler.SendRequestAndWaitForReceiptAsync(deleteRecordFunction, cancellationToken);
        }

        public Task<string> DeleteRecordRequestAsync(byte[] tableId, List<byte[]> keyTuple)
        {
            var deleteRecordFunction = new DeleteRecordFunction();
                deleteRecordFunction.TableId = tableId;
                deleteRecordFunction.KeyTuple = keyTuple;
            
             return ContractHandler.SendRequestAsync(deleteRecordFunction);
        }

        public Task<TransactionReceipt> DeleteRecordRequestAndWaitForReceiptAsync(byte[] tableId, List<byte[]> keyTuple, CancellationTokenSource cancellationToken = null)
        {
            var deleteRecordFunction = new DeleteRecordFunction();
                deleteRecordFunction.TableId = tableId;
                deleteRecordFunction.KeyTuple = keyTuple;
            
             return ContractHandler.SendRequestAndWaitForReceiptAsync(deleteRecordFunction, cancellationToken);
        }

        public Task<string> FarmingRequestAsync(FarmingFunction farmingFunction)
        {
             return ContractHandler.SendRequestAsync(farmingFunction);
        }

        public Task<TransactionReceipt> FarmingRequestAndWaitForReceiptAsync(FarmingFunction farmingFunction, CancellationTokenSource cancellationToken = null)
        {
             return ContractHandler.SendRequestAndWaitForReceiptAsync(farmingFunction, cancellationToken);
        }

        public Task<string> FarmingRequestAsync(ushort capitalId)
        {
            var farmingFunction = new FarmingFunction();
                farmingFunction.CapitalId = capitalId;
            
             return ContractHandler.SendRequestAsync(farmingFunction);
        }

        public Task<TransactionReceipt> FarmingRequestAndWaitForReceiptAsync(ushort capitalId, CancellationTokenSource cancellationToken = null)
        {
            var farmingFunction = new FarmingFunction();
                farmingFunction.CapitalId = capitalId;
            
             return ContractHandler.SendRequestAndWaitForReceiptAsync(farmingFunction, cancellationToken);
        }

        public Task<string> GarrisonRequestAsync(GarrisonFunction garrisonFunction)
        {
             return ContractHandler.SendRequestAsync(garrisonFunction);
        }

        public Task<TransactionReceipt> GarrisonRequestAndWaitForReceiptAsync(GarrisonFunction garrisonFunction, CancellationTokenSource cancellationToken = null)
        {
             return ContractHandler.SendRequestAndWaitForReceiptAsync(garrisonFunction, cancellationToken);
        }

        public Task<string> GarrisonRequestAsync(ushort capitalId, BigInteger infantry, BigInteger cavalryA, BigInteger cavalryB, BigInteger cavalryC)
        {
            var garrisonFunction = new GarrisonFunction();
                garrisonFunction.CapitalId = capitalId;
                garrisonFunction.Infantry = infantry;
                garrisonFunction.CavalryA = cavalryA;
                garrisonFunction.CavalryB = cavalryB;
                garrisonFunction.CavalryC = cavalryC;
            
             return ContractHandler.SendRequestAsync(garrisonFunction);
        }

        public Task<TransactionReceipt> GarrisonRequestAndWaitForReceiptAsync(ushort capitalId, BigInteger infantry, BigInteger cavalryA, BigInteger cavalryB, BigInteger cavalryC, CancellationTokenSource cancellationToken = null)
        {
            var garrisonFunction = new GarrisonFunction();
                garrisonFunction.CapitalId = capitalId;
                garrisonFunction.Infantry = infantry;
                garrisonFunction.CavalryA = cavalryA;
                garrisonFunction.CavalryB = cavalryB;
                garrisonFunction.CavalryC = cavalryC;
            
             return ContractHandler.SendRequestAndWaitForReceiptAsync(garrisonFunction, cancellationToken);
        }

        public Task<byte[]> GetDynamicFieldQueryAsync(GetDynamicFieldFunction getDynamicFieldFunction, BlockParameter blockParameter = null)
        {
            return ContractHandler.QueryAsync<GetDynamicFieldFunction, byte[]>(getDynamicFieldFunction, blockParameter);
        }

        
        public Task<byte[]> GetDynamicFieldQueryAsync(byte[] tableId, List<byte[]> keyTuple, byte dynamicFieldIndex, BlockParameter blockParameter = null)
        {
            var getDynamicFieldFunction = new GetDynamicFieldFunction();
                getDynamicFieldFunction.TableId = tableId;
                getDynamicFieldFunction.KeyTuple = keyTuple;
                getDynamicFieldFunction.DynamicFieldIndex = dynamicFieldIndex;
            
            return ContractHandler.QueryAsync<GetDynamicFieldFunction, byte[]>(getDynamicFieldFunction, blockParameter);
        }

        public Task<BigInteger> GetDynamicFieldLengthQueryAsync(GetDynamicFieldLengthFunction getDynamicFieldLengthFunction, BlockParameter blockParameter = null)
        {
            return ContractHandler.QueryAsync<GetDynamicFieldLengthFunction, BigInteger>(getDynamicFieldLengthFunction, blockParameter);
        }

        
        public Task<BigInteger> GetDynamicFieldLengthQueryAsync(byte[] tableId, List<byte[]> keyTuple, byte dynamicFieldIndex, BlockParameter blockParameter = null)
        {
            var getDynamicFieldLengthFunction = new GetDynamicFieldLengthFunction();
                getDynamicFieldLengthFunction.TableId = tableId;
                getDynamicFieldLengthFunction.KeyTuple = keyTuple;
                getDynamicFieldLengthFunction.DynamicFieldIndex = dynamicFieldIndex;
            
            return ContractHandler.QueryAsync<GetDynamicFieldLengthFunction, BigInteger>(getDynamicFieldLengthFunction, blockParameter);
        }

        public Task<byte[]> GetDynamicFieldSliceQueryAsync(GetDynamicFieldSliceFunction getDynamicFieldSliceFunction, BlockParameter blockParameter = null)
        {
            return ContractHandler.QueryAsync<GetDynamicFieldSliceFunction, byte[]>(getDynamicFieldSliceFunction, blockParameter);
        }

        
        public Task<byte[]> GetDynamicFieldSliceQueryAsync(byte[] tableId, List<byte[]> keyTuple, byte dynamicFieldIndex, BigInteger start, BigInteger end, BlockParameter blockParameter = null)
        {
            var getDynamicFieldSliceFunction = new GetDynamicFieldSliceFunction();
                getDynamicFieldSliceFunction.TableId = tableId;
                getDynamicFieldSliceFunction.KeyTuple = keyTuple;
                getDynamicFieldSliceFunction.DynamicFieldIndex = dynamicFieldIndex;
                getDynamicFieldSliceFunction.Start = start;
                getDynamicFieldSliceFunction.End = end;
            
            return ContractHandler.QueryAsync<GetDynamicFieldSliceFunction, byte[]>(getDynamicFieldSliceFunction, blockParameter);
        }

        public Task<byte[]> GetFieldQueryAsync(GetField1Function getField1Function, BlockParameter blockParameter = null)
        {
            return ContractHandler.QueryAsync<GetField1Function, byte[]>(getField1Function, blockParameter);
        }

        
        public Task<byte[]> GetFieldQueryAsync(byte[] tableId, List<byte[]> keyTuple, byte fieldIndex, byte[] fieldLayout, BlockParameter blockParameter = null)
        {
            var getField1Function = new GetField1Function();
                getField1Function.TableId = tableId;
                getField1Function.KeyTuple = keyTuple;
                getField1Function.FieldIndex = fieldIndex;
                getField1Function.FieldLayout = fieldLayout;
            
            return ContractHandler.QueryAsync<GetField1Function, byte[]>(getField1Function, blockParameter);
        }

        public Task<byte[]> GetFieldQueryAsync(GetFieldFunction getFieldFunction, BlockParameter blockParameter = null)
        {
            return ContractHandler.QueryAsync<GetFieldFunction, byte[]>(getFieldFunction, blockParameter);
        }

        
        public Task<byte[]> GetFieldQueryAsync(byte[] tableId, List<byte[]> keyTuple, byte fieldIndex, BlockParameter blockParameter = null)
        {
            var getFieldFunction = new GetFieldFunction();
                getFieldFunction.TableId = tableId;
                getFieldFunction.KeyTuple = keyTuple;
                getFieldFunction.FieldIndex = fieldIndex;
            
            return ContractHandler.QueryAsync<GetFieldFunction, byte[]>(getFieldFunction, blockParameter);
        }

        public Task<byte[]> GetFieldLayoutQueryAsync(GetFieldLayoutFunction getFieldLayoutFunction, BlockParameter blockParameter = null)
        {
            return ContractHandler.QueryAsync<GetFieldLayoutFunction, byte[]>(getFieldLayoutFunction, blockParameter);
        }

        
        public Task<byte[]> GetFieldLayoutQueryAsync(byte[] tableId, BlockParameter blockParameter = null)
        {
            var getFieldLayoutFunction = new GetFieldLayoutFunction();
                getFieldLayoutFunction.TableId = tableId;
            
            return ContractHandler.QueryAsync<GetFieldLayoutFunction, byte[]>(getFieldLayoutFunction, blockParameter);
        }

        public Task<BigInteger> GetFieldLengthQueryAsync(GetFieldLength1Function getFieldLength1Function, BlockParameter blockParameter = null)
        {
            return ContractHandler.QueryAsync<GetFieldLength1Function, BigInteger>(getFieldLength1Function, blockParameter);
        }

        
        public Task<BigInteger> GetFieldLengthQueryAsync(byte[] tableId, List<byte[]> keyTuple, byte fieldIndex, byte[] fieldLayout, BlockParameter blockParameter = null)
        {
            var getFieldLength1Function = new GetFieldLength1Function();
                getFieldLength1Function.TableId = tableId;
                getFieldLength1Function.KeyTuple = keyTuple;
                getFieldLength1Function.FieldIndex = fieldIndex;
                getFieldLength1Function.FieldLayout = fieldLayout;
            
            return ContractHandler.QueryAsync<GetFieldLength1Function, BigInteger>(getFieldLength1Function, blockParameter);
        }

        public Task<BigInteger> GetFieldLengthQueryAsync(GetFieldLengthFunction getFieldLengthFunction, BlockParameter blockParameter = null)
        {
            return ContractHandler.QueryAsync<GetFieldLengthFunction, BigInteger>(getFieldLengthFunction, blockParameter);
        }

        
        public Task<BigInteger> GetFieldLengthQueryAsync(byte[] tableId, List<byte[]> keyTuple, byte fieldIndex, BlockParameter blockParameter = null)
        {
            var getFieldLengthFunction = new GetFieldLengthFunction();
                getFieldLengthFunction.TableId = tableId;
                getFieldLengthFunction.KeyTuple = keyTuple;
                getFieldLengthFunction.FieldIndex = fieldIndex;
            
            return ContractHandler.QueryAsync<GetFieldLengthFunction, BigInteger>(getFieldLengthFunction, blockParameter);
        }

        public Task<byte[]> GetKeySchemaQueryAsync(GetKeySchemaFunction getKeySchemaFunction, BlockParameter blockParameter = null)
        {
            return ContractHandler.QueryAsync<GetKeySchemaFunction, byte[]>(getKeySchemaFunction, blockParameter);
        }

        
        public Task<byte[]> GetKeySchemaQueryAsync(byte[] tableId, BlockParameter blockParameter = null)
        {
            var getKeySchemaFunction = new GetKeySchemaFunction();
                getKeySchemaFunction.TableId = tableId;
            
            return ContractHandler.QueryAsync<GetKeySchemaFunction, byte[]>(getKeySchemaFunction, blockParameter);
        }

        public Task<GetRecord1OutputDTO> GetRecordQueryAsync(GetRecord1Function getRecord1Function, BlockParameter blockParameter = null)
        {
            return ContractHandler.QueryDeserializingToObjectAsync<GetRecord1Function, GetRecord1OutputDTO>(getRecord1Function, blockParameter);
        }

        public Task<GetRecord1OutputDTO> GetRecordQueryAsync(byte[] tableId, List<byte[]> keyTuple, byte[] fieldLayout, BlockParameter blockParameter = null)
        {
            var getRecord1Function = new GetRecord1Function();
                getRecord1Function.TableId = tableId;
                getRecord1Function.KeyTuple = keyTuple;
                getRecord1Function.FieldLayout = fieldLayout;
            
            return ContractHandler.QueryDeserializingToObjectAsync<GetRecord1Function, GetRecord1OutputDTO>(getRecord1Function, blockParameter);
        }

        public Task<GetRecordOutputDTO> GetRecordQueryAsync(GetRecordFunction getRecordFunction, BlockParameter blockParameter = null)
        {
            return ContractHandler.QueryDeserializingToObjectAsync<GetRecordFunction, GetRecordOutputDTO>(getRecordFunction, blockParameter);
        }

        public Task<GetRecordOutputDTO> GetRecordQueryAsync(byte[] tableId, List<byte[]> keyTuple, BlockParameter blockParameter = null)
        {
            var getRecordFunction = new GetRecordFunction();
                getRecordFunction.TableId = tableId;
                getRecordFunction.KeyTuple = keyTuple;
            
            return ContractHandler.QueryDeserializingToObjectAsync<GetRecordFunction, GetRecordOutputDTO>(getRecordFunction, blockParameter);
        }

        public Task<BigInteger> GetStageOneEndTimeQueryAsync(GetStageOneEndTimeFunction getStageOneEndTimeFunction, BlockParameter blockParameter = null)
        {
            return ContractHandler.QueryAsync<GetStageOneEndTimeFunction, BigInteger>(getStageOneEndTimeFunction, blockParameter);
        }

        
        public Task<BigInteger> GetStageOneEndTimeQueryAsync(BlockParameter blockParameter = null)
        {
            return ContractHandler.QueryAsync<GetStageOneEndTimeFunction, BigInteger>(null, blockParameter);
        }

        public Task<byte[]> GetStaticFieldQueryAsync(GetStaticFieldFunction getStaticFieldFunction, BlockParameter blockParameter = null)
        {
            return ContractHandler.QueryAsync<GetStaticFieldFunction, byte[]>(getStaticFieldFunction, blockParameter);
        }

        
        public Task<byte[]> GetStaticFieldQueryAsync(byte[] tableId, List<byte[]> keyTuple, byte fieldIndex, byte[] fieldLayout, BlockParameter blockParameter = null)
        {
            var getStaticFieldFunction = new GetStaticFieldFunction();
                getStaticFieldFunction.TableId = tableId;
                getStaticFieldFunction.KeyTuple = keyTuple;
                getStaticFieldFunction.FieldIndex = fieldIndex;
                getStaticFieldFunction.FieldLayout = fieldLayout;
            
            return ContractHandler.QueryAsync<GetStaticFieldFunction, byte[]>(getStaticFieldFunction, blockParameter);
        }

        public Task<byte[]> GetValueSchemaQueryAsync(GetValueSchemaFunction getValueSchemaFunction, BlockParameter blockParameter = null)
        {
            return ContractHandler.QueryAsync<GetValueSchemaFunction, byte[]>(getValueSchemaFunction, blockParameter);
        }

        
        public Task<byte[]> GetValueSchemaQueryAsync(byte[] tableId, BlockParameter blockParameter = null)
        {
            var getValueSchemaFunction = new GetValueSchemaFunction();
                getValueSchemaFunction.TableId = tableId;
            
            return ContractHandler.QueryAsync<GetValueSchemaFunction, byte[]>(getValueSchemaFunction, blockParameter);
        }

        public Task<string> GrantAccessRequestAsync(GrantAccessFunction grantAccessFunction)
        {
             return ContractHandler.SendRequestAsync(grantAccessFunction);
        }

        public Task<TransactionReceipt> GrantAccessRequestAndWaitForReceiptAsync(GrantAccessFunction grantAccessFunction, CancellationTokenSource cancellationToken = null)
        {
             return ContractHandler.SendRequestAndWaitForReceiptAsync(grantAccessFunction, cancellationToken);
        }

        public Task<string> GrantAccessRequestAsync(byte[] resourceId, string grantee)
        {
            var grantAccessFunction = new GrantAccessFunction();
                grantAccessFunction.ResourceId = resourceId;
                grantAccessFunction.Grantee = grantee;
            
             return ContractHandler.SendRequestAsync(grantAccessFunction);
        }

        public Task<TransactionReceipt> GrantAccessRequestAndWaitForReceiptAsync(byte[] resourceId, string grantee, CancellationTokenSource cancellationToken = null)
        {
            var grantAccessFunction = new GrantAccessFunction();
                grantAccessFunction.ResourceId = resourceId;
                grantAccessFunction.Grantee = grantee;
            
             return ContractHandler.SendRequestAndWaitForReceiptAsync(grantAccessFunction, cancellationToken);
        }

        public Task<string> InitializeRequestAsync(InitializeFunction initializeFunction)
        {
             return ContractHandler.SendRequestAsync(initializeFunction);
        }

        public Task<TransactionReceipt> InitializeRequestAndWaitForReceiptAsync(InitializeFunction initializeFunction, CancellationTokenSource cancellationToken = null)
        {
             return ContractHandler.SendRequestAndWaitForReceiptAsync(initializeFunction, cancellationToken);
        }

        public Task<string> InitializeRequestAsync(string initModule)
        {
            var initializeFunction = new InitializeFunction();
                initializeFunction.InitModule = initModule;
            
             return ContractHandler.SendRequestAsync(initializeFunction);
        }

        public Task<TransactionReceipt> InitializeRequestAndWaitForReceiptAsync(string initModule, CancellationTokenSource cancellationToken = null)
        {
            var initializeFunction = new InitializeFunction();
                initializeFunction.InitModule = initModule;
            
             return ContractHandler.SendRequestAndWaitForReceiptAsync(initializeFunction, cancellationToken);
        }

        public Task<string> InstallModuleRequestAsync(InstallModuleFunction installModuleFunction)
        {
             return ContractHandler.SendRequestAsync(installModuleFunction);
        }

        public Task<TransactionReceipt> InstallModuleRequestAndWaitForReceiptAsync(InstallModuleFunction installModuleFunction, CancellationTokenSource cancellationToken = null)
        {
             return ContractHandler.SendRequestAndWaitForReceiptAsync(installModuleFunction, cancellationToken);
        }

        public Task<string> InstallModuleRequestAsync(string module, byte[] encodedArgs)
        {
            var installModuleFunction = new InstallModuleFunction();
                installModuleFunction.Module = module;
                installModuleFunction.EncodedArgs = encodedArgs;
            
             return ContractHandler.SendRequestAsync(installModuleFunction);
        }

        public Task<TransactionReceipt> InstallModuleRequestAndWaitForReceiptAsync(string module, byte[] encodedArgs, CancellationTokenSource cancellationToken = null)
        {
            var installModuleFunction = new InstallModuleFunction();
                installModuleFunction.Module = module;
                installModuleFunction.EncodedArgs = encodedArgs;
            
             return ContractHandler.SendRequestAndWaitForReceiptAsync(installModuleFunction, cancellationToken);
        }

        public Task<string> InstallRootModuleRequestAsync(InstallRootModuleFunction installRootModuleFunction)
        {
             return ContractHandler.SendRequestAsync(installRootModuleFunction);
        }

        public Task<TransactionReceipt> InstallRootModuleRequestAndWaitForReceiptAsync(InstallRootModuleFunction installRootModuleFunction, CancellationTokenSource cancellationToken = null)
        {
             return ContractHandler.SendRequestAndWaitForReceiptAsync(installRootModuleFunction, cancellationToken);
        }

        public Task<string> InstallRootModuleRequestAsync(string module, byte[] encodedArgs)
        {
            var installRootModuleFunction = new InstallRootModuleFunction();
                installRootModuleFunction.Module = module;
                installRootModuleFunction.EncodedArgs = encodedArgs;
            
             return ContractHandler.SendRequestAsync(installRootModuleFunction);
        }

        public Task<TransactionReceipt> InstallRootModuleRequestAndWaitForReceiptAsync(string module, byte[] encodedArgs, CancellationTokenSource cancellationToken = null)
        {
            var installRootModuleFunction = new InstallRootModuleFunction();
                installRootModuleFunction.Module = module;
                installRootModuleFunction.EncodedArgs = encodedArgs;
            
             return ContractHandler.SendRequestAndWaitForReceiptAsync(installRootModuleFunction, cancellationToken);
        }

        public Task<string> MarchRequestAsync(MarchFunction marchFunction)
        {
             return ContractHandler.SendRequestAsync(marchFunction);
        }

        public Task<TransactionReceipt> MarchRequestAndWaitForReceiptAsync(MarchFunction marchFunction, CancellationTokenSource cancellationToken = null)
        {
             return ContractHandler.SendRequestAndWaitForReceiptAsync(marchFunction, cancellationToken);
        }

        public Task<string> MarchRequestAsync(ushort destination, BigInteger infantry, BigInteger cavalryA, BigInteger cavalryB, BigInteger cavalryC, byte armyId)
        {
            var marchFunction = new MarchFunction();
                marchFunction.Destination = destination;
                marchFunction.Infantry = infantry;
                marchFunction.CavalryA = cavalryA;
                marchFunction.CavalryB = cavalryB;
                marchFunction.CavalryC = cavalryC;
                marchFunction.ArmyId = armyId;
            
             return ContractHandler.SendRequestAsync(marchFunction);
        }

        public Task<TransactionReceipt> MarchRequestAndWaitForReceiptAsync(ushort destination, BigInteger infantry, BigInteger cavalryA, BigInteger cavalryB, BigInteger cavalryC, byte armyId, CancellationTokenSource cancellationToken = null)
        {
            var marchFunction = new MarchFunction();
                marchFunction.Destination = destination;
                marchFunction.Infantry = infantry;
                marchFunction.CavalryA = cavalryA;
                marchFunction.CavalryB = cavalryB;
                marchFunction.CavalryC = cavalryC;
                marchFunction.ArmyId = armyId;
            
             return ContractHandler.SendRequestAndWaitForReceiptAsync(marchFunction, cancellationToken);
        }

        public Task<string> PopFromDynamicFieldRequestAsync(PopFromDynamicFieldFunction popFromDynamicFieldFunction)
        {
             return ContractHandler.SendRequestAsync(popFromDynamicFieldFunction);
        }

        public Task<TransactionReceipt> PopFromDynamicFieldRequestAndWaitForReceiptAsync(PopFromDynamicFieldFunction popFromDynamicFieldFunction, CancellationTokenSource cancellationToken = null)
        {
             return ContractHandler.SendRequestAndWaitForReceiptAsync(popFromDynamicFieldFunction, cancellationToken);
        }

        public Task<string> PopFromDynamicFieldRequestAsync(byte[] tableId, List<byte[]> keyTuple, byte dynamicFieldIndex, BigInteger byteLengthToPop)
        {
            var popFromDynamicFieldFunction = new PopFromDynamicFieldFunction();
                popFromDynamicFieldFunction.TableId = tableId;
                popFromDynamicFieldFunction.KeyTuple = keyTuple;
                popFromDynamicFieldFunction.DynamicFieldIndex = dynamicFieldIndex;
                popFromDynamicFieldFunction.ByteLengthToPop = byteLengthToPop;
            
             return ContractHandler.SendRequestAsync(popFromDynamicFieldFunction);
        }

        public Task<TransactionReceipt> PopFromDynamicFieldRequestAndWaitForReceiptAsync(byte[] tableId, List<byte[]> keyTuple, byte dynamicFieldIndex, BigInteger byteLengthToPop, CancellationTokenSource cancellationToken = null)
        {
            var popFromDynamicFieldFunction = new PopFromDynamicFieldFunction();
                popFromDynamicFieldFunction.TableId = tableId;
                popFromDynamicFieldFunction.KeyTuple = keyTuple;
                popFromDynamicFieldFunction.DynamicFieldIndex = dynamicFieldIndex;
                popFromDynamicFieldFunction.ByteLengthToPop = byteLengthToPop;
            
             return ContractHandler.SendRequestAndWaitForReceiptAsync(popFromDynamicFieldFunction, cancellationToken);
        }

        public Task<string> PushToDynamicFieldRequestAsync(PushToDynamicFieldFunction pushToDynamicFieldFunction)
        {
             return ContractHandler.SendRequestAsync(pushToDynamicFieldFunction);
        }

        public Task<TransactionReceipt> PushToDynamicFieldRequestAndWaitForReceiptAsync(PushToDynamicFieldFunction pushToDynamicFieldFunction, CancellationTokenSource cancellationToken = null)
        {
             return ContractHandler.SendRequestAndWaitForReceiptAsync(pushToDynamicFieldFunction, cancellationToken);
        }

        public Task<string> PushToDynamicFieldRequestAsync(byte[] tableId, List<byte[]> keyTuple, byte dynamicFieldIndex, byte[] dataToPush)
        {
            var pushToDynamicFieldFunction = new PushToDynamicFieldFunction();
                pushToDynamicFieldFunction.TableId = tableId;
                pushToDynamicFieldFunction.KeyTuple = keyTuple;
                pushToDynamicFieldFunction.DynamicFieldIndex = dynamicFieldIndex;
                pushToDynamicFieldFunction.DataToPush = dataToPush;
            
             return ContractHandler.SendRequestAsync(pushToDynamicFieldFunction);
        }

        public Task<TransactionReceipt> PushToDynamicFieldRequestAndWaitForReceiptAsync(byte[] tableId, List<byte[]> keyTuple, byte dynamicFieldIndex, byte[] dataToPush, CancellationTokenSource cancellationToken = null)
        {
            var pushToDynamicFieldFunction = new PushToDynamicFieldFunction();
                pushToDynamicFieldFunction.TableId = tableId;
                pushToDynamicFieldFunction.KeyTuple = keyTuple;
                pushToDynamicFieldFunction.DynamicFieldIndex = dynamicFieldIndex;
                pushToDynamicFieldFunction.DataToPush = dataToPush;
            
             return ContractHandler.SendRequestAndWaitForReceiptAsync(pushToDynamicFieldFunction, cancellationToken);
        }

        public Task<string> RegisterDelegationRequestAsync(RegisterDelegationFunction registerDelegationFunction)
        {
             return ContractHandler.SendRequestAsync(registerDelegationFunction);
        }

        public Task<TransactionReceipt> RegisterDelegationRequestAndWaitForReceiptAsync(RegisterDelegationFunction registerDelegationFunction, CancellationTokenSource cancellationToken = null)
        {
             return ContractHandler.SendRequestAndWaitForReceiptAsync(registerDelegationFunction, cancellationToken);
        }

        public Task<string> RegisterDelegationRequestAsync(string delegatee, byte[] delegationControlId, byte[] initCallData)
        {
            var registerDelegationFunction = new RegisterDelegationFunction();
                registerDelegationFunction.Delegatee = delegatee;
                registerDelegationFunction.DelegationControlId = delegationControlId;
                registerDelegationFunction.InitCallData = initCallData;
            
             return ContractHandler.SendRequestAsync(registerDelegationFunction);
        }

        public Task<TransactionReceipt> RegisterDelegationRequestAndWaitForReceiptAsync(string delegatee, byte[] delegationControlId, byte[] initCallData, CancellationTokenSource cancellationToken = null)
        {
            var registerDelegationFunction = new RegisterDelegationFunction();
                registerDelegationFunction.Delegatee = delegatee;
                registerDelegationFunction.DelegationControlId = delegationControlId;
                registerDelegationFunction.InitCallData = initCallData;
            
             return ContractHandler.SendRequestAndWaitForReceiptAsync(registerDelegationFunction, cancellationToken);
        }

        public Task<string> RegisterFunctionSelectorRequestAsync(RegisterFunctionSelectorFunction registerFunctionSelectorFunction)
        {
             return ContractHandler.SendRequestAsync(registerFunctionSelectorFunction);
        }

        public Task<TransactionReceipt> RegisterFunctionSelectorRequestAndWaitForReceiptAsync(RegisterFunctionSelectorFunction registerFunctionSelectorFunction, CancellationTokenSource cancellationToken = null)
        {
             return ContractHandler.SendRequestAndWaitForReceiptAsync(registerFunctionSelectorFunction, cancellationToken);
        }

        public Task<string> RegisterFunctionSelectorRequestAsync(byte[] systemId, string systemFunctionSignature)
        {
            var registerFunctionSelectorFunction = new RegisterFunctionSelectorFunction();
                registerFunctionSelectorFunction.SystemId = systemId;
                registerFunctionSelectorFunction.SystemFunctionSignature = systemFunctionSignature;
            
             return ContractHandler.SendRequestAsync(registerFunctionSelectorFunction);
        }

        public Task<TransactionReceipt> RegisterFunctionSelectorRequestAndWaitForReceiptAsync(byte[] systemId, string systemFunctionSignature, CancellationTokenSource cancellationToken = null)
        {
            var registerFunctionSelectorFunction = new RegisterFunctionSelectorFunction();
                registerFunctionSelectorFunction.SystemId = systemId;
                registerFunctionSelectorFunction.SystemFunctionSignature = systemFunctionSignature;
            
             return ContractHandler.SendRequestAndWaitForReceiptAsync(registerFunctionSelectorFunction, cancellationToken);
        }

        public Task<string> RegisterNamespaceRequestAsync(RegisterNamespaceFunction registerNamespaceFunction)
        {
             return ContractHandler.SendRequestAsync(registerNamespaceFunction);
        }

        public Task<TransactionReceipt> RegisterNamespaceRequestAndWaitForReceiptAsync(RegisterNamespaceFunction registerNamespaceFunction, CancellationTokenSource cancellationToken = null)
        {
             return ContractHandler.SendRequestAndWaitForReceiptAsync(registerNamespaceFunction, cancellationToken);
        }

        public Task<string> RegisterNamespaceRequestAsync(byte[] namespaceId)
        {
            var registerNamespaceFunction = new RegisterNamespaceFunction();
                registerNamespaceFunction.NamespaceId = namespaceId;
            
             return ContractHandler.SendRequestAsync(registerNamespaceFunction);
        }

        public Task<TransactionReceipt> RegisterNamespaceRequestAndWaitForReceiptAsync(byte[] namespaceId, CancellationTokenSource cancellationToken = null)
        {
            var registerNamespaceFunction = new RegisterNamespaceFunction();
                registerNamespaceFunction.NamespaceId = namespaceId;
            
             return ContractHandler.SendRequestAndWaitForReceiptAsync(registerNamespaceFunction, cancellationToken);
        }

        public Task<string> RegisterNamespaceDelegationRequestAsync(RegisterNamespaceDelegationFunction registerNamespaceDelegationFunction)
        {
             return ContractHandler.SendRequestAsync(registerNamespaceDelegationFunction);
        }

        public Task<TransactionReceipt> RegisterNamespaceDelegationRequestAndWaitForReceiptAsync(RegisterNamespaceDelegationFunction registerNamespaceDelegationFunction, CancellationTokenSource cancellationToken = null)
        {
             return ContractHandler.SendRequestAndWaitForReceiptAsync(registerNamespaceDelegationFunction, cancellationToken);
        }

        public Task<string> RegisterNamespaceDelegationRequestAsync(byte[] namespaceId, byte[] delegationControlId, byte[] initCallData)
        {
            var registerNamespaceDelegationFunction = new RegisterNamespaceDelegationFunction();
                registerNamespaceDelegationFunction.NamespaceId = namespaceId;
                registerNamespaceDelegationFunction.DelegationControlId = delegationControlId;
                registerNamespaceDelegationFunction.InitCallData = initCallData;
            
             return ContractHandler.SendRequestAsync(registerNamespaceDelegationFunction);
        }

        public Task<TransactionReceipt> RegisterNamespaceDelegationRequestAndWaitForReceiptAsync(byte[] namespaceId, byte[] delegationControlId, byte[] initCallData, CancellationTokenSource cancellationToken = null)
        {
            var registerNamespaceDelegationFunction = new RegisterNamespaceDelegationFunction();
                registerNamespaceDelegationFunction.NamespaceId = namespaceId;
                registerNamespaceDelegationFunction.DelegationControlId = delegationControlId;
                registerNamespaceDelegationFunction.InitCallData = initCallData;
            
             return ContractHandler.SendRequestAndWaitForReceiptAsync(registerNamespaceDelegationFunction, cancellationToken);
        }

        public Task<string> RegisterRootFunctionSelectorRequestAsync(RegisterRootFunctionSelectorFunction registerRootFunctionSelectorFunction)
        {
             return ContractHandler.SendRequestAsync(registerRootFunctionSelectorFunction);
        }

        public Task<TransactionReceipt> RegisterRootFunctionSelectorRequestAndWaitForReceiptAsync(RegisterRootFunctionSelectorFunction registerRootFunctionSelectorFunction, CancellationTokenSource cancellationToken = null)
        {
             return ContractHandler.SendRequestAndWaitForReceiptAsync(registerRootFunctionSelectorFunction, cancellationToken);
        }

        public Task<string> RegisterRootFunctionSelectorRequestAsync(byte[] systemId, string worldFunctionSignature, string systemFunctionSignature)
        {
            var registerRootFunctionSelectorFunction = new RegisterRootFunctionSelectorFunction();
                registerRootFunctionSelectorFunction.SystemId = systemId;
                registerRootFunctionSelectorFunction.WorldFunctionSignature = worldFunctionSignature;
                registerRootFunctionSelectorFunction.SystemFunctionSignature = systemFunctionSignature;
            
             return ContractHandler.SendRequestAsync(registerRootFunctionSelectorFunction);
        }

        public Task<TransactionReceipt> RegisterRootFunctionSelectorRequestAndWaitForReceiptAsync(byte[] systemId, string worldFunctionSignature, string systemFunctionSignature, CancellationTokenSource cancellationToken = null)
        {
            var registerRootFunctionSelectorFunction = new RegisterRootFunctionSelectorFunction();
                registerRootFunctionSelectorFunction.SystemId = systemId;
                registerRootFunctionSelectorFunction.WorldFunctionSignature = worldFunctionSignature;
                registerRootFunctionSelectorFunction.SystemFunctionSignature = systemFunctionSignature;
            
             return ContractHandler.SendRequestAndWaitForReceiptAsync(registerRootFunctionSelectorFunction, cancellationToken);
        }

        public Task<string> RegisterStoreHookRequestAsync(RegisterStoreHookFunction registerStoreHookFunction)
        {
             return ContractHandler.SendRequestAsync(registerStoreHookFunction);
        }

        public Task<TransactionReceipt> RegisterStoreHookRequestAndWaitForReceiptAsync(RegisterStoreHookFunction registerStoreHookFunction, CancellationTokenSource cancellationToken = null)
        {
             return ContractHandler.SendRequestAndWaitForReceiptAsync(registerStoreHookFunction, cancellationToken);
        }

        public Task<string> RegisterStoreHookRequestAsync(byte[] tableId, string hookAddress, byte enabledHooksBitmap)
        {
            var registerStoreHookFunction = new RegisterStoreHookFunction();
                registerStoreHookFunction.TableId = tableId;
                registerStoreHookFunction.HookAddress = hookAddress;
                registerStoreHookFunction.EnabledHooksBitmap = enabledHooksBitmap;
            
             return ContractHandler.SendRequestAsync(registerStoreHookFunction);
        }

        public Task<TransactionReceipt> RegisterStoreHookRequestAndWaitForReceiptAsync(byte[] tableId, string hookAddress, byte enabledHooksBitmap, CancellationTokenSource cancellationToken = null)
        {
            var registerStoreHookFunction = new RegisterStoreHookFunction();
                registerStoreHookFunction.TableId = tableId;
                registerStoreHookFunction.HookAddress = hookAddress;
                registerStoreHookFunction.EnabledHooksBitmap = enabledHooksBitmap;
            
             return ContractHandler.SendRequestAndWaitForReceiptAsync(registerStoreHookFunction, cancellationToken);
        }

        public Task<string> RegisterSystemRequestAsync(RegisterSystemFunction registerSystemFunction)
        {
             return ContractHandler.SendRequestAsync(registerSystemFunction);
        }

        public Task<TransactionReceipt> RegisterSystemRequestAndWaitForReceiptAsync(RegisterSystemFunction registerSystemFunction, CancellationTokenSource cancellationToken = null)
        {
             return ContractHandler.SendRequestAndWaitForReceiptAsync(registerSystemFunction, cancellationToken);
        }

        public Task<string> RegisterSystemRequestAsync(byte[] systemId, string system, bool publicAccess)
        {
            var registerSystemFunction = new RegisterSystemFunction();
                registerSystemFunction.SystemId = systemId;
                registerSystemFunction.System = system;
                registerSystemFunction.PublicAccess = publicAccess;
            
             return ContractHandler.SendRequestAsync(registerSystemFunction);
        }

        public Task<TransactionReceipt> RegisterSystemRequestAndWaitForReceiptAsync(byte[] systemId, string system, bool publicAccess, CancellationTokenSource cancellationToken = null)
        {
            var registerSystemFunction = new RegisterSystemFunction();
                registerSystemFunction.SystemId = systemId;
                registerSystemFunction.System = system;
                registerSystemFunction.PublicAccess = publicAccess;
            
             return ContractHandler.SendRequestAndWaitForReceiptAsync(registerSystemFunction, cancellationToken);
        }

        public Task<string> RegisterSystemHookRequestAsync(RegisterSystemHookFunction registerSystemHookFunction)
        {
             return ContractHandler.SendRequestAsync(registerSystemHookFunction);
        }

        public Task<TransactionReceipt> RegisterSystemHookRequestAndWaitForReceiptAsync(RegisterSystemHookFunction registerSystemHookFunction, CancellationTokenSource cancellationToken = null)
        {
             return ContractHandler.SendRequestAndWaitForReceiptAsync(registerSystemHookFunction, cancellationToken);
        }

        public Task<string> RegisterSystemHookRequestAsync(byte[] systemId, string hookAddress, byte enabledHooksBitmap)
        {
            var registerSystemHookFunction = new RegisterSystemHookFunction();
                registerSystemHookFunction.SystemId = systemId;
                registerSystemHookFunction.HookAddress = hookAddress;
                registerSystemHookFunction.EnabledHooksBitmap = enabledHooksBitmap;
            
             return ContractHandler.SendRequestAsync(registerSystemHookFunction);
        }

        public Task<TransactionReceipt> RegisterSystemHookRequestAndWaitForReceiptAsync(byte[] systemId, string hookAddress, byte enabledHooksBitmap, CancellationTokenSource cancellationToken = null)
        {
            var registerSystemHookFunction = new RegisterSystemHookFunction();
                registerSystemHookFunction.SystemId = systemId;
                registerSystemHookFunction.HookAddress = hookAddress;
                registerSystemHookFunction.EnabledHooksBitmap = enabledHooksBitmap;
            
             return ContractHandler.SendRequestAndWaitForReceiptAsync(registerSystemHookFunction, cancellationToken);
        }

        public Task<string> RegisterTableRequestAsync(RegisterTableFunction registerTableFunction)
        {
             return ContractHandler.SendRequestAsync(registerTableFunction);
        }

        public Task<TransactionReceipt> RegisterTableRequestAndWaitForReceiptAsync(RegisterTableFunction registerTableFunction, CancellationTokenSource cancellationToken = null)
        {
             return ContractHandler.SendRequestAndWaitForReceiptAsync(registerTableFunction, cancellationToken);
        }

        public Task<string> RegisterTableRequestAsync(byte[] tableId, byte[] fieldLayout, byte[] keySchema, byte[] valueSchema, List<string> keyNames, List<string> fieldNames)
        {
            var registerTableFunction = new RegisterTableFunction();
                registerTableFunction.TableId = tableId;
                registerTableFunction.FieldLayout = fieldLayout;
                registerTableFunction.KeySchema = keySchema;
                registerTableFunction.ValueSchema = valueSchema;
                registerTableFunction.KeyNames = keyNames;
                registerTableFunction.FieldNames = fieldNames;
            
             return ContractHandler.SendRequestAsync(registerTableFunction);
        }

        public Task<TransactionReceipt> RegisterTableRequestAndWaitForReceiptAsync(byte[] tableId, byte[] fieldLayout, byte[] keySchema, byte[] valueSchema, List<string> keyNames, List<string> fieldNames, CancellationTokenSource cancellationToken = null)
        {
            var registerTableFunction = new RegisterTableFunction();
                registerTableFunction.TableId = tableId;
                registerTableFunction.FieldLayout = fieldLayout;
                registerTableFunction.KeySchema = keySchema;
                registerTableFunction.ValueSchema = valueSchema;
                registerTableFunction.KeyNames = keyNames;
                registerTableFunction.FieldNames = fieldNames;
            
             return ContractHandler.SendRequestAndWaitForReceiptAsync(registerTableFunction, cancellationToken);
        }

        public Task<string> RenounceOwnershipRequestAsync(RenounceOwnershipFunction renounceOwnershipFunction)
        {
             return ContractHandler.SendRequestAsync(renounceOwnershipFunction);
        }

        public Task<TransactionReceipt> RenounceOwnershipRequestAndWaitForReceiptAsync(RenounceOwnershipFunction renounceOwnershipFunction, CancellationTokenSource cancellationToken = null)
        {
             return ContractHandler.SendRequestAndWaitForReceiptAsync(renounceOwnershipFunction, cancellationToken);
        }

        public Task<string> RenounceOwnershipRequestAsync(byte[] namespaceId)
        {
            var renounceOwnershipFunction = new RenounceOwnershipFunction();
                renounceOwnershipFunction.NamespaceId = namespaceId;
            
             return ContractHandler.SendRequestAsync(renounceOwnershipFunction);
        }

        public Task<TransactionReceipt> RenounceOwnershipRequestAndWaitForReceiptAsync(byte[] namespaceId, CancellationTokenSource cancellationToken = null)
        {
            var renounceOwnershipFunction = new RenounceOwnershipFunction();
                renounceOwnershipFunction.NamespaceId = namespaceId;
            
             return ContractHandler.SendRequestAndWaitForReceiptAsync(renounceOwnershipFunction, cancellationToken);
        }

        public Task<string> RevokeAccessRequestAsync(RevokeAccessFunction revokeAccessFunction)
        {
             return ContractHandler.SendRequestAsync(revokeAccessFunction);
        }

        public Task<TransactionReceipt> RevokeAccessRequestAndWaitForReceiptAsync(RevokeAccessFunction revokeAccessFunction, CancellationTokenSource cancellationToken = null)
        {
             return ContractHandler.SendRequestAndWaitForReceiptAsync(revokeAccessFunction, cancellationToken);
        }

        public Task<string> RevokeAccessRequestAsync(byte[] resourceId, string grantee)
        {
            var revokeAccessFunction = new RevokeAccessFunction();
                revokeAccessFunction.ResourceId = resourceId;
                revokeAccessFunction.Grantee = grantee;
            
             return ContractHandler.SendRequestAsync(revokeAccessFunction);
        }

        public Task<TransactionReceipt> RevokeAccessRequestAndWaitForReceiptAsync(byte[] resourceId, string grantee, CancellationTokenSource cancellationToken = null)
        {
            var revokeAccessFunction = new RevokeAccessFunction();
                revokeAccessFunction.ResourceId = resourceId;
                revokeAccessFunction.Grantee = grantee;
            
             return ContractHandler.SendRequestAndWaitForReceiptAsync(revokeAccessFunction, cancellationToken);
        }

        public Task<string> SetDynamicFieldRequestAsync(SetDynamicFieldFunction setDynamicFieldFunction)
        {
             return ContractHandler.SendRequestAsync(setDynamicFieldFunction);
        }

        public Task<TransactionReceipt> SetDynamicFieldRequestAndWaitForReceiptAsync(SetDynamicFieldFunction setDynamicFieldFunction, CancellationTokenSource cancellationToken = null)
        {
             return ContractHandler.SendRequestAndWaitForReceiptAsync(setDynamicFieldFunction, cancellationToken);
        }

        public Task<string> SetDynamicFieldRequestAsync(byte[] tableId, List<byte[]> keyTuple, byte dynamicFieldIndex, byte[] data)
        {
            var setDynamicFieldFunction = new SetDynamicFieldFunction();
                setDynamicFieldFunction.TableId = tableId;
                setDynamicFieldFunction.KeyTuple = keyTuple;
                setDynamicFieldFunction.DynamicFieldIndex = dynamicFieldIndex;
                setDynamicFieldFunction.Data = data;
            
             return ContractHandler.SendRequestAsync(setDynamicFieldFunction);
        }

        public Task<TransactionReceipt> SetDynamicFieldRequestAndWaitForReceiptAsync(byte[] tableId, List<byte[]> keyTuple, byte dynamicFieldIndex, byte[] data, CancellationTokenSource cancellationToken = null)
        {
            var setDynamicFieldFunction = new SetDynamicFieldFunction();
                setDynamicFieldFunction.TableId = tableId;
                setDynamicFieldFunction.KeyTuple = keyTuple;
                setDynamicFieldFunction.DynamicFieldIndex = dynamicFieldIndex;
                setDynamicFieldFunction.Data = data;
            
             return ContractHandler.SendRequestAndWaitForReceiptAsync(setDynamicFieldFunction, cancellationToken);
        }

        public Task<string> SetFieldRequestAsync(SetFieldFunction setFieldFunction)
        {
             return ContractHandler.SendRequestAsync(setFieldFunction);
        }

        public Task<TransactionReceipt> SetFieldRequestAndWaitForReceiptAsync(SetFieldFunction setFieldFunction, CancellationTokenSource cancellationToken = null)
        {
             return ContractHandler.SendRequestAndWaitForReceiptAsync(setFieldFunction, cancellationToken);
        }

        public Task<string> SetFieldRequestAsync(byte[] tableId, List<byte[]> keyTuple, byte fieldIndex, byte[] data)
        {
            var setFieldFunction = new SetFieldFunction();
                setFieldFunction.TableId = tableId;
                setFieldFunction.KeyTuple = keyTuple;
                setFieldFunction.FieldIndex = fieldIndex;
                setFieldFunction.Data = data;
            
             return ContractHandler.SendRequestAsync(setFieldFunction);
        }

        public Task<TransactionReceipt> SetFieldRequestAndWaitForReceiptAsync(byte[] tableId, List<byte[]> keyTuple, byte fieldIndex, byte[] data, CancellationTokenSource cancellationToken = null)
        {
            var setFieldFunction = new SetFieldFunction();
                setFieldFunction.TableId = tableId;
                setFieldFunction.KeyTuple = keyTuple;
                setFieldFunction.FieldIndex = fieldIndex;
                setFieldFunction.Data = data;
            
             return ContractHandler.SendRequestAndWaitForReceiptAsync(setFieldFunction, cancellationToken);
        }

        public Task<string> SetFieldRequestAsync(SetField1Function setField1Function)
        {
             return ContractHandler.SendRequestAsync(setField1Function);
        }

        public Task<TransactionReceipt> SetFieldRequestAndWaitForReceiptAsync(SetField1Function setField1Function, CancellationTokenSource cancellationToken = null)
        {
             return ContractHandler.SendRequestAndWaitForReceiptAsync(setField1Function, cancellationToken);
        }

        public Task<string> SetFieldRequestAsync(byte[] tableId, List<byte[]> keyTuple, byte fieldIndex, byte[] data, byte[] fieldLayout)
        {
            var setField1Function = new SetField1Function();
                setField1Function.TableId = tableId;
                setField1Function.KeyTuple = keyTuple;
                setField1Function.FieldIndex = fieldIndex;
                setField1Function.Data = data;
                setField1Function.FieldLayout = fieldLayout;
            
             return ContractHandler.SendRequestAsync(setField1Function);
        }

        public Task<TransactionReceipt> SetFieldRequestAndWaitForReceiptAsync(byte[] tableId, List<byte[]> keyTuple, byte fieldIndex, byte[] data, byte[] fieldLayout, CancellationTokenSource cancellationToken = null)
        {
            var setField1Function = new SetField1Function();
                setField1Function.TableId = tableId;
                setField1Function.KeyTuple = keyTuple;
                setField1Function.FieldIndex = fieldIndex;
                setField1Function.Data = data;
                setField1Function.FieldLayout = fieldLayout;
            
             return ContractHandler.SendRequestAndWaitForReceiptAsync(setField1Function, cancellationToken);
        }

        public Task<string> SetRecordRequestAsync(SetRecordFunction setRecordFunction)
        {
             return ContractHandler.SendRequestAsync(setRecordFunction);
        }

        public Task<TransactionReceipt> SetRecordRequestAndWaitForReceiptAsync(SetRecordFunction setRecordFunction, CancellationTokenSource cancellationToken = null)
        {
             return ContractHandler.SendRequestAndWaitForReceiptAsync(setRecordFunction, cancellationToken);
        }

        public Task<string> SetRecordRequestAsync(byte[] tableId, List<byte[]> keyTuple, byte[] staticData, byte[] encodedLengths, byte[] dynamicData)
        {
            var setRecordFunction = new SetRecordFunction();
                setRecordFunction.TableId = tableId;
                setRecordFunction.KeyTuple = keyTuple;
                setRecordFunction.StaticData = staticData;
                setRecordFunction.EncodedLengths = encodedLengths;
                setRecordFunction.DynamicData = dynamicData;
            
             return ContractHandler.SendRequestAsync(setRecordFunction);
        }

        public Task<TransactionReceipt> SetRecordRequestAndWaitForReceiptAsync(byte[] tableId, List<byte[]> keyTuple, byte[] staticData, byte[] encodedLengths, byte[] dynamicData, CancellationTokenSource cancellationToken = null)
        {
            var setRecordFunction = new SetRecordFunction();
                setRecordFunction.TableId = tableId;
                setRecordFunction.KeyTuple = keyTuple;
                setRecordFunction.StaticData = staticData;
                setRecordFunction.EncodedLengths = encodedLengths;
                setRecordFunction.DynamicData = dynamicData;
            
             return ContractHandler.SendRequestAndWaitForReceiptAsync(setRecordFunction, cancellationToken);
        }

        public Task<string> SetStaticFieldRequestAsync(SetStaticFieldFunction setStaticFieldFunction)
        {
             return ContractHandler.SendRequestAsync(setStaticFieldFunction);
        }

        public Task<TransactionReceipt> SetStaticFieldRequestAndWaitForReceiptAsync(SetStaticFieldFunction setStaticFieldFunction, CancellationTokenSource cancellationToken = null)
        {
             return ContractHandler.SendRequestAndWaitForReceiptAsync(setStaticFieldFunction, cancellationToken);
        }

        public Task<string> SetStaticFieldRequestAsync(byte[] tableId, List<byte[]> keyTuple, byte fieldIndex, byte[] data, byte[] fieldLayout)
        {
            var setStaticFieldFunction = new SetStaticFieldFunction();
                setStaticFieldFunction.TableId = tableId;
                setStaticFieldFunction.KeyTuple = keyTuple;
                setStaticFieldFunction.FieldIndex = fieldIndex;
                setStaticFieldFunction.Data = data;
                setStaticFieldFunction.FieldLayout = fieldLayout;
            
             return ContractHandler.SendRequestAsync(setStaticFieldFunction);
        }

        public Task<TransactionReceipt> SetStaticFieldRequestAndWaitForReceiptAsync(byte[] tableId, List<byte[]> keyTuple, byte fieldIndex, byte[] data, byte[] fieldLayout, CancellationTokenSource cancellationToken = null)
        {
            var setStaticFieldFunction = new SetStaticFieldFunction();
                setStaticFieldFunction.TableId = tableId;
                setStaticFieldFunction.KeyTuple = keyTuple;
                setStaticFieldFunction.FieldIndex = fieldIndex;
                setStaticFieldFunction.Data = data;
                setStaticFieldFunction.FieldLayout = fieldLayout;
            
             return ContractHandler.SendRequestAndWaitForReceiptAsync(setStaticFieldFunction, cancellationToken);
        }

        public Task<string> SetUnStakeFeeRequestAsync(SetUnStakeFeeFunction setUnStakeFeeFunction)
        {
             return ContractHandler.SendRequestAsync(setUnStakeFeeFunction);
        }

        public Task<TransactionReceipt> SetUnStakeFeeRequestAndWaitForReceiptAsync(SetUnStakeFeeFunction setUnStakeFeeFunction, CancellationTokenSource cancellationToken = null)
        {
             return ContractHandler.SendRequestAndWaitForReceiptAsync(setUnStakeFeeFunction, cancellationToken);
        }

        public Task<string> SetUnStakeFeeRequestAsync(BigInteger fee)
        {
            var setUnStakeFeeFunction = new SetUnStakeFeeFunction();
                setUnStakeFeeFunction.Fee = fee;
            
             return ContractHandler.SendRequestAsync(setUnStakeFeeFunction);
        }

        public Task<TransactionReceipt> SetUnStakeFeeRequestAndWaitForReceiptAsync(BigInteger fee, CancellationTokenSource cancellationToken = null)
        {
            var setUnStakeFeeFunction = new SetUnStakeFeeFunction();
                setUnStakeFeeFunction.Fee = fee;
            
             return ContractHandler.SendRequestAndWaitForReceiptAsync(setUnStakeFeeFunction, cancellationToken);
        }

        public Task<string> SpawnCapitalRequestAsync(SpawnCapitalFunction spawnCapitalFunction)
        {
             return ContractHandler.SendRequestAsync(spawnCapitalFunction);
        }

        public Task<TransactionReceipt> SpawnCapitalRequestAndWaitForReceiptAsync(SpawnCapitalFunction spawnCapitalFunction, CancellationTokenSource cancellationToken = null)
        {
             return ContractHandler.SendRequestAndWaitForReceiptAsync(spawnCapitalFunction, cancellationToken);
        }

        public Task<string> SpawnCapitalRequestAsync(ushort capitalId)
        {
            var spawnCapitalFunction = new SpawnCapitalFunction();
                spawnCapitalFunction.CapitalId = capitalId;
            
             return ContractHandler.SendRequestAsync(spawnCapitalFunction);
        }

        public Task<TransactionReceipt> SpawnCapitalRequestAndWaitForReceiptAsync(ushort capitalId, CancellationTokenSource cancellationToken = null)
        {
            var spawnCapitalFunction = new SpawnCapitalFunction();
                spawnCapitalFunction.CapitalId = capitalId;
            
             return ContractHandler.SendRequestAndWaitForReceiptAsync(spawnCapitalFunction, cancellationToken);
        }

        public Task<string> SpawnPlayerRequestAsync(SpawnPlayerFunction spawnPlayerFunction)
        {
             return ContractHandler.SendRequestAsync(spawnPlayerFunction);
        }

        public Task<string> SpawnPlayerRequestAsync()
        {
             return ContractHandler.SendRequestAsync<SpawnPlayerFunction>();
        }

        public Task<TransactionReceipt> SpawnPlayerRequestAndWaitForReceiptAsync(SpawnPlayerFunction spawnPlayerFunction, CancellationTokenSource cancellationToken = null)
        {
             return ContractHandler.SendRequestAndWaitForReceiptAsync(spawnPlayerFunction, cancellationToken);
        }

        public Task<TransactionReceipt> SpawnPlayerRequestAndWaitForReceiptAsync(CancellationTokenSource cancellationToken = null)
        {
             return ContractHandler.SendRequestAndWaitForReceiptAsync<SpawnPlayerFunction>(null, cancellationToken);
        }

        public Task<string> SpliceDynamicDataRequestAsync(SpliceDynamicDataFunction spliceDynamicDataFunction)
        {
             return ContractHandler.SendRequestAsync(spliceDynamicDataFunction);
        }

        public Task<TransactionReceipt> SpliceDynamicDataRequestAndWaitForReceiptAsync(SpliceDynamicDataFunction spliceDynamicDataFunction, CancellationTokenSource cancellationToken = null)
        {
             return ContractHandler.SendRequestAndWaitForReceiptAsync(spliceDynamicDataFunction, cancellationToken);
        }

        public Task<string> SpliceDynamicDataRequestAsync(byte[] tableId, List<byte[]> keyTuple, byte dynamicFieldIndex, ulong startWithinField, ulong deleteCount, byte[] data)
        {
            var spliceDynamicDataFunction = new SpliceDynamicDataFunction();
                spliceDynamicDataFunction.TableId = tableId;
                spliceDynamicDataFunction.KeyTuple = keyTuple;
                spliceDynamicDataFunction.DynamicFieldIndex = dynamicFieldIndex;
                spliceDynamicDataFunction.StartWithinField = startWithinField;
                spliceDynamicDataFunction.DeleteCount = deleteCount;
                spliceDynamicDataFunction.Data = data;
            
             return ContractHandler.SendRequestAsync(spliceDynamicDataFunction);
        }

        public Task<TransactionReceipt> SpliceDynamicDataRequestAndWaitForReceiptAsync(byte[] tableId, List<byte[]> keyTuple, byte dynamicFieldIndex, ulong startWithinField, ulong deleteCount, byte[] data, CancellationTokenSource cancellationToken = null)
        {
            var spliceDynamicDataFunction = new SpliceDynamicDataFunction();
                spliceDynamicDataFunction.TableId = tableId;
                spliceDynamicDataFunction.KeyTuple = keyTuple;
                spliceDynamicDataFunction.DynamicFieldIndex = dynamicFieldIndex;
                spliceDynamicDataFunction.StartWithinField = startWithinField;
                spliceDynamicDataFunction.DeleteCount = deleteCount;
                spliceDynamicDataFunction.Data = data;
            
             return ContractHandler.SendRequestAndWaitForReceiptAsync(spliceDynamicDataFunction, cancellationToken);
        }

        public Task<string> SpliceStaticDataRequestAsync(SpliceStaticDataFunction spliceStaticDataFunction)
        {
             return ContractHandler.SendRequestAsync(spliceStaticDataFunction);
        }

        public Task<TransactionReceipt> SpliceStaticDataRequestAndWaitForReceiptAsync(SpliceStaticDataFunction spliceStaticDataFunction, CancellationTokenSource cancellationToken = null)
        {
             return ContractHandler.SendRequestAndWaitForReceiptAsync(spliceStaticDataFunction, cancellationToken);
        }

        public Task<string> SpliceStaticDataRequestAsync(byte[] tableId, List<byte[]> keyTuple, ulong start, byte[] data)
        {
            var spliceStaticDataFunction = new SpliceStaticDataFunction();
                spliceStaticDataFunction.TableId = tableId;
                spliceStaticDataFunction.KeyTuple = keyTuple;
                spliceStaticDataFunction.Start = start;
                spliceStaticDataFunction.Data = data;
            
             return ContractHandler.SendRequestAsync(spliceStaticDataFunction);
        }

        public Task<TransactionReceipt> SpliceStaticDataRequestAndWaitForReceiptAsync(byte[] tableId, List<byte[]> keyTuple, ulong start, byte[] data, CancellationTokenSource cancellationToken = null)
        {
            var spliceStaticDataFunction = new SpliceStaticDataFunction();
                spliceStaticDataFunction.TableId = tableId;
                spliceStaticDataFunction.KeyTuple = keyTuple;
                spliceStaticDataFunction.Start = start;
                spliceStaticDataFunction.Data = data;
            
             return ContractHandler.SendRequestAndWaitForReceiptAsync(spliceStaticDataFunction, cancellationToken);
        }

        public Task<string> StakeTokenBRequestAsync(StakeTokenBFunction stakeTokenBFunction)
        {
             return ContractHandler.SendRequestAsync(stakeTokenBFunction);
        }

        public Task<TransactionReceipt> StakeTokenBRequestAndWaitForReceiptAsync(StakeTokenBFunction stakeTokenBFunction, CancellationTokenSource cancellationToken = null)
        {
             return ContractHandler.SendRequestAndWaitForReceiptAsync(stakeTokenBFunction, cancellationToken);
        }

        public Task<string> StakeTokenBRequestAsync(BigInteger amount)
        {
            var stakeTokenBFunction = new StakeTokenBFunction();
                stakeTokenBFunction.Amount = amount;
            
             return ContractHandler.SendRequestAsync(stakeTokenBFunction);
        }

        public Task<TransactionReceipt> StakeTokenBRequestAndWaitForReceiptAsync(BigInteger amount, CancellationTokenSource cancellationToken = null)
        {
            var stakeTokenBFunction = new StakeTokenBFunction();
                stakeTokenBFunction.Amount = amount;
            
             return ContractHandler.SendRequestAndWaitForReceiptAsync(stakeTokenBFunction, cancellationToken);
        }

        public Task<string> StakeTokenCRequestAsync(StakeTokenCFunction stakeTokenCFunction)
        {
             return ContractHandler.SendRequestAsync(stakeTokenCFunction);
        }

        public Task<TransactionReceipt> StakeTokenCRequestAndWaitForReceiptAsync(StakeTokenCFunction stakeTokenCFunction, CancellationTokenSource cancellationToken = null)
        {
             return ContractHandler.SendRequestAndWaitForReceiptAsync(stakeTokenCFunction, cancellationToken);
        }

        public Task<string> StakeTokenCRequestAsync(BigInteger amount)
        {
            var stakeTokenCFunction = new StakeTokenCFunction();
                stakeTokenCFunction.Amount = amount;
            
             return ContractHandler.SendRequestAsync(stakeTokenCFunction);
        }

        public Task<TransactionReceipt> StakeTokenCRequestAndWaitForReceiptAsync(BigInteger amount, CancellationTokenSource cancellationToken = null)
        {
            var stakeTokenCFunction = new StakeTokenCFunction();
                stakeTokenCFunction.Amount = amount;
            
             return ContractHandler.SendRequestAndWaitForReceiptAsync(stakeTokenCFunction, cancellationToken);
        }

        public Task<byte[]> StoreVersionQueryAsync(StoreVersionFunction storeVersionFunction, BlockParameter blockParameter = null)
        {
            return ContractHandler.QueryAsync<StoreVersionFunction, byte[]>(storeVersionFunction, blockParameter);
        }

        
        public Task<byte[]> StoreVersionQueryAsync(BlockParameter blockParameter = null)
        {
            return ContractHandler.QueryAsync<StoreVersionFunction, byte[]>(null, blockParameter);
        }

        public Task<string> TransferBalanceToAddressRequestAsync(TransferBalanceToAddressFunction transferBalanceToAddressFunction)
        {
             return ContractHandler.SendRequestAsync(transferBalanceToAddressFunction);
        }

        public Task<TransactionReceipt> TransferBalanceToAddressRequestAndWaitForReceiptAsync(TransferBalanceToAddressFunction transferBalanceToAddressFunction, CancellationTokenSource cancellationToken = null)
        {
             return ContractHandler.SendRequestAndWaitForReceiptAsync(transferBalanceToAddressFunction, cancellationToken);
        }

        public Task<string> TransferBalanceToAddressRequestAsync(byte[] fromNamespaceId, string toAddress, BigInteger amount)
        {
            var transferBalanceToAddressFunction = new TransferBalanceToAddressFunction();
                transferBalanceToAddressFunction.FromNamespaceId = fromNamespaceId;
                transferBalanceToAddressFunction.ToAddress = toAddress;
                transferBalanceToAddressFunction.Amount = amount;
            
             return ContractHandler.SendRequestAsync(transferBalanceToAddressFunction);
        }

        public Task<TransactionReceipt> TransferBalanceToAddressRequestAndWaitForReceiptAsync(byte[] fromNamespaceId, string toAddress, BigInteger amount, CancellationTokenSource cancellationToken = null)
        {
            var transferBalanceToAddressFunction = new TransferBalanceToAddressFunction();
                transferBalanceToAddressFunction.FromNamespaceId = fromNamespaceId;
                transferBalanceToAddressFunction.ToAddress = toAddress;
                transferBalanceToAddressFunction.Amount = amount;
            
             return ContractHandler.SendRequestAndWaitForReceiptAsync(transferBalanceToAddressFunction, cancellationToken);
        }

        public Task<string> TransferBalanceToNamespaceRequestAsync(TransferBalanceToNamespaceFunction transferBalanceToNamespaceFunction)
        {
             return ContractHandler.SendRequestAsync(transferBalanceToNamespaceFunction);
        }

        public Task<TransactionReceipt> TransferBalanceToNamespaceRequestAndWaitForReceiptAsync(TransferBalanceToNamespaceFunction transferBalanceToNamespaceFunction, CancellationTokenSource cancellationToken = null)
        {
             return ContractHandler.SendRequestAndWaitForReceiptAsync(transferBalanceToNamespaceFunction, cancellationToken);
        }

        public Task<string> TransferBalanceToNamespaceRequestAsync(byte[] fromNamespaceId, byte[] toNamespaceId, BigInteger amount)
        {
            var transferBalanceToNamespaceFunction = new TransferBalanceToNamespaceFunction();
                transferBalanceToNamespaceFunction.FromNamespaceId = fromNamespaceId;
                transferBalanceToNamespaceFunction.ToNamespaceId = toNamespaceId;
                transferBalanceToNamespaceFunction.Amount = amount;
            
             return ContractHandler.SendRequestAsync(transferBalanceToNamespaceFunction);
        }

        public Task<TransactionReceipt> TransferBalanceToNamespaceRequestAndWaitForReceiptAsync(byte[] fromNamespaceId, byte[] toNamespaceId, BigInteger amount, CancellationTokenSource cancellationToken = null)
        {
            var transferBalanceToNamespaceFunction = new TransferBalanceToNamespaceFunction();
                transferBalanceToNamespaceFunction.FromNamespaceId = fromNamespaceId;
                transferBalanceToNamespaceFunction.ToNamespaceId = toNamespaceId;
                transferBalanceToNamespaceFunction.Amount = amount;
            
             return ContractHandler.SendRequestAndWaitForReceiptAsync(transferBalanceToNamespaceFunction, cancellationToken);
        }

        public Task<string> TransferOwnershipRequestAsync(TransferOwnershipFunction transferOwnershipFunction)
        {
             return ContractHandler.SendRequestAsync(transferOwnershipFunction);
        }

        public Task<TransactionReceipt> TransferOwnershipRequestAndWaitForReceiptAsync(TransferOwnershipFunction transferOwnershipFunction, CancellationTokenSource cancellationToken = null)
        {
             return ContractHandler.SendRequestAndWaitForReceiptAsync(transferOwnershipFunction, cancellationToken);
        }

        public Task<string> TransferOwnershipRequestAsync(byte[] namespaceId, string newOwner)
        {
            var transferOwnershipFunction = new TransferOwnershipFunction();
                transferOwnershipFunction.NamespaceId = namespaceId;
                transferOwnershipFunction.NewOwner = newOwner;
            
             return ContractHandler.SendRequestAsync(transferOwnershipFunction);
        }

        public Task<TransactionReceipt> TransferOwnershipRequestAndWaitForReceiptAsync(byte[] namespaceId, string newOwner, CancellationTokenSource cancellationToken = null)
        {
            var transferOwnershipFunction = new TransferOwnershipFunction();
                transferOwnershipFunction.NamespaceId = namespaceId;
                transferOwnershipFunction.NewOwner = newOwner;
            
             return ContractHandler.SendRequestAndWaitForReceiptAsync(transferOwnershipFunction, cancellationToken);
        }

        public Task<string> UnStakeTokenBRequestAsync(UnStakeTokenBFunction unStakeTokenBFunction)
        {
             return ContractHandler.SendRequestAsync(unStakeTokenBFunction);
        }

        public Task<TransactionReceipt> UnStakeTokenBRequestAndWaitForReceiptAsync(UnStakeTokenBFunction unStakeTokenBFunction, CancellationTokenSource cancellationToken = null)
        {
             return ContractHandler.SendRequestAndWaitForReceiptAsync(unStakeTokenBFunction, cancellationToken);
        }

        public Task<string> UnStakeTokenBRequestAsync(string staker, BigInteger amount)
        {
            var unStakeTokenBFunction = new UnStakeTokenBFunction();
                unStakeTokenBFunction.Staker = staker;
                unStakeTokenBFunction.Amount = amount;
            
             return ContractHandler.SendRequestAsync(unStakeTokenBFunction);
        }

        public Task<TransactionReceipt> UnStakeTokenBRequestAndWaitForReceiptAsync(string staker, BigInteger amount, CancellationTokenSource cancellationToken = null)
        {
            var unStakeTokenBFunction = new UnStakeTokenBFunction();
                unStakeTokenBFunction.Staker = staker;
                unStakeTokenBFunction.Amount = amount;
            
             return ContractHandler.SendRequestAndWaitForReceiptAsync(unStakeTokenBFunction, cancellationToken);
        }

        public Task<string> UnregisterDelegationRequestAsync(UnregisterDelegationFunction unregisterDelegationFunction)
        {
             return ContractHandler.SendRequestAsync(unregisterDelegationFunction);
        }

        public Task<TransactionReceipt> UnregisterDelegationRequestAndWaitForReceiptAsync(UnregisterDelegationFunction unregisterDelegationFunction, CancellationTokenSource cancellationToken = null)
        {
             return ContractHandler.SendRequestAndWaitForReceiptAsync(unregisterDelegationFunction, cancellationToken);
        }

        public Task<string> UnregisterDelegationRequestAsync(string delegatee)
        {
            var unregisterDelegationFunction = new UnregisterDelegationFunction();
                unregisterDelegationFunction.Delegatee = delegatee;
            
             return ContractHandler.SendRequestAsync(unregisterDelegationFunction);
        }

        public Task<TransactionReceipt> UnregisterDelegationRequestAndWaitForReceiptAsync(string delegatee, CancellationTokenSource cancellationToken = null)
        {
            var unregisterDelegationFunction = new UnregisterDelegationFunction();
                unregisterDelegationFunction.Delegatee = delegatee;
            
             return ContractHandler.SendRequestAndWaitForReceiptAsync(unregisterDelegationFunction, cancellationToken);
        }

        public Task<string> UnregisterNamespaceDelegationRequestAsync(UnregisterNamespaceDelegationFunction unregisterNamespaceDelegationFunction)
        {
             return ContractHandler.SendRequestAsync(unregisterNamespaceDelegationFunction);
        }

        public Task<TransactionReceipt> UnregisterNamespaceDelegationRequestAndWaitForReceiptAsync(UnregisterNamespaceDelegationFunction unregisterNamespaceDelegationFunction, CancellationTokenSource cancellationToken = null)
        {
             return ContractHandler.SendRequestAndWaitForReceiptAsync(unregisterNamespaceDelegationFunction, cancellationToken);
        }

        public Task<string> UnregisterNamespaceDelegationRequestAsync(byte[] namespaceId)
        {
            var unregisterNamespaceDelegationFunction = new UnregisterNamespaceDelegationFunction();
                unregisterNamespaceDelegationFunction.NamespaceId = namespaceId;
            
             return ContractHandler.SendRequestAsync(unregisterNamespaceDelegationFunction);
        }

        public Task<TransactionReceipt> UnregisterNamespaceDelegationRequestAndWaitForReceiptAsync(byte[] namespaceId, CancellationTokenSource cancellationToken = null)
        {
            var unregisterNamespaceDelegationFunction = new UnregisterNamespaceDelegationFunction();
                unregisterNamespaceDelegationFunction.NamespaceId = namespaceId;
            
             return ContractHandler.SendRequestAndWaitForReceiptAsync(unregisterNamespaceDelegationFunction, cancellationToken);
        }

        public Task<string> UnregisterStoreHookRequestAsync(UnregisterStoreHookFunction unregisterStoreHookFunction)
        {
             return ContractHandler.SendRequestAsync(unregisterStoreHookFunction);
        }

        public Task<TransactionReceipt> UnregisterStoreHookRequestAndWaitForReceiptAsync(UnregisterStoreHookFunction unregisterStoreHookFunction, CancellationTokenSource cancellationToken = null)
        {
             return ContractHandler.SendRequestAndWaitForReceiptAsync(unregisterStoreHookFunction, cancellationToken);
        }

        public Task<string> UnregisterStoreHookRequestAsync(byte[] tableId, string hookAddress)
        {
            var unregisterStoreHookFunction = new UnregisterStoreHookFunction();
                unregisterStoreHookFunction.TableId = tableId;
                unregisterStoreHookFunction.HookAddress = hookAddress;
            
             return ContractHandler.SendRequestAsync(unregisterStoreHookFunction);
        }

        public Task<TransactionReceipt> UnregisterStoreHookRequestAndWaitForReceiptAsync(byte[] tableId, string hookAddress, CancellationTokenSource cancellationToken = null)
        {
            var unregisterStoreHookFunction = new UnregisterStoreHookFunction();
                unregisterStoreHookFunction.TableId = tableId;
                unregisterStoreHookFunction.HookAddress = hookAddress;
            
             return ContractHandler.SendRequestAndWaitForReceiptAsync(unregisterStoreHookFunction, cancellationToken);
        }

        public Task<string> UnregisterSystemHookRequestAsync(UnregisterSystemHookFunction unregisterSystemHookFunction)
        {
             return ContractHandler.SendRequestAsync(unregisterSystemHookFunction);
        }

        public Task<TransactionReceipt> UnregisterSystemHookRequestAndWaitForReceiptAsync(UnregisterSystemHookFunction unregisterSystemHookFunction, CancellationTokenSource cancellationToken = null)
        {
             return ContractHandler.SendRequestAndWaitForReceiptAsync(unregisterSystemHookFunction, cancellationToken);
        }

        public Task<string> UnregisterSystemHookRequestAsync(byte[] systemId, string hookAddress)
        {
            var unregisterSystemHookFunction = new UnregisterSystemHookFunction();
                unregisterSystemHookFunction.SystemId = systemId;
                unregisterSystemHookFunction.HookAddress = hookAddress;
            
             return ContractHandler.SendRequestAsync(unregisterSystemHookFunction);
        }

        public Task<TransactionReceipt> UnregisterSystemHookRequestAndWaitForReceiptAsync(byte[] systemId, string hookAddress, CancellationTokenSource cancellationToken = null)
        {
            var unregisterSystemHookFunction = new UnregisterSystemHookFunction();
                unregisterSystemHookFunction.SystemId = systemId;
                unregisterSystemHookFunction.HookAddress = hookAddress;
            
             return ContractHandler.SendRequestAndWaitForReceiptAsync(unregisterSystemHookFunction, cancellationToken);
        }

        public Task<byte[]> WorldVersionQueryAsync(WorldVersionFunction worldVersionFunction, BlockParameter blockParameter = null)
        {
            return ContractHandler.QueryAsync<WorldVersionFunction, byte[]>(worldVersionFunction, blockParameter);
        }

        
        public Task<byte[]> WorldVersionQueryAsync(BlockParameter blockParameter = null)
        {
            return ContractHandler.QueryAsync<WorldVersionFunction, byte[]>(null, blockParameter);
        }
    }
}
