using System;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class MainThreadLogger : MonoBehaviour
{
    public string msg;
    public static MainThreadLogger inst;

    private void Awake()
    {
        inst = this;
    }

    private void Update()
    {
        if (msg.Length > 0)
        {
            Debug.Log("Jerry Message: " + msg);
        }

        msg = "";
    }
}
