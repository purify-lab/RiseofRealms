using System;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class EventParam
{
}

public class EventBus : Singleton<EventBus>
{
    private Dictionary<string, List<Action<EventParam>>> events = new();
    
    public void RegisterEvent(string name, Action<EventParam> cb)
    {
        if (!events.ContainsKey(name))
        {
            events.Add(name, new List<Action<EventParam>>());
        }
        
        events[name].Add(cb);
    }

    public void Clear()
    {
        events.Clear();
    }

    public void RemoveEvent(string name, Action<EventParam> cb)
    {
        if (!events.ContainsKey(name))
        {
            return;
        }

        var e = events[name];
        if (e.Contains(cb))
        {
            e.Remove(cb);
        }
    }

    public void Dispatch(string name, EventParam param)
    {
        if (!events.ContainsKey(name))
        {
            return;
        }

        foreach (var ee in events[name])
        {
            ee.Invoke(param);
        }
    }
}
