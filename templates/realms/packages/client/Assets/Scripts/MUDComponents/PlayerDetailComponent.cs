using System.Collections;
using System.Collections.Generic;
using System.Numerics;
using mud;
using mudworld;
using UnityEngine;

public class PlayerDetailComponent : MUDComponent
{
    public static BigInteger infantryCount;
    public static BigInteger CavalryACout;
    public static BigInteger CavalryBCout;
    public static BigInteger CavalryCCout;
    
    protected override void UpdateComponent(MUDTable table, UpdateInfo info)
    {
        PlayerDetailTable update = (PlayerDetailTable)table;
        Debug.Log(">>> PDT : " + info.UpdateType);
        Debug.Log($" >>>> PDT: + {update.CavalryA} :::  {update.Infantry}");
        var soldier = update.CavalryA + update.CavalryB + update.CavalryC + update.Infantry;

        infantryCount = update.Infantry.Value;
        CavalryACout = update.CavalryA.Value;
        CavalryBCout = update.CavalryB.Value;
        CavalryCCout = update.CavalryC.Value;

    }
}
