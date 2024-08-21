using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;

public class ArmyPage : MonoBehaviour
{
    public Button CloseBtn;
    public void Open()
    {
        gameObject.SetActive(true);
    }

    public void Close()
    {
        gameObject.SetActive(false);
    }
    
    // Start is called before the first frame update
    void Start()
    {
        CloseBtn.onClick.AddListener(Close);
    }

    // Update is called once per frame
    void Update()
    {
        
    }
}
