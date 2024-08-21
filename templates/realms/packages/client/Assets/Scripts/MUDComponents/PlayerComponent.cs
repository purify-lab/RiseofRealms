using System.Collections;
using System.Collections.Generic;
using IWorld.ContractDefinition;
using mud;
using mudworld;
using UnityEngine;

public class PlayerComponent : MUDComponent
{
    public static bool value;
    public static PlayerComponent me;
    
    protected override void UpdateComponent(MUDTable table, UpdateInfo info)
    {
        PlayerTable update = (PlayerTable)table;
        var player = MUDTable.GetTable<PlayerTable>(NetworkManager.LocalKey.ToLower());
        PlayerTable.Table.Entries.TryGetValue(NetworkManager.LocalKey.ToLower(), out RxRecord record);
        
        if (player.Equals(update))
        {
            me = this;
        }
    }
}
