using System.Collections;
using System.Collections.Generic;
using Nethereum.Web3;
using Nethereum.Web3.Accounts;
using UnityEngine;

public class SINUtils 
{
    public static async void DebugSINBalance()
    {
        var web3 = new Web3("https://rpc.garnet.qry.live");
        var pk = "0x832ccE0F0FAef94f242aDaD051e015BEd9Ffa7d4";
        var acc = new Account(pk);

        //var etherAmount = Web3.Covert.FromWei(balance.Value);
    }
}
