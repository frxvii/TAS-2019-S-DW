using System;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Camera : MonoBehaviour
{
    public BezierSpline spline;

    public float duration;

    private float progress;
    
    
    public Transform target;

    

    private void Update()
    {
        Vector3 relativePos = target.position - transform.position;

        
        Quaternion rotation = Quaternion.LookRotation(relativePos, Vector3.up);
        transform.rotation = rotation;
        
        
        
        progress += Time.deltaTime / duration;
        if (progress > 1f)
        {
            progress -= 1f;
        }

        Vector3 position = spline.GetPoint(progress);
        transform.localPosition = position;
        
        Vector3 positionS = spline.GetVelocity(progress);
        
    }
}
