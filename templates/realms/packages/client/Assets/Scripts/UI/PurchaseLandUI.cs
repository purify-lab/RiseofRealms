using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;

public class PurchaseLandUI : MonoBehaviour
{
    public Button CloseBtn;
    public Text coordsText;
    public Text PriceText;
    public Button BuyBtn;
    
    // Start is called before the first frame update
    void Start()
    {
        CloseBtn.onClick.AddListener(onCloseBtnClick);
        BuyBtn.onClick.AddListener(onBuyBtnClick);
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
