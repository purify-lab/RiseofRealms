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
            public string? Attacker;
            public string? PreviousAttacker;
            public string? Defender;
            public string? PreviousDefender;
            public bool? Win;
            public bool? PreviousWin;
            public bool? AttackOrDefence;
            public bool? PreviousAttackOrDefence;
            public System.Numerics.BigInteger? LossInfantry;
            public System.Numerics.BigInteger? PreviousLossInfantry;
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

        public string? Attacker;
        public string? Defender;
        public bool? Win;
        public bool? AttackOrDefence;
        public System.Numerics.BigInteger? LossInfantry;

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
            if (Attacker != other.Attacker)
            {
                return false;
            }
            if (Defender != other.Defender)
            {
                return false;
            }
            if (Win != other.Win)
            {
                return false;
            }
            if (AttackOrDefence != other.AttackOrDefence)
            {
                return false;
            }
            if (LossInfantry != other.LossInfantry)
            {
                return false;
            }
            return true;
        }

        public override void SetValues(params object[] functionParameters)
        {
            Attacker = (string)functionParameters[0];

            Defender = (string)functionParameters[1];

            Win = (bool)functionParameters[2];

            AttackOrDefence = (bool)functionParameters[3];

            LossInfantry = (System.Numerics.BigInteger)functionParameters[4];
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
            Attacker = (string)property["attacker"];
            Defender = (string)property["defender"];
            Win = (bool)property["win"];
            AttackOrDefence = (bool)property["attackOrDefence"];
            LossInfantry = (System.Numerics.BigInteger)property["lossInfantry"];
        }

        public override RecordUpdate RecordUpdateToTyped(RecordUpdate recordUpdate)
        {
            var currentValue = recordUpdate.CurrentRecordValue as Property;
            var previousValue = recordUpdate.PreviousRecordValue as Property;
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
            bool? currentWinTyped = null;
            bool? previousWinTyped = null;

            if (currentValue != null && currentValue.ContainsKey("win"))
            {
                currentWinTyped = (bool)currentValue["win"];
            }

            if (previousValue != null && previousValue.ContainsKey("win"))
            {
                previousWinTyped = (bool)previousValue["win"];
            }
            bool? currentAttackOrDefenceTyped = null;
            bool? previousAttackOrDefenceTyped = null;

            if (currentValue != null && currentValue.ContainsKey("attackordefence"))
            {
                currentAttackOrDefenceTyped = (bool)currentValue["attackordefence"];
            }

            if (previousValue != null && previousValue.ContainsKey("attackordefence"))
            {
                previousAttackOrDefenceTyped = (bool)previousValue["attackordefence"];
            }
            System.Numerics.BigInteger? currentLossInfantryTyped = null;
            System.Numerics.BigInteger? previousLossInfantryTyped = null;

            if (currentValue != null && currentValue.ContainsKey("lossinfantry"))
            {
                currentLossInfantryTyped = (System.Numerics.BigInteger)currentValue["lossinfantry"];
            }

            if (previousValue != null && previousValue.ContainsKey("lossinfantry"))
            {
                previousLossInfantryTyped = (System.Numerics.BigInteger)
                    previousValue["lossinfantry"];
            }

            return new BattleReportTableUpdate
            {
                Table = recordUpdate.Table,
                CurrentRecordValue = recordUpdate.CurrentRecordValue,
                PreviousRecordValue = recordUpdate.PreviousRecordValue,
                CurrentRecordKey = recordUpdate.CurrentRecordKey,
                PreviousRecordKey = recordUpdate.PreviousRecordKey,
                Type = recordUpdate.Type,
                Attacker = currentAttackerTyped,
                PreviousAttacker = previousAttackerTyped,
                Defender = currentDefenderTyped,
                PreviousDefender = previousDefenderTyped,
                Win = currentWinTyped,
                PreviousWin = previousWinTyped,
                AttackOrDefence = currentAttackOrDefenceTyped,
                PreviousAttackOrDefence = previousAttackOrDefenceTyped,
                LossInfantry = currentLossInfantryTyped,
                PreviousLossInfantry = previousLossInfantryTyped,
            };
        }
    }
}
