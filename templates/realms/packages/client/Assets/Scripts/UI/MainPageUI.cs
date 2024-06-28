using System.Collections;
using System.Collections.Generic;
using IWorld.ContractDefinition;
using mudworld;
using UnityEngine;
using mud;

public class MainPageUI : MonoBehaviour
{
    
    // Start is called before the first frame update
    void Start()
    {
        NetworkManager.OnInitialized += SpawnPlayer;
        Tokens.Inst.ReadTokenBalance(Tokens.Inst.token_a_addr);
        Tokens.Inst.ReadTokenBalance(Tokens.Inst.token_b_addr);
        Tokens.Inst.ReadTokenBalance(Tokens.Inst.token_c_addr);
        
        
    }
    
    void SpawnPlayer() {
        Debug.Log("SpawnPlayer Key : " + NetworkManager.LocalKey);
        PlayerTable player = MUDTable.GetTable<PlayerTable>(NetworkManager.LocalKey);
        if(player == null || player.Value == false) {
            SendSpawnTx();
        } else {
            Debug.Log("Player found");
        }
        
        SendBuySoldierTx();
        
        if (player != null && player.Value != false)
        {
            PlayerDetailTable pdt = MUDTable.GetTable<PlayerDetailTable>(NetworkManager.LocalKey);
            Debug.Log("Jerry PDT:" + pdt.Gold + " : " + pdt.Soldier + " : ");
        }
    }
    
    async void SendSpawnTx() {
        await TxManager.SendUntilPasses<SpawnPlayerFunction>();
    }
    
    async void SendBuySoldierTx() {
        Debug.Log("Buy Soldier: >>>>>>>>>>>>>>>");
        await TxManager.SendUntilPasses<BuySoldierFunction>();
    }

    // Update is called once per frame
    void Update()
    {
        
        
    }
}
