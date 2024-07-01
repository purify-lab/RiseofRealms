using System;
using System.Collections;
using System.Collections.Generic;
using System.Numerics;
using Cysharp.Threading.Tasks;
using Nethereum.ABI.FunctionEncoding.Attributes;
using UnityEngine;
using Nethereum.Accounts;
using Nethereum.Contracts;
using Nethereum.Contracts.Standards.ERC20.TokenList;
using Nethereum.Util;
using Nethereum.Web3;
using Nethereum.Web3.Accounts;

//查询余额
[Function("balanceOf", "uint256")]
public class BalanceOfFunction : FunctionMessage
{
    [Parameter("address", "_owner", 1)]
    public string Owner { get; set; }
}

//转账
[Function("transfer", "bool")]
public class TransferFunction : FunctionMessage
{
    [Parameter("address", "_to", 1)]
    public string To { get; set; }

    [Parameter("uint256", "_value", 2)]
    public BigInteger TokenAmount { get; set; }
}

//授权
[Function("approve", "bool")]
public class ApproveFunction : FunctionMessage
{
    [Parameter("address", "_spender", 1)]
    public virtual string Spender { get; set; }

    [Parameter("uint256", "_value", 2)]
    public virtual BigInteger Value { get; set; }
}

//查询授权额度
[Function("allowed", "uint256")]
public class AllowedFunctionBase : FunctionMessage
{
    [Parameter("address", "", 1)]
    public virtual string Owner { get; set; }

    [Parameter("address", "", 2)]
    public virtual string Spender { get; set; }
}

public class Tokens : Singleton<Tokens>
{
    public string token_a_addr = "0x3d74e856d56492a76cE63904fFD8Dd97071ec87A";
    public string token_b_addr = "0x45AD5640957673B6585a5500D35740fbf698498b";
    public string token_c_addr = "0x358CD91cb9E587b5990E4BBa1C49Bc5FB384674e";


    /**
    * 读取代币余额
    * @param contractAddress 代币合约地址
    * @return 余额
    */
    public async UniTask<Decimal> ReadTokenBalance(string contractAddress)
    {
        var account = new Account("0x832cce0f0faef94f242adad051e015bed9ffa7d4");
        var web3 = new Nethereum.Web3.Web3(account,"https://rpc.garnet.qry.live/");
        
        var balanceOfFunctionMessage = new BalanceOfFunction()
        {
            Owner = account.Address,
        };

        var balanceHandler = web3.Eth.GetContractQueryHandler<BalanceOfFunction>();
        var balance = await balanceHandler.QueryAsync<BigInteger>(contractAddress, balanceOfFunctionMessage);
        var balanceInEther = Web3.Convert.FromWei(balance, UnitConversion.EthUnit.Ether);

        return balanceInEther;
    }

    /**
    * 转账代币
    * @param contractAddress 代币合约地址
    * @param toAddress 目标地址
    * @param amount 金额
    * @return 是否成功
    */
    public async UniTask<bool> TransferToken(string contractAddress, string toAddress, BigInteger amount)
    {
        var account = new Account("0x832cce0f0faef94f242adad051e015bed9ffa7d4");
        var web3 = new Nethereum.Web3.Web3(account,"https://rpc.garnet.qry.live/");

        var transferFunctionMessage = new TransferFunction()
        {
            To = toAddress,
            TokenAmount = amount
        };

        var transferHandler = web3.Eth.GetContractTransactionHandler<TransferFunction>();
        var transfer = await transferHandler.SendRequestAsync(contractAddress, transferFunctionMessage);

        return true;
    }

    /**
    * 授权代币
    * @param contractAddress 代币合约地址
    * @param spenderAddress 授权地址
    * @param amount 金额
    * @return 是否成功
    */
    public async UniTask<bool> ApproveToken(string contractAddress, string spenderAddress, BigInteger amount)
    {
        var account = new Account("0x832cce0f0faef94f242adad051e015bed9ffa7d4");
        var web3 = new Nethereum.Web3.Web3(account,"https://rpc.garnet.qry.live/");

        var approveFunctionMessage = new ApproveFunction()
        {
            Spender = spenderAddress,
            Value = amount
        };

        var approveHandler = web3.Eth.GetContractTransactionHandler<ApproveFunction>();
        var approve = await approveHandler.SendRequestAsync(contractAddress, approveFunctionMessage);

        return true;
    }

    /**
    * 读取代币授权额度
    * @param contractAddress 代币合约地址
    * @param ownerAddress 拥有者地址
    * @param spenderAddress 授权地址
    * @return 授权额度
    */
    public async UniTask<BigInteger> ReadTokenAllowance(string contractAddress, string ownerAddress, string spenderAddress)
    {
        var account = new Account("0x832cce0f0faef94f242adad051e015bed9ffa7d4");
        var web3 = new Nethereum.Web3.Web3(account,"https://rpc.garnet.qry.live/");

        var allowedFunctionMessage = new AllowedFunctionBase()
        {
            Owner = ownerAddress,
            Spender = spenderAddress
        };

        var allowedHandler = web3.Eth.GetContractQueryHandler<AllowedFunctionBase>();
        var allowed = await allowedHandler.QueryAsync<BigInteger>(contractAddress, allowedFunctionMessage);

        return allowed;
    }
}
