using System;
using System.Collections;
using System.Collections.Generic;
using System.Numerics;
using JetBrains.Annotations;
using mud;
using mudworld;
using UnityEngine;

public class ArmyComponent : MUDComponent
{
    [CanBeNull] public string Owner;
    public uint? Id;
    public BigInteger? Infantry;
    public BigInteger? CavalryA;
    public BigInteger? CavalryB;
    public BigInteger? CavalryC;

    public uint? Destination;
    
    protected override void UpdateComponent(MUDTable table, UpdateInfo info)
    {
        var update = (ArmyTable)table;
        Infantry = update.Infantry;
        CavalryA = update.CavalryA;
        CavalryB = update.CavalryB;
        CavalryC = update.CavalryC;

        Destination = update.Destination;
        Id = update.Id;
        Owner = update.Owner;

        var account = NetworkManager.ShortenKey(Owner);
        var pos = MapDrawer.inst.GetTilePosById((int)Destination.Value);
        Debug.Log(">>>>>> Destination : " + Destination.Value);
        var p = GetComponent<Player>();
        p.Stand(pos);
        Debug.Log("Got Army : " + Owner + " Id is" + Id + " Account: " + account);
    }
}
