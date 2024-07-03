using System.Collections;
using System.Collections.Generic;
using mud;
using UnityEngine;
public class BuildingMgr : Singleton<BuildingMgr>

{
    public bool isPlacing;
    public GameObject building;

    public void StartToPlacing(GameObject go)
    {
        isPlacing = true;
        building = GameObject.Instantiate(go);
        MainPageUI.inst.state = GameState.PlaceTile;
    }

    public void EndPlace()
    {
        isPlacing = false;
    }
}
