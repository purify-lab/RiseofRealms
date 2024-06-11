using System;
using System.Collections;
using System.Collections.Generic;
using System.Linq;
using System.Resources;
using UnityEngine;
using UnityEngine.Rendering;
using Random = System.Random;
using Vector3Int = UnityEngine.Vector3Int;

public class CubeCell
{
    public Vector3Int pos;

    public GameObject gameObject;

    public Material material;

    public bool isWalkable = true;

    public static Vector3Int Reflect(Vector3Int p)
    {
        return new Vector3Int(-p.z, -p.y, -p.x);
    }

    public void ChangeColor(Color c)
    {
        material.color = c;
    }

    public CubeCell(int x, int y, int z)
    {
        pos = new Vector3Int(x, y, z);
    }

    public CubeCell(Vector3Int mapPos)
    {
        //Debug.Log("Create Map Cell" + mapPos);
        pos = mapPos;
    }

    public List<Vector3Int> Neighbors = new List<Vector3Int>()
    {
        new Vector3Int(1, 0, -1),
        new Vector3Int(1, -1, 0),
        new Vector3Int(0, -1, 1),
        new Vector3Int(-1, 0, 1),
        new Vector3Int(-1, 1, 0),
        new Vector3Int(0, 1, -1), 
    };
}

public class MapDrawer : MonoBehaviour
{
    public static MapDrawer inst;
    public int side;

    public List<int> createChessEvent = new List<int>();
    
    public List<Vector3Int> Neighbors = new List<Vector3Int>()
    {
        new Vector3Int(1, 0, -1),
        new Vector3Int(1, -1, 0),
        new Vector3Int(0, -1, 1),
        new Vector3Int(-1, 0, 1),
        new Vector3Int(-1, 1, 0),
        new Vector3Int(0, 1, -1), 
    };

    private void Awake()
    {
        inst = this;
    }

    public float cube_distance(Vector3Int a, Vector3Int b)
    {
        var vec = a - b;
        return (Mathf.Abs(vec.x) + Mathf.Abs(vec.y) + Mathf.Abs(vec.z)) / 2;
    }

    public CubeCell pixel_to_pointy_hex(Vector2 point)
    {
        /*
        var q = (Mathf.Sqrt(3) / 3 * point.x - 1.0 / 3 * point.y) / size
        var r = (2.0 / 3 * point.y) / size;
        return axial_round(Hex(q, r))
        */

        return null;
    }
    public int MapRadius;

    public float TileSize;

    public List<GameObject> tiles;

    public float HalfSize;
    public float SideRadius;


    public Camera mainCam;
    
    public Vector3 rAxies;
    public Vector3 qAxies;
    public Vector3 sAxies;

    public Dictionary<Vector3Int, CubeCell> maps = new Dictionary<Vector3Int, CubeCell>();

    public CubeCell GetTileByPos(Vector3Int pos)
    {
        return maps[pos];
    }

    public List<Vector3Int> FindPath(Vector3Int from, Vector3Int to)
    {
        var start = from;

        var open = new Dictionary<Vector3Int, float>();
        var closed = new Dictionary<Vector3Int, float>();
        var path = new Dictionary<Vector3Int, Vector3Int>();
        open.Add(start, 0);

        while (open.Count != 0)
        {
            var minDis = float.MaxValue;
            var nowPos = Vector3Int.zero;
            float cost = 0;
            foreach (var k in open.Keys)
            {
                var nowDis = open[k];
                var totalDis = nowDis + cube_distance(k, to);
                if (minDis > totalDis)
                {
                    minDis = totalDis;
                    nowPos = k;
                    cost = totalDis;
                }
            }
            
            closed.Add(nowPos, cost);
            open.Remove(nowPos);

            for (int i = 0; i < Neighbors.Count; i++)
            {
                var nextPos = nowPos + Neighbors[i];
                if (!maps.ContainsKey(nextPos) || !maps[nextPos].isWalkable)
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
                    open.Add(nextPos, closed[nowPos] + cube_distance(nextPos, to));
                }

                if (nextPos == to)
                {
                    var reverse = nextPos;
                    var finalPath = new List<Vector3Int>();
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

    public void CreateTile(CubeCell cell)
    {
        var tileIndex = UnityEngine.Random.Range(0, tiles.Count); 
        var t = tiles[tileIndex];
        cell.isWalkable = tileIndex != 3;
        cell.gameObject = Instantiate(t);
        
        var renderer = cell.gameObject.transform.GetChild(0).gameObject.GetComponent<MeshRenderer>();
        cell.material = renderer.material;

        if (UnityEngine.Random.Range(0, 101) > 50)
        {
            //renderer.material.color = new Color(1.0f, 0.0f, 0.0f, 0.25f);
            cell.ChangeColor(Color.red);
        }
        else
        {
            //renderer.material.color = new Color(0.0f, 1.0f, 0.0f, 0.25f);
            cell.ChangeColor(Color.green);
        }
        
        cell.gameObject.transform.position = qAxies * cell.pos.x + rAxies * cell.pos.y + sAxies * cell.pos.z;
        var pos = cell.pos;
        cell.gameObject.name = $"{pos.x}-{pos.y}-{pos.z}";
    }
    
    public Vector3 GetSceneByCoords(Vector3Int pos)
    {
        return qAxies * pos.x + rAxies * pos.y + sAxies * pos.z;
    }
    public Vector3 SnapToHexGrid(Vector3 scenePos)
    {
        var q = Mathf.RoundToInt((Mathf.Sqrt(3.0f) / 3.0f * scenePos.x - scenePos.z / 3.0f) / TileSize);
        var r = Mathf.RoundToInt((2.0f / 3.0f * scenePos.z) / TileSize);

        var s = -q - r;
        var pos = new Vector3Int(q, r, s);

        return MapDrawer.inst.GetSceneByCoords(pos);
    }

    public Vector3Int SnapToHexGridCoord(Vector3 scenePos)
    {
        var q = Mathf.RoundToInt((Mathf.Sqrt(3.0f) / 3.0f * scenePos.x - scenePos.z / 3.0f) / TileSize);
        var r = Mathf.RoundToInt((2.0f / 3.0f * scenePos.z) / TileSize);

        var s = -q - r;
        var pos = new Vector3Int(q, r, s);

        return pos;
    }

    public Hashtable Serialize()
    {
        var res = new Hashtable();
        return res;
    }

    public void CreateDesk()
    {
        var root = new CubeCell(0, 0, 0);
        CreateTile(root);
        
        maps.Add(root.pos, root);

        List<CubeCell> open = new();
        open.Add(root);

        for (int i = 0; i < MapRadius; i++)
        {
            List<CubeCell> nextTurn = new();
            for (int j = 0; j < open.Count; j++)
            {
                var now = open[j];
                for (int k = 0; k < now.Neighbors.Count; k++)
                {
                    var nowPos = now.Neighbors[k];
                    var newPos = nowPos + now.pos;
                    if (!maps.ContainsKey(newPos))
                    {
                        var node = new CubeCell(newPos);
                        CreateTile(node);
                        maps.Add(node.pos, node);
                        nextTurn.Add(node);
                    }
                }
            }

            open = nextTurn;
        }
        
    }

    
    // Start is called before the first frame update
    void Start()
    {
        HalfSize = TileSize / 2.0f;
        SideRadius = HalfSize * Mathf.Sqrt(3.0f);

        rAxies = new Vector3(0, 0, -1.5f * HalfSize);
        qAxies = new Vector3(SideRadius,0, 1.5f * HalfSize);
        sAxies = new Vector3(-SideRadius, 0,  1.5f * HalfSize);
        
        CreateDesk();
    }


    // Update is called once per frame
    void Update()
    {
        if (Input.GetAxis("Mouse ScrollWheel") > 0f ) // forward
        {
            mainCam.orthographicSize -= 0.2f;
            mainCam.orthographicSize = Mathf.Clamp(mainCam.orthographicSize, 2.5f, 7);
        }
        else if (Input.GetAxis("Mouse ScrollWheel") < 0f ) // backwards
        {
            
            mainCam.orthographicSize += 0.2f;
            mainCam.orthographicSize = Mathf.Clamp(mainCam.orthographicSize, 2.5f, 7);
        }
    }
}
