using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class ChunkExample : MonoBehaviour
{
    private MeshFilter _myMF;
    private MeshRenderer _myMR;
    private Mesh _myMesh;
    private Vector3[] _verts;
    private int[] _tris;
    private Vector2[] _uVs;
    private Vector3[] _normals;

    public int sizeSquare;
    private int _totalVertInd;
    private int _totalTris;

    private void Awake()
    {
        _myMF = gameObject.AddComponent<MeshFilter>();
        _myMR = gameObject.AddComponent<MeshRenderer>();

        _myMesh = new Mesh();
    }  
    
    
    // Start is called before the first frame update
    void Start()
    {
        _Init();
        _CalcMesh();
        _ApplyMesh();
    }

    private void _Init()
    {
        _totalVertInd = (sizeSquare + 1) * (sizeSquare + 1);
        _totalTris = (sizeSquare * sizeSquare) * 2 * 3;
        _verts = new Vector3[_totalVertInd];
        _tris = new int[_totalTris];
        _uVs = new Vector2[_totalVertInd];
        _normals = new Vector3[_totalVertInd];
    }
    
    private void _CalcMesh()
    {
        for (int x = 0; x<= sizeSquare; x++)
        {
            for (int z = 0; z<= sizeSquare; z++)
            {
                _verts[(z * (sizeSquare + 1))+ x] = new Vector3(x, 0 , z);
            }
        }

        int _triInd = 0;
        for (int i = 0; i < sizeSquare; i++)
        {
            for (int j = 0; j < sizeSquare; j++)
            {
                _tris[_triInd] = j;
                _triInd++;
                _tris[_triInd] = i * (sizeSquare + 1);
                _triInd++;
                _tris[_triInd] = j + 1;
                _triInd++;
                _tris[_triInd] = i * (sizeSquare + 1);
                _triInd++;
                _tris[_triInd] = i * (sizeSquare + 2);
                _triInd++;
                _tris[_triInd] = j + 1;
                _triInd++;
            }
        }
    }

    private void _ApplyMesh()
    {
        _myMesh.vertices = _verts;
        _myMesh.triangles = _tris;
        _myMesh.RecalculateNormals();

        _myMF.mesh = _myMesh;

        _myMR.material = Resources.Load<Material>("MyMat");
    }
    
    // Update is called once per frame
    void Update()
    {
        
    }
}
