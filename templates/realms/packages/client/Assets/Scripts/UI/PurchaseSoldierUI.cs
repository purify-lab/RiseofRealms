using System;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;

public class PurchaseSoldierUI : MonoBehaviour
{
    public static PurchaseSoldierUI inst;

    public Button buyBtn;
    public Button CloseBtn;

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
        Debug.Log("OnBuy...");
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
