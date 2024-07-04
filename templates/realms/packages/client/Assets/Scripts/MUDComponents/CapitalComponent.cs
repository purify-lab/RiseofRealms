using System.Collections;
using System.Collections.Generic;
using mud;
using mudworld;
using UnityEngine;

public class CapitalComponent : MUDComponent
{
    public ushort id;
    
    protected override void UpdateComponent(MUDTable table, UpdateInfo info)
    {
        CapitalTable update = (CapitalTable)table;
        
        if(info.UpdateType == UpdateType.DeleteRecord) {
            //Position was deleted
            Entity.Toggle(false);
        }

        Debug.Log("1 Capital.... Update>>>>>>>>>" + update.Owner + " : My : " + NetworkManager.LocalKey + "Tile ID " +
                  update.TileId);

        if (update.Owner.Equals(NetworkManager.LocalKey))
        {
            Debug.Log(">>>>>>>>>>> Found My Capital!");
            var cell = MapDrawer.inst.cellDics[(int)update.TileId];
            Debug.Log(">>> Cell: " + cell.pos);
            transform.position = MapDrawer.inst.GetSceneByCoords(cell.pos);
        }

        //position = new Vector3((int)update.X, (int)update.Y, (int)update.Z);
        //transform.position = position;

    }
}
