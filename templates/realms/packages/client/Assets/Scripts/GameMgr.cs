using System.Collections;
using System.Collections.Generic;
using mudworld;
using UnityEngine;

public class GameMgr : Singleton<GameMgr>
{
    public Dictionary<Vector3Int, CapitalTable> cities;

    public override void Init()
    {
        base.Init();
        cities = new();
    }
}
