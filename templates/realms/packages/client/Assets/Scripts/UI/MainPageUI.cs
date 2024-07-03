using System;
using System.Collections;
using System.Collections.Generic;
using IWorld.ContractDefinition;
using mudworld;
using UnityEngine;
using mud;
using UnityEngine.UI;

public enum GameState
{
    Game,
    SelectTile,
    PlaceTile,
}

public class MainPageUI : MonoBehaviour
{
    public GameState state;
    public Text AddressText;
    public Text CityText;
    public Text CoinText;
    public Text SoldierText;
    
    public Text TokenAText;
    public Text TokenBText;
    public Text TokenCText;

    public Button OnPurchaseBtn;

    public GameObject PurchaseLandPage;

    public static MainPageUI inst;

    private void Awake()
    {
        inst = this;
    }

    // Start is called before the first frame update
    async void Start()
    {
        state = GameState.Game;
        NetworkManager.OnInitialized += SpawnPlayer;
        var aToken = await Tokens.Inst.ReadTokenBalance(Tokens.Inst.token_a_addr);
        var bToken = await Tokens.Inst.ReadTokenBalance(Tokens.Inst.token_b_addr);
        var cToken = await Tokens.Inst.ReadTokenBalance(Tokens.Inst.token_c_addr);
        
        Debug.Log("Jerry aToken " + aToken);
        Debug.Log("Jerry bToken " + bToken);
        Debug.Log("Jerry cToken " + cToken);

        TokenAText.text = aToken.ToString();
        TokenBText.text = bToken.ToString();
        TokenCText.text = cToken.ToString();
        
        OnPurchaseBtn.onClick.AddListener(onclickPurchase);
    }
    
    public void onclickPurchase()
    {
        PurchaseLandPage.SetActive(true);
        Debug.Log("On Purchase");
    }
    
    void SpawnPlayer() {
        Debug.Log("SpawnPlayer Key : " + NetworkManager.LocalKey);
        PlayerTable player = MUDTable.GetTable<PlayerTable>(NetworkManager.LocalKey);
        if(player == null || player.Value == false) {
            SendSpawnTx();
        } else {
            Debug.Log("Player found");
        }
        

        AddressText.text = Utils.GetAddressText(NetworkManager.Account.Address) ;
        
        //SendBuySoldierTx();
        
        if (player != null && player.Value != false)
        {
            PlayerDetailTable pdt = MUDTable.GetTable<PlayerDetailTable>(NetworkManager.LocalKey);
            CoinText.text = pdt.Gold.ToString();
            var soldier = pdt.CavalryA + pdt.CavalryB + pdt.CavalryC + pdt.Infantry;
            SoldierText.text = soldier.ToString();
            
            var hasHealthAndPosition = new Query().In(CapitalTable.Table,
                new Condition[] { Condition.Has("owner", NetworkManager.LocalKey) });
            var recordsWithHealth = NetworkManager.Datastore.RunQuery(hasHealthAndPosition);
            foreach (var capital in recordsWithHealth)
            {
                var id = capital.Key;
                Debug.Log(">>>>>>>> Tile ID : " + id);
            }
        }
    }
    
    async void SendSpawnTx() {
        await TxManager.SendUntilPasses<SpawnPlayerFunction>();
    }
    
    async void SendBuySoldierTx() {
        Debug.Log("Buy Soldier: >>>>>>>>>>>>>>>");
        //await TxManager.SendUntilPasses<BuySoldierFunction>();
    }

    // Update is called once per frame
    void Update()
    {
        
        
    }
}
