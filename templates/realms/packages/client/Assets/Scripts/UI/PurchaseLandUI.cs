using System;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;

public class PurchaseLandUI : MonoBehaviour
{
    public Button CloseBtn;
    public Button SelectBtn;
    public Text coordsText;
    public Text PriceText;
    public Button BuyBtn;
    
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
    }

    private void OnEnable()
    {
        //Debug.Log("On Purchase Tile: " + TapMgr.inst.tapPos);

        //coordsText.text = TapMgr.inst.tapPos.x + "," + TapMgr.inst.tapPos.y + "," + TapMgr.inst.tapPos.z;
    }

    void onBuyBtnClick()
    {
        Debug.Log("On Buy Click");
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
