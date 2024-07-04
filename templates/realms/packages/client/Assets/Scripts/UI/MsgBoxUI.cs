using System;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;

public class MsgBoxUI : MonoBehaviour
{
    public static MsgBoxUI inst;

    public Button okBtn;
    public Button cancleBtn;
    public Button closeBtn;

    private Action<int> onFinished;

    private void Awake()
    {
        inst = this;
    }

    public void Show(Action<int> finished)
    {
        onFinished = finished;
        gameObject.SetActive(true);
    }

    void OnClose()
    {
        onFinished?.Invoke(0);
        gameObject.SetActive(false);
    }

    void OnOK()
    {
        onFinished?.Invoke(1);
        gameObject.SetActive(false);
    }

    // Start is called before the first frame update
    void Start()
    {
        okBtn.onClick.AddListener(OnOK);
        cancleBtn.onClick.AddListener(OnClose);
        closeBtn.onClick.AddListener(OnClose);
    }

    // Update is called once per frame
    void Update()
    {
        
    }
}
