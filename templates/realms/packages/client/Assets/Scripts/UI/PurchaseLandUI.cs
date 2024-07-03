using System;
using System.Collections;
using System.Collections.Generic;
using System.Numerics;
using IWorld.ContractDefinition;
using mud;
using UnityEngine;
using UnityEngine.UI;

public class PurchaseLandUI : MonoBehaviour
{
    public static PurchaseLandUI inst;
    public Button CloseBtn;
    public Button SelectBtn;
    public Text coordsText;
    public Text PriceText;
    public Button BuyBtn;
    public GameObject building;

    public ushort CurrentID;

    private void Awake()
    {
        inst = this;
    }

    public void Show(Vector3Int pos)
    {
        gameObject.SetActive(true);
        coordsText.text = "Coordinates: " + pos;
        CurrentID = (ushort)MapDrawer.inst.cellByPosDic[pos];
    }

    // Start is called before the first frame update
    void Start()
    {
        CloseBtn.onClick.AddListener(onCloseBtnClick);
        BuyBtn.onClick.AddListener(onBuyBtnClick);
        SelectBtn.onClick.AddListener(onClickSelect);
    }

    void onClickSelect()
    {
        gameObject.SetActive(false);
        BuildingMgr.Inst.isPlacing = true;
        MainPageUI.inst.state = GameState.SelectTile;
        
        BuildingMgr.Inst.StartToPlacing(building);
    }

    private void OnEnable()
    {
        //Debug.Log("On Purchase Tile: " + TapMgr.inst.tapPos);

        //coordsText.text = TapMgr.inst.tapPos.x + "," + TapMgr.inst.tapPos.y + "," + TapMgr.inst.tapPos.z;
    }

    async void onBuyBtnClick()
    {
        Debug.Log("On Buy Click:" + CurrentID);
        
        await TxManager.SendUntilPasses<SpawnCapitalFunction>(CurrentID, new BigInteger(500000000000000));
    }

    void onCloseBtnClick()
    {
        gameObject.SetActive(false);
    }

    // Update is called once per frame
    void Update()
    {
        
    }
}
