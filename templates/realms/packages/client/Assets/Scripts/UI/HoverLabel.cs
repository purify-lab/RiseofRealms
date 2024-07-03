using System;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.EventSystems;
using UnityEngine.UI;

public class HoverLabel : MonoBehaviour, IPointerEnterHandler, IPointerExitHandler
{
    public Text label;
    public bool isShow = false;

    public void OnPointerEnter(PointerEventData eventData)
    {
        isShow = true;
        label.gameObject.SetActive(true);
    }

    public void OnPointerExit(PointerEventData eventData)
    {
        isShow = false;
        label.gameObject.SetActive(false);
    }

    private void Update()
    {
    }
}

