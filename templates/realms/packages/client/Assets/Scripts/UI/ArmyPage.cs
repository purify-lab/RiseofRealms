using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;

public class ArmyPage : MonoBehaviour
{
    public Button CloseBtn;
    public GameObject armyItems;
    public GameObject gridObject;
    public void Open()
    {
        gameObject.SetActive(true);
        for (int i = 0; i < gridObject.transform.childCount; i++)
        {
            DestroyImmediate(gridObject.transform.GetChild(i));
        }

        var myarmy = ArmyMgr.Inst.GetMyArmy();
        foreach (var a in myarmy.Values)
        {
            var item = GameObject.Instantiate(armyItems, gridObject.transform);
            var armyItemComp = item.GetComponent<ArmyItem>();
            var pos = MapDrawer.inst.cellDics[(int)a.Destination.Value];
            armyItemComp.SetCityCoords(pos.pos);
        }
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
