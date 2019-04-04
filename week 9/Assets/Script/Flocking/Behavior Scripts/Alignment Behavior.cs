using System.Collections;
using System.Collections.Generic;
using UnityEngine;
[CreateAssetMenu(menuName = "Flock/Behavior/Allignment")]
public class AlignmentBehavior : FilteredFlockBehavior
{
    public override Vector3 CalculateMove(FlockAgent agent, List<Transform> context, Flock flock)
    {
        // if no heighbors, maintain current alignment
        if (context.Count == 0)
        {
            return agent.transform.forward;
        }

        // add all vectors together and average 
        Vector3 alignmentMove = Vector3.zero;
        List<Transform> filterContext = (filter == null) ? context : filter.Filter(agent, context);
        foreach (Transform item in filterContext)
        {
            alignmentMove += item.transform.forward;
        }
        alignmentMove /= context.Count;

        return alignmentMove;
    }
}
