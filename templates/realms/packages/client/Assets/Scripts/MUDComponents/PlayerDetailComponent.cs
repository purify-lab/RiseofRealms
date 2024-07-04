using System.Collections;
using System.Collections.Generic;
using mud;
using mudworld;
using UnityEngine;

public class PlayerDetailComponent : MUDComponent 
{
    protected override void UpdateComponent(MUDTable table, UpdateInfo info)
    {
        PlayerDetailTable update = (PlayerDetailTable)table;
        Debug.Log(">>> PDT : " + info.UpdateType);
        Debug.Log($" >>>> PDT: + {update.CavalryA} :::  {update.Infantry}");
        var soldier = update.CavalryA + update.CavalryB + update.CavalryC + update.Infantry;
    }
}
