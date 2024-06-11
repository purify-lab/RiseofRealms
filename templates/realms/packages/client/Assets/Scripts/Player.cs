using System;
using System.Collections;
using System.Collections.Generic;
using DG.Tweening;
using UnityEngine;

public class Player : MonoBehaviour
{
    public static Player inst;

    public Vector3Int standPos;

    public Animator animator;

    public CubeCell StandTile;

    public void Stand(CubeCell cel)
    {
        StandTile = cel;
        transform.position = MapDrawer.inst.GetSceneByCoords(cel.pos);
    }

    public void Stand(Vector3Int standTilePos)
    {
        standPos = standTilePos;
        transform.position = MapDrawer.inst.GetSceneByCoords(standTilePos);
    }

    public void MoveTo(Vector3Int pos)
    {
        var res = MapDrawer.inst.FindPath(standPos, pos);
        if (res != null)
        {
            StartCoroutine(realMove(res));
        }
    }

    IEnumerator realMove(List<Vector3Int> path)
    {
        animator.Play("Run");
        for (int i = 0; i < path.Count; i++)
        {
            var pos = path[i];
            var scenePos = MapDrawer.inst.GetSceneByCoords(pos);
            transform.forward = (scenePos - transform.position).normalized;
            transform.DOMove(scenePos, 1.0f).SetEase(Ease.Linear);
            yield return new WaitForSeconds(1.0f);
            standPos = pos;
        }
        animator.Play("Idle");
    }

    // Start is called before the first frame update
    void Start()
    {
        inst = this;
        Stand(Vector3Int.zero);
    }

    // Update is called once per frame
    void Update()
    {
        
    }
}
