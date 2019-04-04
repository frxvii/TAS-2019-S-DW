﻿using System.Collections;
using System.Collections.Generic;
using UnityEngine;
[CreateAssetMenu(menuName = "Flock/Behavior/Avoidance")]
public class AvoidanceBehavior : FilteredFlockBehavior
{
    public override Vector3 CalculateMove(FlockAgent agent, List<Transform> context, Flock flock)
    {
        // if no heighbors, return no adjustment
        if (context.Count == 0)
        {
            return Vector3.zero;
        }

        // add all vectors together and average 
        Vector3 avoidanceMove = Vector3.zero;
        int nAvoid = 0;
        List<Transform> filterContext = (filter == null) ? context : filter.Filter(agent, context);
        foreach (Transform item in filterContext)
        {
            if (Vector3.SqrMagnitude(item.position - agent.transform.position) < flock.SquareAvoidanceRadius)
            {
                nAvoid++;
                avoidanceMove += agent.transform.position - item.position;
            }
            
        }
        if (nAvoid > 0)
        {
            avoidanceMove /= nAvoid;
        }
        return avoidanceMove;
    }
}
