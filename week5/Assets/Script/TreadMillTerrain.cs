using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class TreadMillTerrain : MonoBehaviour
{
    public const float maxViewDist = 450f; // Max view distance 
    public Transform viewer; // Assigned the camera or Player
    public static Vector2 viewerPos; // viewer position
    int chunkSize;
    int chunkVisDist;
    Dictionary<Vector2, TerrainChunk> ChunkDictionary = new Dictionary<Vector2, TerrainChunk>(); // dictionary of terrainChunk
    List<TerrainChunk> VisibleUpdate = new List<TerrainChunk>();
    static MapGenerator mapGenerator;
    public Material mapMaterial;
    


   

    //

    void Start()
    {
        mapGenerator = FindObjectOfType<MapGenerator>();
        chunkSize = MapGenerator.mapChunkSize - 1; // side length of a single chunk
        chunkVisDist = Mathf.RoundToInt(maxViewDist / chunkSize); // how many chunks can be seen around the viewer
    }

    void Update()
    {
        viewerPos = new Vector2(viewer.position.x, viewer.position.z);
        UpdateVisChunks();
    }

    void UpdateVisChunks()
    {
        for (int i = 0; i < VisibleUpdate.Count; i++)
        {
            VisibleUpdate[i].SetVisible(false);
        }
        VisibleUpdate.Clear();
        // Change the world coord to Grids, one chunk is one grid
        int currentChunkX = Mathf.RoundToInt(viewerPos.x / chunkSize); 
        int currentChunkY = Mathf.RoundToInt(viewerPos.y / chunkSize);
        // Chunk under the viewer's Coord
        for (int yOffset = -chunkVisDist; yOffset <= chunkVisDist; yOffset++)
        {
            for (int xOffset = -chunkVisDist; xOffset <= chunkVisDist; xOffset++)
            {
                Vector2 viewedChunk = new Vector2(currentChunkX + xOffset, currentChunkY + yOffset);
                if (ChunkDictionary.ContainsKey(viewedChunk))
                {
                    ChunkDictionary [viewedChunk].UpdateTerrainChunk();
                    if (ChunkDictionary [viewedChunk].IsVisible())
                    {
                        VisibleUpdate.Add(ChunkDictionary[viewedChunk]);
                    }
                }
                else
                {
                    ChunkDictionary.Add(viewedChunk, new TerrainChunk(viewedChunk, chunkSize, transform, mapMaterial));
                }
            }
        }
    }

    public class TerrainChunk
    {
        GameObject meshObject;
        Vector2 position;
        Bounds bounds;
        MeshRenderer meshRenderer;
        MeshFilter meshFilter;
        
        public TerrainChunk(Vector2 coord, int size, Transform parent, Material material)
        {
            position = coord * size;
            Vector3 positionV3 = new Vector3(position.x, 0, position.y);
            bounds = new Bounds(position, Vector2.one * size);
            
            meshObject = new GameObject("TerrainChunk");
            meshRenderer = meshObject.AddComponent<MeshRenderer>();
            meshFilter = meshObject.AddComponent<MeshFilter>();
            meshRenderer.material = material;
            
            meshObject.transform.position = positionV3;
            
            meshObject.transform.parent = parent;
            SetVisible(false);

            mapGenerator.RequestMapData(position, OnMapDataReceived);
        }


        // do stuff with mapData
        void OnMapDataReceived(MapData mapData)
        {
            mapGenerator.RequestMeshData (mapData, OnMeshDataReceived);
            Texture2D texture = TexGenerator.TexFromColorMap(mapData.colorMap, MapGenerator.mapChunkSize, MapGenerator.mapChunkSize);
            meshRenderer.material.mainTexture = texture;
        }

        void OnMeshDataReceived(MeshData meshData)
        {
            meshFilter.mesh = meshData.CreateMesh();
        }

        public void UpdateTerrainChunk()
        {
            float viewerDist2Edge = Mathf.Sqrt(bounds.SqrDistance(viewerPos));
            bool visible = viewerDist2Edge <= maxViewDist;
            SetVisible(visible);
        }

        public void SetVisible(bool visible)
        {
            meshObject.SetActive(visible);
        }

        public bool IsVisible()
        {
            return meshObject.activeSelf;
        }

        
    }

    class LODMesh
    {

    }

    
    
}
