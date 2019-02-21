using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class CrossProductCalculator : MonoBehaviour
{
    public Vector3 vectorA;
    public Vector3 vectorB;

    public Vector3 outputvectorACrossB;
    public Vector3 outputvectorBCrossA;

    
    // Start is called before the first frame update
    void Start()
    {
        
    }

    // Update is called once per frame
    void Update()
    {
        outputvectorACrossB = Vector3.Cross(vectorA, vectorB);
        outputvectorBCrossA = Vector3.Cross(vectorB, vectorA);
        
    }
}
