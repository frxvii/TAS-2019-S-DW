using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class GridGenerator : MonoBehaviour
{
    private Mesh mesh;
    private Vector3[] vertices;
    public int xSize, zSize;
    [Range(8f,16f)]public float hight;

    
    // Start is called before the first frame update
    void Start()
    {
        Generate();
    }

    // Update is called once per frame
    private void Generate () {
		GetComponent<MeshFilter>().mesh = mesh = new Mesh();
		mesh.name = "Procedural Grid";

		vertices = new Vector3[(xSize + 1) * (zSize + 1)];
        Vector2[] uv = new Vector2[vertices.Length];
		for (int i = 0, z = 0; z <= zSize; z++) {
			for (int x = 0; x <= xSize; x++, i++) {
				vertices[i] = new Vector3(x, 10 * Perlin.Noise(
                        ((float)x + transform.position.x) / hight, 
                        ((float)z + transform.position.z) / hight), z);
                uv[i] = new Vector2((float)x / xSize, (float)z / zSize);
			}
		}
		mesh.vertices = vertices;
        mesh.uv = uv;

		int[] triangles = new int[xSize * zSize * 6];
		for (int ti = 0, vi = 0, z = 0; z < zSize; z++, vi++) {
			for (int x = 0; x < xSize; x++, ti += 6, vi++) {
				triangles[ti] = vi;
				triangles[ti + 3] = triangles[ti + 2] = vi + 1;
				triangles[ti + 4] = triangles[ti + 1] = vi + xSize + 1;
				triangles[ti + 5] = vi + xSize + 2;
			}
		}
		mesh.triangles = triangles;
        mesh.RecalculateNormals();
	}
    
    
    
    void Update()
    {
        
    }
}
