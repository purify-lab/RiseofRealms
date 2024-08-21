using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class ArmyMgr : Singleton<ArmyMgr>
{
    private Dictionary<int, ArmyComponent> myArmy;

    public override void Init()
    {
        myArmy = new Dictionary<int, ArmyComponent>();
    }

    public void AddArmy(int id, ArmyComponent army)
    {
        myArmy.Add(id, army);
    }

    public Dictionary<int, ArmyComponent> GetMyArmy()
    {
        return myArmy;
    }

    public void Clear()
    {
        myArmy.Clear();
    }
}
