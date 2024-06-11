using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;

public class HUDPanel : MonoBehaviour
{
    public Button BuildBtn;

    public GameObject building;
    // Start is called before the first frame update
    void Start()
    {
        BuildBtn.onClick.AddListener(() =>
        {
            BuildingMgr.Inst.StartToPlacing(building);
        });
    }
}
