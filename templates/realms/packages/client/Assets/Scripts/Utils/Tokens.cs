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

}
