using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.PlayerLoop;

public class Singleton<T> : System.Object where T : Singleton<T>, new()
{
    private static T _inst;

    public virtual void Init()
    {
        
    }

    public static T Inst
    {
        get
        {
            if(_inst == null)
            {
                _inst = new T();
                _inst.Init();
            }
            return _inst;
        }
    }
    
}
