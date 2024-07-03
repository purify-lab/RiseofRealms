/* Autogenerated file. Manual edits will not be saved.*/

#nullable enable
using System;
using System.Linq;
using mud;
using UniRx;
using Property = System.Collections.Generic.Dictionary<string, object>;

namespace mudworld
{
    public class CapitalTable : MUDTable
    {
        public class CapitalTableUpdate : RecordUpdate
        {
            public uint? TileId;
            public uint? PreviousTileId;
            public string? Owner;
            public string? PreviousOwner;
            public string? Occupation;
            public string? PreviousOccupation;
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
            public System.Numerics.BigInteger? PledgedTokenB;
            public System.Numerics.BigInteger? PreviousPledgedTokenB;
            public System.Numerics.BigInteger? PledgedTokenC;
            public System.Numerics.BigInteger? PreviousPledgedTokenC;
        }

        public readonly static string ID = "Capital";
        public static RxTable Table
        {
            get { return NetworkManager.Instance.ds.store[ID]; }
        }

        public override string GetTableId()
        {
            return ID;
        }

        public uint? TileId;
        public string? Owner;
        public string? Occupation;
        public System.Numerics.BigInteger? Infantry;
        public System.Numerics.BigInteger? CavalryA;
        public System.Numerics.BigInteger? CavalryB;
        public System.Numerics.BigInteger? CavalryC;
        public System.Numerics.BigInteger? LastTime;
        public System.Numerics.BigInteger? PledgedTokenB;
        public System.Numerics.BigInteger? PledgedTokenC;

        public override Type TableType()
        {
            return typeof(CapitalTable);
        }

        public override Type TableUpdateType()
        {
            return typeof(CapitalTableUpdate);
        }

        public override bool Equals(object? obj)
        {
            CapitalTable other = (CapitalTable)obj;

            if (other == null)
            {
                return false;
            }
            if (TileId != other.TileId)
            {
                return false;
            }
            if (Owner != other.Owner)
            {
                return false;
            }
            if (Occupation != other.Occupation)
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
            if (PledgedTokenB != other.PledgedTokenB)
            {
                return false;
            }
            if (PledgedTokenC != other.PledgedTokenC)
            {
                return false;
            }
            return true;
        }

        public override void SetValues(params object[] functionParameters)
        {
            TileId = (uint)functionParameters[0];

            Owner = (string)functionParameters[1];

            Occupation = (string)functionParameters[2];

            Infantry = (System.Numerics.BigInteger)functionParameters[3];

            CavalryA = (System.Numerics.BigInteger)functionParameters[4];

            CavalryB = (System.Numerics.BigInteger)functionParameters[5];

            CavalryC = (System.Numerics.BigInteger)functionParameters[6];

            LastTime = (System.Numerics.BigInteger)functionParameters[7];

            PledgedTokenB = (System.Numerics.BigInteger)functionParameters[8];

            PledgedTokenC = (System.Numerics.BigInteger)functionParameters[9];
        }

        public static IObservable<RecordUpdate> GetCapitalTableUpdates()
        {
            CapitalTable mudTable = new CapitalTable();

            return NetworkManager.Instance.sync.onUpdate
                .Where(update => update.Table.Name == ID)
                .Select(recordUpdate =>
                {
                    return mudTable.RecordUpdateToTyped(recordUpdate);
                });
        }

        public override void PropertyToTable(Property property)
        {
            TileId = (uint)property["tileId"];
            Owner = (string)property["owner"];
            Occupation = (string)property["occupation"];
            Infantry = (System.Numerics.BigInteger)property["infantry"];
            CavalryA = (System.Numerics.BigInteger)property["cavalryA"];
            CavalryB = (System.Numerics.BigInteger)property["cavalryB"];
            CavalryC = (System.Numerics.BigInteger)property["cavalryC"];
            LastTime = (System.Numerics.BigInteger)property["lastTime"];
            PledgedTokenB = (System.Numerics.BigInteger)property["pledgedTokenB"];
            PledgedTokenC = (System.Numerics.BigInteger)property["pledgedTokenC"];
        }

        public override RecordUpdate RecordUpdateToTyped(RecordUpdate recordUpdate)
        {
            var currentValue = recordUpdate.CurrentRecordValue as Property;
            var previousValue = recordUpdate.PreviousRecordValue as Property;
            uint? currentTileIdTyped = null;
            uint? previousTileIdTyped = null;

            if (currentValue != null && currentValue.ContainsKey("tileid"))
            {
                currentTileIdTyped = (uint)currentValue["tileid"];
            }

            if (previousValue != null && previousValue.ContainsKey("tileid"))
            {
                previousTileIdTyped = (uint)previousValue["tileid"];
            }
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
            string? currentOccupationTyped = null;
            string? previousOccupationTyped = null;

            if (currentValue != null && currentValue.ContainsKey("occupation"))
            {
                currentOccupationTyped = (string)currentValue["occupation"];
            }

            if (previousValue != null && previousValue.ContainsKey("occupation"))
            {
                previousOccupationTyped = (string)previousValue["occupation"];
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
            System.Numerics.BigInteger? currentPledgedTokenBTyped = null;
            System.Numerics.BigInteger? previousPledgedTokenBTyped = null;

            if (currentValue != null && currentValue.ContainsKey("pledgedtokenb"))
            {
                currentPledgedTokenBTyped = (System.Numerics.BigInteger)
                    currentValue["pledgedtokenb"];
            }

            if (previousValue != null && previousValue.ContainsKey("pledgedtokenb"))
            {
                previousPledgedTokenBTyped = (System.Numerics.BigInteger)
                    previousValue["pledgedtokenb"];
            }
            System.Numerics.BigInteger? currentPledgedTokenCTyped = null;
            System.Numerics.BigInteger? previousPledgedTokenCTyped = null;

            if (currentValue != null && currentValue.ContainsKey("pledgedtokenc"))
            {
                currentPledgedTokenCTyped = (System.Numerics.BigInteger)
                    currentValue["pledgedtokenc"];
            }

            if (previousValue != null && previousValue.ContainsKey("pledgedtokenc"))
            {
                previousPledgedTokenCTyped = (System.Numerics.BigInteger)
                    previousValue["pledgedtokenc"];
            }

            return new CapitalTableUpdate
            {
                Table = recordUpdate.Table,
                CurrentRecordValue = recordUpdate.CurrentRecordValue,
                PreviousRecordValue = recordUpdate.PreviousRecordValue,
                CurrentRecordKey = recordUpdate.CurrentRecordKey,
                PreviousRecordKey = recordUpdate.PreviousRecordKey,
                Type = recordUpdate.Type,
                TileId = currentTileIdTyped,
                PreviousTileId = previousTileIdTyped,
                Owner = currentOwnerTyped,
                PreviousOwner = previousOwnerTyped,
                Occupation = currentOccupationTyped,
                PreviousOccupation = previousOccupationTyped,
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
                PledgedTokenB = currentPledgedTokenBTyped,
                PreviousPledgedTokenB = previousPledgedTokenBTyped,
                PledgedTokenC = currentPledgedTokenCTyped,
                PreviousPledgedTokenC = previousPledgedTokenCTyped,
            };
        }
    }
}
