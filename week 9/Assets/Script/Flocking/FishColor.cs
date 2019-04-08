using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class FishColor : MonoBehaviour
{
MeshRenderer _myMR;

private void Start()
{
    _myMR = GetComponent<MeshRenderer>();
}

    // Update is called once per frame
    void Update()
    {
        Color fishColor = Color.Lerp(Color.red, Color.blue, Mathf.Sin(Time.time));
        
        foreach (Material m in _myMR.materials)
        {
            m.SetColor("_Color", fishColor);
        }
    }
}
