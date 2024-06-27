/* Autogenerated file. Manual edits will not be saved.*/

#nullable enable
using System;
using System.Linq;
using mud;
using UniRx;
using Property = System.Collections.Generic.Dictionary<string, object>;

namespace mudworld
{
    public class PlayerDetailTable : MUDTable
    {
        public class PlayerDetailTableUpdate : RecordUpdate
        {
            public uint? Gold;
            public uint? PreviousGold;
            public uint? Soldier;
            public uint? PreviousSoldier;
        }

        public readonly static string ID = "PlayerDetail";
        public static RxTable Table
        {
            get { return NetworkManager.Instance.ds.store[ID]; }
        }

        public override string GetTableId()
        {
            return ID;
        }

        public uint? Gold;
        public uint? Soldier;

        public override Type TableType()
        {
            return typeof(PlayerDetailTable);
        }

        public override Type TableUpdateType()
        {
            return typeof(PlayerDetailTableUpdate);
        }

        public override bool Equals(object? obj)
        {
            PlayerDetailTable other = (PlayerDetailTable)obj;

            if (other == null)
            {
                return false;
            }
            if (Gold != other.Gold)
            {
                return false;
            }
            if (Soldier != other.Soldier)
            {
                return false;
            }
            return true;
        }

        public override void SetValues(params object[] functionParameters)
        {
            Gold = (uint)functionParameters[0];

            Soldier = (uint)functionParameters[1];
        }

        public static IObservable<RecordUpdate> GetPlayerDetailTableUpdates()
        {
            PlayerDetailTable mudTable = new PlayerDetailTable();

            return NetworkManager.Instance.sync.onUpdate
                .Where(update => update.Table.Name == ID)
                .Select(recordUpdate =>
                {
                    return mudTable.RecordUpdateToTyped(recordUpdate);
                });
        }

        public override void PropertyToTable(Property property)
        {
            Gold = (uint)property["gold"];
            Soldier = (uint)property["soldier"];
        }

        public override RecordUpdate RecordUpdateToTyped(RecordUpdate recordUpdate)
        {
            var currentValue = recordUpdate.CurrentRecordValue as Property;
            var previousValue = recordUpdate.PreviousRecordValue as Property;
            uint? currentGoldTyped = null;
            uint? previousGoldTyped = null;

            if (currentValue != null && currentValue.ContainsKey("gold"))
            {
                currentGoldTyped = (uint)currentValue["gold"];
            }

            if (previousValue != null && previousValue.ContainsKey("gold"))
            {
                previousGoldTyped = (uint)previousValue["gold"];
            }
            uint? currentSoldierTyped = null;
            uint? previousSoldierTyped = null;

            if (currentValue != null && currentValue.ContainsKey("soldier"))
            {
                currentSoldierTyped = (uint)currentValue["soldier"];
            }

            if (previousValue != null && previousValue.ContainsKey("soldier"))
            {
                previousSoldierTyped = (uint)previousValue["soldier"];
            }

            return new PlayerDetailTableUpdate
            {
                Table = recordUpdate.Table,
                CurrentRecordValue = recordUpdate.CurrentRecordValue,
                PreviousRecordValue = recordUpdate.PreviousRecordValue,
                CurrentRecordKey = recordUpdate.CurrentRecordKey,
                PreviousRecordKey = recordUpdate.PreviousRecordKey,
                Type = recordUpdate.Type,
                Gold = currentGoldTyped,
                PreviousGold = previousGoldTyped,
                Soldier = currentSoldierTyped,
                PreviousSoldier = previousSoldierTyped,
            };
        }
    }
}
