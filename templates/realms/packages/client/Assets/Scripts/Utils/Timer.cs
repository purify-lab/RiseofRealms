using System;
using System.Collections;
using System.Collections.Generic;
using Cysharp.Threading.Tasks;
using UnityEngine;

public class Timer : Singleton<Timer> 
{
    public async void Start(int sec, Action cb)
    {
        await UniTask.Delay(TimeSpan.FromSeconds(sec), ignoreTimeScale: false);
        cb.Invoke();
    }
}
