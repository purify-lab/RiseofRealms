using System.Collections;
using System.Collections.Generic;
using mud;
using mudworld;
using UnityEngine;

public class CapitalComponent : MUDComponent
{
    public ushort id;
    
    protected override void UpdateComponent(MUDTable table, UpdateInfo info) {
        CapitalTable update = (CapitalTable)table;
        
        if(info.UpdateType == UpdateType.DeleteRecord) {
            //Position was deleted
            Entity.Toggle(false);
        }

        Debug.Log("Capital.... Update>>>>>>>>>" + update.Owner);

        //position = new Vector3((int)update.X, (int)update.Y, (int)update.Z);
        //transform.position = position;

    }
}
