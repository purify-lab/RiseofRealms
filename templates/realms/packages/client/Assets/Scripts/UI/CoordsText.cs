using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;

public class CoordsText : MonoBehaviour
{
    public Text coordsText;
    public void SetCoords(Vector3Int pos)
    {
        coordsText.text = pos.ToString();
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
