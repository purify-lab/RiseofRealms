using System.Collections;
using System.Collections.Generic;
using System.Numerics;
using Nethereum.ABI.FunctionEncoding.Attributes;
using UnityEngine;
using Nethereum.Accounts;
using Nethereum.Contracts;
using Nethereum.Web3.Accounts;

[Function("balanceOf", "uint256")]
public class BalanceOfFunction : FunctionMessage
{
    [Parameter("address", "_owner", 1)]
    public string Owner { get; set; }
}

public class Tokens : Singleton<Tokens>
{
    public string token_a_addr = "0x3d74e856d56492a76cE63904fFD8Dd97071ec87A";
    public string token_b_addr = "0x45AD5640957673B6585a5500D35740fbf698498b";
    public string token_c_addr = "0x358CD91cb9E587b5990E4BBa1C49Bc5FB384674e";

    public async void ReadTokenBalance(string contractAddress)
    {
        var account = new Account("0x832cce0f0faef94f242adad051e015bed9ffa7d4");
        var web3 = new Nethereum.Web3.Web3(account,"https://rpc.garnet.qry.live/");
        
        var balanceOfFunctionMessage = new BalanceOfFunction()
        {
            Owner = account.Address,
        };

        var balanceHandler = web3.Eth.GetContractQueryHandler<BalanceOfFunction>();
        var balance = await balanceHandler.QueryAsync<BigInteger>(contractAddress, balanceOfFunctionMessage);
        
        Debug.Log("Jerry Balance: " + balance);
    }

}
