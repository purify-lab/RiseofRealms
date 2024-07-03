/* Autogenerated file. Manual edits will not be saved.*/

#nullable enable
using System;
using System.Linq;
using mud;
using UniRx;
using Property = System.Collections.Generic.Dictionary<string, object>;

namespace mudworld
{
    public class ArmyTable : MUDTable
    {
        public class ArmyTableUpdate : RecordUpdate
        {
            public string? Owner;
            public string? PreviousOwner;
            public uint? Id;
            public uint? PreviousId;
            public System.Numerics.BigInteger? Infantry;
            public System.Numerics.BigInteger? PreviousInfantry;
            public System.Numerics.BigInteger? CavalryA;
            public System.Numerics.BigInteger? PreviousCavalryA;
            public System.Numerics.BigInteger? CavalryB;
            public System.Numerics.BigInteger? PreviousCavalryB;
            public System.Numerics.BigInteger? CavalryC;
            public System.Numerics.BigInteger? PreviousCavalryC;
            public System.Numerics.BigInteger? LastTime;
            public System.Numerics.BigInteger? PreviousLastTime;
            public uint? Destination;
            public uint? PreviousDestination;
        }

        public readonly static string ID = "Army";
        public static RxTable Table
        {
            get { return NetworkManager.Instance.ds.store[ID]; }
        }

        public override string GetTableId()
        {
            return ID;
        }

        public string? Owner;
        public uint? Id;
        public System.Numerics.BigInteger? Infantry;
        public System.Numerics.BigInteger? CavalryA;
        public System.Numerics.BigInteger? CavalryB;
        public System.Numerics.BigInteger? CavalryC;
        public System.Numerics.BigInteger? LastTime;
        public uint? Destination;

        public override Type TableType()
        {
            return typeof(ArmyTable);
        }

        public override Type TableUpdateType()
        {
            return typeof(ArmyTableUpdate);
        }

        public override bool Equals(object? obj)
        {
            ArmyTable other = (ArmyTable)obj;

            if (other == null)
            {
                return false;
            }
            if (Owner != other.Owner)
            {
                return false;
            }
            if (Id != other.Id)
            {
                return false;
            }
            if (Infantry != other.Infantry)
            {
                return false;
            }
            if (CavalryA != other.CavalryA)
            {
                return false;
            }
            if (CavalryB != other.CavalryB)
            {
                return false;
            }
            if (CavalryC != other.CavalryC)
            {
                return false;
            }
            if (LastTime != other.LastTime)
            {
                return false;
            }
            if (Destination != other.Destination)
            {
                return false;
            }
            return true;
        }

        public override void SetValues(params object[] functionParameters)
        {
            Owner = (string)functionParameters[0];

            Id = (uint)functionParameters[1];

            Infantry = (System.Numerics.BigInteger)functionParameters[2];

            CavalryA = (System.Numerics.BigInteger)functionParameters[3];

            CavalryB = (System.Numerics.BigInteger)functionParameters[4];

            CavalryC = (System.Numerics.BigInteger)functionParameters[5];

            LastTime = (System.Numerics.BigInteger)functionParameters[6];

            Destination = (uint)functionParameters[7];
        }

        public static IObservable<RecordUpdate> GetArmyTableUpdates()
        {
            ArmyTable mudTable = new ArmyTable();

            return NetworkManager.Instance.sync.onUpdate
                .Where(update => update.Table.Name == ID)
                .Select(recordUpdate =>
                {
                    return mudTable.RecordUpdateToTyped(recordUpdate);
                });
        }

        public override void PropertyToTable(Property property)
        {
            Owner = (string)property["owner"];
            Id = (uint)property["id"];
            Infantry = (System.Numerics.BigInteger)property["infantry"];
            CavalryA = (System.Numerics.BigInteger)property["cavalryA"];
            CavalryB = (System.Numerics.BigInteger)property["cavalryB"];
            CavalryC = (System.Numerics.BigInteger)property["cavalryC"];
            LastTime = (System.Numerics.BigInteger)property["lastTime"];
            Destination = (uint)property["destination"];
        }

        public override RecordUpdate RecordUpdateToTyped(RecordUpdate recordUpdate)
        {
            var currentValue = recordUpdate.CurrentRecordValue as Property;
            var previousValue = recordUpdate.PreviousRecordValue as Property;
            string? currentOwnerTyped = null;
            string? previousOwnerTyped = null;

            if (currentValue != null && currentValue.ContainsKey("owner"))
            {
                currentOwnerTyped = (string)currentValue["owner"];
            }

            if (previousValue != null && previousValue.ContainsKey("owner"))
            {
                previousOwnerTyped = (string)previousValue["owner"];
            }
            uint? currentIdTyped = null;
            uint? previousIdTyped = null;

            if (currentValue != null && currentValue.ContainsKey("id"))
            {
                currentIdTyped = (uint)currentValue["id"];
            }

            if (previousValue != null && previousValue.ContainsKey("id"))
            {
                previousIdTyped = (uint)previousValue["id"];
            }
            System.Numerics.BigInteger? currentInfantryTyped = null;
            System.Numerics.BigInteger? previousInfantryTyped = null;

            if (currentValue != null && currentValue.ContainsKey("infantry"))
            {
                currentInfantryTyped = (System.Numerics.BigInteger)currentValue["infantry"];
            }

            if (previousValue != null && previousValue.ContainsKey("infantry"))
            {
                previousInfantryTyped = (System.Numerics.BigInteger)previousValue["infantry"];
            }
            System.Numerics.BigInteger? currentCavalryATyped = null;
            System.Numerics.BigInteger? previousCavalryATyped = null;

            if (currentValue != null && currentValue.ContainsKey("cavalrya"))
            {
                currentCavalryATyped = (System.Numerics.BigInteger)currentValue["cavalrya"];
            }

            if (previousValue != null && previousValue.ContainsKey("cavalrya"))
            {
                previousCavalryATyped = (System.Numerics.BigInteger)previousValue["cavalrya"];
            }
            System.Numerics.BigInteger? currentCavalryBTyped = null;
            System.Numerics.BigInteger? previousCavalryBTyped = null;

            if (currentValue != null && currentValue.ContainsKey("cavalryb"))
            {
                currentCavalryBTyped = (System.Numerics.BigInteger)currentValue["cavalryb"];
            }

            if (previousValue != null && previousValue.ContainsKey("cavalryb"))
            {
                previousCavalryBTyped = (System.Numerics.BigInteger)previousValue["cavalryb"];
            }
            System.Numerics.BigInteger? currentCavalryCTyped = null;
            System.Numerics.BigInteger? previousCavalryCTyped = null;

            if (currentValue != null && currentValue.ContainsKey("cavalryc"))
            {
                currentCavalryCTyped = (System.Numerics.BigInteger)currentValue["cavalryc"];
            }

            if (previousValue != null && previousValue.ContainsKey("cavalryc"))
            {
                previousCavalryCTyped = (System.Numerics.BigInteger)previousValue["cavalryc"];
            }
            System.Numerics.BigInteger? currentLastTimeTyped = null;
            System.Numerics.BigInteger? previousLastTimeTyped = null;

            if (currentValue != null && currentValue.ContainsKey("lasttime"))
            {
                currentLastTimeTyped = (System.Numerics.BigInteger)currentValue["lasttime"];
            }

            if (previousValue != null && previousValue.ContainsKey("lasttime"))
            {
                previousLastTimeTyped = (System.Numerics.BigInteger)previousValue["lasttime"];
            }
            uint? currentDestinationTyped = null;
            uint? previousDestinationTyped = null;

            if (currentValue != null && currentValue.ContainsKey("destination"))
            {
                currentDestinationTyped = (uint)currentValue["destination"];
            }

            if (previousValue != null && previousValue.ContainsKey("destination"))
            {
                previousDestinationTyped = (uint)previousValue["destination"];
            }

            return new ArmyTableUpdate
            {
                Table = recordUpdate.Table,
                CurrentRecordValue = recordUpdate.CurrentRecordValue,
                PreviousRecordValue = recordUpdate.PreviousRecordValue,
                CurrentRecordKey = recordUpdate.CurrentRecordKey,
                PreviousRecordKey = recordUpdate.PreviousRecordKey,
                Type = recordUpdate.Type,
                Owner = currentOwnerTyped,
                PreviousOwner = previousOwnerTyped,
                Id = currentIdTyped,
                PreviousId = previousIdTyped,
                Infantry = currentInfantryTyped,
                PreviousInfantry = previousInfantryTyped,
                CavalryA = currentCavalryATyped,
                PreviousCavalryA = previousCavalryATyped,
                CavalryB = currentCavalryBTyped,
                PreviousCavalryB = previousCavalryBTyped,
                CavalryC = currentCavalryCTyped,
                PreviousCavalryC = previousCavalryCTyped,
                LastTime = currentLastTimeTyped,
                PreviousLastTime = previousLastTimeTyped,
                Destination = currentDestinationTyped,
                PreviousDestination = previousDestinationTyped,
            };
        }
    }
}
