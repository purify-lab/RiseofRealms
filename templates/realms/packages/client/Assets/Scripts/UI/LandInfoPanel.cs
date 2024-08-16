using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;

public class LandInfoPanel : MonoBehaviour
{
    public GameObject ChooseSolderPanel;
    public Text coordText;

    public Button attackBtn;
    public Button closeBtn;

    public Text defText;
    public Text goldOutputText;

    public void onClickAttack()
    {
        gameObject.SetActive(false);
        ChooseSolderPanel.SetActive(true);
        Debug.Log("Onclekc Attack");
    }

    public void FillInfo(Vector3Int pos)
    {
        coordText.text = pos.ToString();
    }
    
    // Start is called before the first frame update
    void Start()
    {
        attackBtn.onClick.AddListener(onClickAttack);
        closeBtn.onClick.AddListener(() =>
        {
            gameObject.SetActive(false);
        });
    }

    // Update is called once per frame
    void Update()
    {
        
    }
}
