using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEditor;

[CustomEditor(typeof(MapGenerator))]
public class MapGenEditor : Editor
{
    public override void OnInspectorGUI()
    {
        MapGenerator mapGen = (MapGenerator)target; // ref to MapGenerator
        if (DrawDefaultInspector())
        {
            if(mapGen.autoUpdate)
            {
                mapGen.DrawMapEditor();
            }
        }
        if (GUILayout.Button("Generate"))
        {
            mapGen.DrawMapEditor();
        }
    }
}
