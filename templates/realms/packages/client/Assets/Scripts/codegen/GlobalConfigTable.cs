/* Autogenerated file. Manual edits will not be saved.*/

#nullable enable
using System;
using System.Linq;
using mud;
using UniRx;
using Property = System.Collections.Generic.Dictionary<string, object>;

namespace mudworld
{
    public class GlobalConfigTable : MUDTable
    {
        public class GlobalConfigTableUpdate : RecordUpdate
        {
            public System.Numerics.BigInteger? UnStakeFee;
            public System.Numerics.BigInteger? PreviousUnStakeFee;
        }

        public readonly static string ID = "GlobalConfig";
        public static RxTable Table
        {
            get { return NetworkManager.Instance.ds.store[ID]; }
        }

        public override string GetTableId()
        {
            return ID;
        }

        public System.Numerics.BigInteger? UnStakeFee;

        public override Type TableType()
        {
            return typeof(GlobalConfigTable);
        }

        public override Type TableUpdateType()
        {
            return typeof(GlobalConfigTableUpdate);
        }

        public override bool Equals(object? obj)
        {
            GlobalConfigTable other = (GlobalConfigTable)obj;

            if (other == null)
            {
                return false;
            }
            if (UnStakeFee != other.UnStakeFee)
            {
                return false;
            }
            return true;
        }

        public override void SetValues(params object[] functionParameters)
        {
            UnStakeFee = (System.Numerics.BigInteger)functionParameters[0];
        }

        public static IObservable<RecordUpdate> GetGlobalConfigTableUpdates()
        {
            GlobalConfigTable mudTable = new GlobalConfigTable();

            return NetworkManager.Instance.sync.onUpdate
                .Where(update => update.Table.Name == ID)
                .Select(recordUpdate =>
                {
                    return mudTable.RecordUpdateToTyped(recordUpdate);
                });
        }

        public override void PropertyToTable(Property property)
        {
            UnStakeFee = (System.Numerics.BigInteger)property["unStakeFee"];
        }

        public override RecordUpdate RecordUpdateToTyped(RecordUpdate recordUpdate)
        {
            var currentValue = recordUpdate.CurrentRecordValue as Property;
            var previousValue = recordUpdate.PreviousRecordValue as Property;
            System.Numerics.BigInteger? currentUnStakeFeeTyped = null;
            System.Numerics.BigInteger? previousUnStakeFeeTyped = null;

            if (currentValue != null && currentValue.ContainsKey("unstakefee"))
            {
                currentUnStakeFeeTyped = (System.Numerics.BigInteger)currentValue["unstakefee"];
            }

            if (previousValue != null && previousValue.ContainsKey("unstakefee"))
            {
                previousUnStakeFeeTyped = (System.Numerics.BigInteger)previousValue["unstakefee"];
            }

            return new GlobalConfigTableUpdate
            {
                Table = recordUpdate.Table,
                CurrentRecordValue = recordUpdate.CurrentRecordValue,
                PreviousRecordValue = recordUpdate.PreviousRecordValue,
                CurrentRecordKey = recordUpdate.CurrentRecordKey,
                PreviousRecordKey = recordUpdate.PreviousRecordKey,
                Type = recordUpdate.Type,
                UnStakeFee = currentUnStakeFeeTyped,
                PreviousUnStakeFee = previousUnStakeFeeTyped,
            };
        }
    }
}