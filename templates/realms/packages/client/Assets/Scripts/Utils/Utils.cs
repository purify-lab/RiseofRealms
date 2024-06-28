using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Utils 
{
    public static string GetAddressText(string originalString)
    {
        string modifiedString = originalString.Substring(0, 4) + "...." + originalString.Substring(originalString.Length - 4);
        return modifiedString;
    }
}
