using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;

public class SelectArmy1Page : MonoBehaviour
{
    public Vector3Int dest_pos;
    
    public CoordsText coordsText;
    
    //派遣士兵
    public InputField WarriorNum;
    
    //派遣骑兵
    public InputField CavalryNum;

    //进攻按钮
    public Button AtkButton;

    //还剩下多少士兵
    public Text WarriorLeft;
    //还剩下多少骑兵
    public Text CavalryLeft;

    public void Open(Vector3Int pos)
    {
        SetCoords(pos);
        gameObject.SetActive(true);
    }
    
    // Start is called before the first frame update
    void Start()
    {
        if (CavalryLeft != null)
        {
            CavalryLeft.text = PlayerDetailComponent.CavalryACout.ToString();
        }

        if (WarriorLeft != null)
        {
            WarriorLeft.text = PlayerDetailComponent.infantryCount.ToString();
        }
        
        AtkButton.onClick.AddListener(onAttack);
    }

    void onAttack()
    {
        gameObject.SetActive(false);
    }

    public void SetCoords(Vector3Int pos)
    {
        dest_pos = pos;
        coordsText.SetCoords(pos);
    }

    // Update is called once per frame
    void Update()
    {
        
    }
}
