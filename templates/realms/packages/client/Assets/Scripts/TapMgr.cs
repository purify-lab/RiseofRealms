using System;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.EventSystems;

public class EventTapMap : EventParam
{
    public Vector3Int pos;
}

public class TapMgr : MonoBehaviour 
{
    public bool isPlacing;
    public GameObject building;
    
    public Vector3Int buildingCursor;
    public Vector3Int tapPos;

    public static TapMgr inst;

    public GameObject LocationUI;

    private void Awake()
    {
        inst = this;
    }
    
    Plane m_Plane;
    // Start is called before the first frame update
    void Start()
    {
        m_Plane = new Plane(Vector3.up, 0);
    }
    
    void OnEnable()
    {
        Lean.Touch.LeanTouch.OnFingerDown += HandleFingerTap;
    }

    void OnDisable()
    {
        Lean.Touch.LeanTouch.OnFingerDown -= HandleFingerTap;
    }

    void HandleFingerTap(Lean.Touch.LeanFinger finger)
    {
        if (finger.IsOverGui)
        {
            Debug.Log("Is Over UI");
            return;
        }
        tapPos = buildingCursor;

        LocationUI.SetActive(true);
        Debug.Log(">>>>> Tap Pos: " + tapPos);
        var tt = LocationUI.GetComponent<LandInfoPanel>();
        tt.FillInfo(tapPos);    
    }

    // Update is called once per frame
    void Update()
    {
        Ray ray = Camera.main.ScreenPointToRay(Input.mousePosition);

        float enter = 0.0f;

        if (m_Plane.Raycast(ray, out enter))
        {
            Vector3 hitPoint = ray.GetPoint(enter);
            hitPoint.z *= -1;

            buildingCursor = MapDrawer.inst.SnapToHexGridCoord(hitPoint);
            if (BuildingMgr.Inst.isPlacing && BuildingMgr.Inst.building != null)
            {
                BuildingMgr.Inst.building.transform.position = MapDrawer.inst.SnapToHexGrid(hitPoint);
            }
        }

        if (Input.GetMouseButtonDown(0))
        {
            tapPos = buildingCursor;
            if (MainPageUI.inst.state == GameState.PlaceTile)
            {
                Debug.Log(">>>>>>>>>> Tap Pos: " + buildingCursor);
                BuildingMgr.Inst.EndPlace();
                MainPageUI.inst.state = GameState.Game;
                PurchaseLandUI.inst.Show(buildingCursor);
            }
                
        }
        if(Input.GetMouseButtonDown(1))
        {
            if (m_Plane.Raycast(ray, out enter))
            {
                Vector3 hitPoint = ray.GetPoint(enter);
                hitPoint.z *= -1;

                var hitCell = MapDrawer.inst.SnapToHexGridCoord(hitPoint);
                
                Player.inst.MoveTo(hitCell);
            }
        }
    }
}
