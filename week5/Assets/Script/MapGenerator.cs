using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using System;
using System.Threading;


public class MapGenerator : MonoBehaviour
{
    public enum  DrawMode {NoiseMap, ColorMap, Mesh};
    public DrawMode drawMode;
    public Noise.NormalizeMode normalizeMode;
    public const int mapChunkSize = 241;

    [Range(0, 6)]public int levelOfDetail;
    public float noiseScale;
    public bool autoUpdate; // Auto Gennerate map in Editor
    public int octaves;
    [Range(0,1)]public float persistance;
    public float lacunarity;
    public int seed;
    public Vector2 offset;
    public TerrainType[] regions;
    public float meshHeightM;
    public AnimationCurve meshHeightCurve;
    Queue<MapThreadInfo<MapData>> mapDataThreadInfoQueue = new Queue<MapThreadInfo<MapData>>(); // queue for mapDataThreadInfo
    Queue<MapThreadInfo<MeshData>> meshDataThreadInfoQueue = new Queue<MapThreadInfo<MeshData>>(); // queue for meshDataThreadInfo

    public void DrawMapEditor()
    {
        MapData mapData = GenerateMapData(Vector2.zero);
        
        MapDisplay display = FindObjectOfType<MapDisplay>();
        if (drawMode == DrawMode.NoiseMap)
        {
            display.DrawnTexture(TexGenerator.TexFromHeightMap(mapData.heightMap));
        }
        else if (drawMode == DrawMode.ColorMap)
        {
            display.DrawnTexture(TexGenerator.TexFromColorMap(mapData.colorMap, mapChunkSize, mapChunkSize));
        }
        else if (drawMode == DrawMode.Mesh)
        {
            display.DrawMesh(MeshGenerator.GenerateTerrainMesh(mapData.heightMap, meshHeightM, meshHeightCurve, levelOfDetail), TexGenerator.TexFromColorMap(mapData.colorMap, mapChunkSize, mapChunkSize));
        }
    }

    // start MapData thread    
    public void RequestMapData(Vector2 center, Action<MapData> callback)
    {
        ThreadStart threadStart = delegate{MapDataThread(center, callback);};
        new Thread (threadStart).Start();       
    }

    // get mapData
    // add mapData + callback to queue
    void MapDataThread(Vector2 center, Action<MapData> callback)
    {
        MapData mapData = GenerateMapData(center);
        lock (mapDataThreadInfoQueue) // when one thread reaches this point while it's executing this bit of code no other thread can execute it, we'll have to wait it to turn 
        {
            mapDataThreadInfoQueue.Enqueue(new MapThreadInfo<MapData>(callback, mapData));
        }
    }

    // start meshData thread   
    public void RequestMeshData(MapData mapData, Action<MeshData> callback)
    {
        ThreadStart threadStart = delegate{MeshDataThread(mapData, callback);};
        new Thread (threadStart).Start();      
    }

    // get meshData
    // add meshData + callback to queue
    void MeshDataThread(MapData mapData, Action<MeshData> callback)
    {
        MeshData meshData = MeshGenerator.GenerateTerrainMesh(mapData.heightMap, meshHeightM, meshHeightCurve, levelOfDetail);
        lock (meshDataThreadInfoQueue) // when one thread reaches this point while it's executing this bit of code no other thread can execute it, we'll have to wait it to turn 
        {
            meshDataThreadInfoQueue.Enqueue(new MapThreadInfo<MeshData>(callback, meshData));
        }
    }



    void Update()
    {
        if (mapDataThreadInfoQueue.Count > 0)
        {
            for (int i = 0; i < mapDataThreadInfoQueue.Count; i++)
            {
                MapThreadInfo<MapData> threadInfo = mapDataThreadInfoQueue.Dequeue();
                threadInfo.callback(threadInfo.parameter);
            }
        }

        if (meshDataThreadInfoQueue.Count > 0)
        {
            for (int i = 0; i < meshDataThreadInfoQueue.Count; i++)
            {
                MapThreadInfo<MeshData> threadInfo = meshDataThreadInfoQueue.Dequeue();
                threadInfo.callback(threadInfo.parameter);
            }
        }

    }

    MapData GenerateMapData(Vector2 center)
    {
        float[,] noiseMap = Noise.GenerateNoiseMap(mapChunkSize, mapChunkSize, seed, noiseScale, octaves, persistance, lacunarity, center + offset, normalizeMode);
        
        Color[] colorMap = new Color[mapChunkSize * mapChunkSize];
        for (int y = 0; y < mapChunkSize; y++)
        {
            for (int x = 0; x < mapChunkSize; x++)
            {
                float currentH = noiseMap[x, y];
                for (int i = 0; i < regions.Length; i++)
                {
                    if (currentH >= regions[i].height)
                    {
                        colorMap[y * mapChunkSize + x] = regions[i].color; // Convert the noiseMap 2D array to a 1D color array;
                        
                    }
                    else
                    {
                        break;
                    }
                }
            }
        }

        return new MapData (noiseMap, colorMap);

        
        
    }

    // This function is called when the script is loaded or a value is changed in the inspector (Called in the editor only).
    void OnValidate() 
    {
        
        if (lacunarity < 1)
        {
            lacunarity = 1;
        }
        if (octaves < 0)
        {
            octaves = 0;
        }
    }

    // This struct holds a mapData variable and a callback variable
    // for both MapData and MeshData
    struct MapThreadInfo<T>
    {
        public readonly Action<T> callback;
        public readonly T parameter;

        public MapThreadInfo (Action<T> callback, T parameter)
        {
            this.callback = callback;
            this.parameter = parameter;
        }

    }

    
}
[System.Serializable]
public struct TerrainType
{
    public string name;
    public float height;
    public Color color;
    
}

public struct MapData
{
    public readonly float[,] heightMap;
    public readonly Color[] colorMap;
    public MapData (float[,] heightMap, Color[] colorMap)
    {
        this.heightMap = heightMap;
        this.colorMap = colorMap;
    }
}