using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class CameraTarget : MonoBehaviour
{
    public BezierSpline spline;

    public float duration;

    private float progress;

    [Range(0,0.1f)]public float distance;
    

    private void Update()
    {
        
        progress += Time.deltaTime / duration;
        if (progress > 1f )
        {
            progress -= 1f + distance;
        }

        Vector3 position = spline.GetPoint(progress + distance);
        transform.localPosition = position;
        
    }
}
