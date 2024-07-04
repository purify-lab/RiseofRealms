/* Autogenerated file. Manual edits will not be saved.*/

#nullable enable
using System;
using System.Linq;
using mud;
using UniRx;
using Property = System.Collections.Generic.Dictionary<string, object>;

namespace mudworld
{
    public class BattleReportTable : MUDTable
    {
        public class BattleReportTableUpdate : RecordUpdate
        {
            public uint? CapitalId;
            public uint? PreviousCapitalId;
            public uint? Timestamp;
            public uint? PreviousTimestamp;
            public string? Attacker;
            public string? PreviousAttacker;
            public string? Defender;
            public string? PreviousDefender;
            public bool? AttackWin;
            public bool? PreviousAttackWin;
            public System.Numerics.BigInteger[]? Losses;
            public System.Numerics.BigInteger[]? PreviousLosses;
        }

        public readonly static string ID = "BattleReport";
        public static RxTable Table
        {
            get { return NetworkManager.Instance.ds.store[ID]; }
        }

        public override string GetTableId()
        {
            return ID;
        }

        public uint? CapitalId;
        public uint? Timestamp;
        public string? Attacker;
        public string? Defender;
        public bool? AttackWin;
        public System.Numerics.BigInteger[]? Losses;

        public override Type TableType()
        {
            return typeof(BattleReportTable);
        }

        public override Type TableUpdateType()
        {
            return typeof(BattleReportTableUpdate);
        }

        public override bool Equals(object? obj)
        {
            BattleReportTable other = (BattleReportTable)obj;

            if (other == null)
            {
                return false;
            }
            if (CapitalId != other.CapitalId)
            {
                return false;
            }
            if (Timestamp != other.Timestamp)
            {
                return false;
            }
            if (Attacker != other.Attacker)
            {
                return false;
            }
            if (Defender != other.Defender)
            {
                return false;
            }
            if (AttackWin != other.AttackWin)
            {
                return false;
            }
            if (Losses != other.Losses)
            {
                return false;
            }
            return true;
        }

        public override void SetValues(params object[] functionParameters)
        {
            CapitalId = (uint)functionParameters[0];

            Timestamp = (uint)functionParameters[1];

            Attacker = (string)functionParameters[2];

            Defender = (string)functionParameters[3];

            AttackWin = (bool)functionParameters[4];

            Losses = (System.Numerics.BigInteger[])functionParameters[5];
        }

        public static IObservable<RecordUpdate> GetBattleReportTableUpdates()
        {
            BattleReportTable mudTable = new BattleReportTable();

            return NetworkManager.Instance.sync.onUpdate
                .Where(update => update.Table.Name == ID)
                .Select(recordUpdate =>
                {
                    return mudTable.RecordUpdateToTyped(recordUpdate);
                });
        }

        public override void PropertyToTable(Property property)
        {
            CapitalId = (uint)property["capitalId"];
            Timestamp = (uint)property["timestamp"];
            Attacker = (string)property["attacker"];
            Defender = (string)property["defender"];
            AttackWin = (bool)property["attackWin"];
            Losses = ((object[])property["losses"]).Cast<System.Numerics.BigInteger>().ToArray();
        }

        public override RecordUpdate RecordUpdateToTyped(RecordUpdate recordUpdate)
        {
            var currentValue = recordUpdate.CurrentRecordValue as Property;
            var previousValue = recordUpdate.PreviousRecordValue as Property;
            uint? currentCapitalIdTyped = null;
            uint? previousCapitalIdTyped = null;

            if (currentValue != null && currentValue.ContainsKey("capitalid"))
            {
                currentCapitalIdTyped = (uint)currentValue["capitalid"];
            }

            if (previousValue != null && previousValue.ContainsKey("capitalid"))
            {
                previousCapitalIdTyped = (uint)previousValue["capitalid"];
            }
            uint? currentTimestampTyped = null;
            uint? previousTimestampTyped = null;

            if (currentValue != null && currentValue.ContainsKey("timestamp"))
            {
                currentTimestampTyped = (uint)currentValue["timestamp"];
            }

            if (previousValue != null && previousValue.ContainsKey("timestamp"))
            {
                previousTimestampTyped = (uint)previousValue["timestamp"];
            }
            string? currentAttackerTyped = null;
            string? previousAttackerTyped = null;

            if (currentValue != null && currentValue.ContainsKey("attacker"))
            {
                currentAttackerTyped = (string)currentValue["attacker"];
            }

            if (previousValue != null && previousValue.ContainsKey("attacker"))
            {
                previousAttackerTyped = (string)previousValue["attacker"];
            }
            string? currentDefenderTyped = null;
            string? previousDefenderTyped = null;

            if (currentValue != null && currentValue.ContainsKey("defender"))
            {
                currentDefenderTyped = (string)currentValue["defender"];
            }

            if (previousValue != null && previousValue.ContainsKey("defender"))
            {
                previousDefenderTyped = (string)previousValue["defender"];
            }
            bool? currentAttackWinTyped = null;
            bool? previousAttackWinTyped = null;

            if (currentValue != null && currentValue.ContainsKey("attackwin"))
            {
                currentAttackWinTyped = (bool)currentValue["attackwin"];
            }

            if (previousValue != null && previousValue.ContainsKey("attackwin"))
            {
                previousAttackWinTyped = (bool)previousValue["attackwin"];
            }
            System.Numerics.BigInteger[]? currentLossesTyped = null;
            System.Numerics.BigInteger[]? previousLossesTyped = null;

            if (currentValue != null && currentValue.ContainsKey("losses"))
            {
                currentLossesTyped = ((object[])currentValue["losses"])
                    .Cast<System.Numerics.BigInteger>()
                    .ToArray();
            }

            if (previousValue != null && previousValue.ContainsKey("losses"))
            {
                previousLossesTyped = ((object[])previousValue["losses"])
                    .Cast<System.Numerics.BigInteger>()
                    .ToArray();
            }

            return new BattleReportTableUpdate
            {
                Table = recordUpdate.Table,
                CurrentRecordValue = recordUpdate.CurrentRecordValue,
                PreviousRecordValue = recordUpdate.PreviousRecordValue,
                CurrentRecordKey = recordUpdate.CurrentRecordKey,
                PreviousRecordKey = recordUpdate.PreviousRecordKey,
                Type = recordUpdate.Type,
                CapitalId = currentCapitalIdTyped,
                PreviousCapitalId = previousCapitalIdTyped,
                Timestamp = currentTimestampTyped,
                PreviousTimestamp = previousTimestampTyped,
                Attacker = currentAttackerTyped,
                PreviousAttacker = previousAttackerTyped,
                Defender = currentDefenderTyped,
                PreviousDefender = previousDefenderTyped,
                AttackWin = currentAttackWinTyped,
                PreviousAttackWin = previousAttackWinTyped,
                Losses = currentLossesTyped,
                PreviousLosses = previousLossesTyped,
            };
        }
    }
}
