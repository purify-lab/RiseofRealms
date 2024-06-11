using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class World : Singleton<World>
{
    /*
    public List<Vector2Int> FindPath(Vector2Int from, Vector2Int to)
    {
        var start = from;
        
        var open = new Dictionary<Vector2Int, float>();
        var closed = new Dictionary<Vector2Int, float>();
        var path = new Dictionary<Vector2Int, Vector2Int>();

        open.Add(start, 0);

        while (open.Count != 0)
        {
            var minDis = float.MaxValue;
            Vector2Int nowPos = Vector2Int.zero;
            float cost = 0;
            foreach (var k in open.Keys)
            {
                var nowDis = open[k];
                var totalDis = nowDis + Vector2Int.Distance(k, to);
                if (minDis > totalDis)
                {
                    minDis = totalDis;
                    nowPos = k;
                    cost = totalDis;
                }
            }
            closed.Add(nowPos, cost);
            open.Remove(nowPos);

            var nearby = HexTileUtils.GetNearbyTiles(nowPos);
            for (int i = 0; i < nearby.Count; i++)
            {
                var nextPos = nearby[i];
                if (!tileDic.ContainsKey(nextPos) || !tileDic[nextPos].Standable())
                {
                    continue;
                }
                if (closed.ContainsKey(nextPos))
                {
                    continue;
                }

                if (!open.ContainsKey(nextPos))
                {
                    path[nextPos] = nowPos;
                    open.Add(nextPos, closed[nowPos] + Vector2Int.Distance(nextPos, to));
                }

                if (nextPos == to)
                {
                    var reverse = nextPos;
                    var finalPath = new List<Vector2Int>();
                    while (reverse != from)
                    {
                        reverse = path[reverse];
                        if (reverse != from)
                        {
                            finalPath.Add(reverse);
                        }
                    }
                    
                    finalPath.Reverse();
                    finalPath.Add(to);

                    for (int ifpindex = 0; ifpindex < finalPath.Count; ifpindex++)
                    {
                        Debug.Log("Path: " + finalPath[ifpindex]);
                    }

                    return finalPath;
                }
            }
        }

        return null;
    }
    */
}
