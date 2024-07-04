using System;
using System.Collections;
using System.Collections.Generic;
using IWorld.ContractDefinition;
using mud;
using UnityEngine;
using UnityEngine.UI;
using WebSocketSharp;

public class PurchaseSoldierUI : MonoBehaviour
{
    public static PurchaseSoldierUI inst;

    public Button buyBtn;
    public Button CloseBtn;

    public InputField InpInfantryANum;
    public InputField InpCavalryANum;

    public int buyInfantryANum;
    public int buyCavalryANum;

    public void Show()
    {
        gameObject.SetActive(true);
    }

    private void Awake()
    {
        inst = this;
    }

    void OnClose()
    {
        gameObject.SetActive(false);
    }

    async void OnComfirm(int code)
    {
        Debug.Log("ConfirmCode : " + code);
        Debug.Log("OnBuy..." + buyInfantryANum + " : " + buyCavalryANum);
        if (buyInfantryANum > 0)
        {
            await TxManager.SendUntilPasses<BuyInfantryFunction>(buyInfantryANum);
        }

        if (buyCavalryANum > 0)
        {
            await TxManager.SendUntilPasses<BuyCavalryAFunction>(buyCavalryANum);
        }
    }

    void OnBuy()
    {
        buyInfantryANum = 0;
        buyCavalryANum = 0;
        
        if (!InpInfantryANum.text.IsNullOrEmpty())
        {
            buyInfantryANum = int.Parse(InpInfantryANum.text);
        }
        
        if (!InpCavalryANum.text.IsNullOrEmpty())
        {
            buyCavalryANum = int.Parse(InpCavalryANum.text);
        }
        
        MsgBoxUI.inst.Show(OnComfirm);
    }

    // Start is called before the first frame update
    void Start()
    {
        buyBtn.onClick.AddListener(OnBuy);
        CloseBtn.onClick.AddListener(OnClose);
    }

    // Update is called once per frame
    void Update()
    {
        
    }
}
