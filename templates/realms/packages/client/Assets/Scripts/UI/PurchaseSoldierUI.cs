using System;
using System.Collections;
using System.Collections.Generic;
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

    void OnBuy()
    {
        if (!InpInfantryANum.text.IsNullOrEmpty())
        {
        }
        
        if (!InpCavalryANum.text.IsNullOrEmpty())
        {
        }
        
        Debug.Log("OnBuy..." + InpInfantryANum.text + " : " + InpCavalryANum.text);
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
