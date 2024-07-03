/* Autogenerated file. Manual edits will not be saved.*/

#nullable enable
using System;
using System.Linq;
using mud;
using UniRx;
using Property = System.Collections.Generic.Dictionary<string, object>;

namespace mudworld
{
    public class PlayerTable : MUDTable
    {
        public class PlayerTableUpdate : RecordUpdate
        {
            public string? Id;
            public string? PreviousId;
            public bool? Value;
            public bool? PreviousValue;
        }

        public readonly static string ID = "Player";
        public static RxTable Table
        {
            get { return NetworkManager.Instance.ds.store[ID]; }
        }

        public override string GetTableId()
        {
            return ID;
        }

        public string? Id;
        public bool? Value;

        public override Type TableType()
        {
            return typeof(PlayerTable);
        }

        public override Type TableUpdateType()
        {
            return typeof(PlayerTableUpdate);
        }

        public override bool Equals(object? obj)
        {
            PlayerTable other = (PlayerTable)obj;

            if (other == null)
            {
                return false;
            }
            if (Id != other.Id)
            {
                return false;
            }
            if (Value != other.Value)
            {
                return false;
            }
            return true;
        }

        public override void SetValues(params object[] functionParameters)
        {
            Id = (string)functionParameters[0];

            Value = (bool)functionParameters[1];
        }

        public static IObservable<RecordUpdate> GetPlayerTableUpdates()
        {
            PlayerTable mudTable = new PlayerTable();

            return NetworkManager.Instance.sync.onUpdate
                .Where(update => update.Table.Name == ID)
                .Select(recordUpdate =>
                {
                    return mudTable.RecordUpdateToTyped(recordUpdate);
                });
        }

        public override void PropertyToTable(Property property)
        {
            Id = (string)property["id"];
            Value = (bool)property["value"];
        }

        public override RecordUpdate RecordUpdateToTyped(RecordUpdate recordUpdate)
        {
            var currentValue = recordUpdate.CurrentRecordValue as Property;
            var previousValue = recordUpdate.PreviousRecordValue as Property;
            string? currentIdTyped = null;
            string? previousIdTyped = null;

            if (currentValue != null && currentValue.ContainsKey("id"))
            {
                currentIdTyped = (string)currentValue["id"];
            }

            if (previousValue != null && previousValue.ContainsKey("id"))
            {
                previousIdTyped = (string)previousValue["id"];
            }
            bool? currentValueTyped = null;
            bool? previousValueTyped = null;

            if (currentValue != null && currentValue.ContainsKey("value"))
            {
                currentValueTyped = (bool)currentValue["value"];
            }

            if (previousValue != null && previousValue.ContainsKey("value"))
            {
                previousValueTyped = (bool)previousValue["value"];
            }

            return new PlayerTableUpdate
            {
                Table = recordUpdate.Table,
                CurrentRecordValue = recordUpdate.CurrentRecordValue,
                PreviousRecordValue = recordUpdate.PreviousRecordValue,
                CurrentRecordKey = recordUpdate.CurrentRecordKey,
                PreviousRecordKey = recordUpdate.PreviousRecordKey,
                Type = recordUpdate.Type,
                Id = currentIdTyped,
                PreviousId = previousIdTyped,
                Value = currentValueTyped,
                PreviousValue = previousValueTyped,
            };
        }
    }
}
