using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;

public class ArmyItem : MonoBehaviour
{
    public Text cityText;

    public void SetCityCoords(Vector3Int pos)
    {
        cityText.text = pos.ToString();
    }
    
    // Start is called before the first frame update
    void Start()
    {
        
    }

    // Update is called once per frame
    void Update()
    {
        
    }
}
