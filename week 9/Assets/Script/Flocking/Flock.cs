using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Flock : MonoBehaviour
{
    public FlockAgent agentPrefab;
    List<FlockAgent> agents = new List<FlockAgent>();
    public FlockBehavior behavior;
    [Range(5, 500)]public int startCount = 250;
    const float AgentDensity = 0.08f;
    [Range(1f, 100f)]public float driveFactor = 10f; // a paramter that can make the agent move faster
    [Range(1f, 100f)]public float maxSpeed = 5f; // The hightest spped a agent can have
    [Range(1f, 10f)]public float neighborRadius = 1.5f;
    [Range(0f, 3f)]public float avoidanceRadiusMultiplier = 0.5f;


    float squareMaxSpeed;
    float squareNeighborRadius;
    float squareAvoidanceRadius;
    public float SquareAvoidanceRadius { get { return squareAvoidanceRadius; } }
    
    // Start is called before the first frame update
    void Start()
    {
        squareMaxSpeed = maxSpeed * maxSpeed;
        squareNeighborRadius = neighborRadius * neighborRadius;
        squareAvoidanceRadius = squareNeighborRadius * avoidanceRadiusMultiplier * avoidanceRadiusMultiplier;

        // Instantiate agent prefabs, put all agents evenly in a unit sphere with random x,y,z rotation
        for (int i = 0; i < startCount; i++)
        {
            FlockAgent newAgent = Instantiate(
                agentPrefab, 
                Random.insideUnitSphere * startCount * AgentDensity,
                Quaternion.Euler(Random.Range(0f, 360f),Random.Range(0f, 360f), Random.Range(0f, 30f)),
                transform
                ); // The z rotation of a fish should not be too much, since a live fish's fin is always pointing up.
            newAgent.name = "Agent " + i;
            newAgent.Initialize(this);
            agents.Add(newAgent);
        }
    }

    // Update is called once per frame
    void Update()
    {
        foreach (FlockAgent agent in agents)
        {
            List<Transform> context = GetNearbyObjects(agent);

            Vector3 move = behavior.CalculateMove(agent, context, this);
            move *= driveFactor;
            if (move.sqrMagnitude > squareMaxSpeed)
            {
                move = move.normalized * maxSpeed;
            }
            agent.Move(move);
        }
    }

    List<Transform> GetNearbyObjects(FlockAgent agent)
    {
        List<Transform> context = new List<Transform>();
        Collider[] contextColliders = Physics.OverlapSphere(agent.transform.position, neighborRadius); // Detect other agents around
        foreach (Collider c in contextColliders)
        {
            if (c != agent.AgentCollider)
            {
                context.Add(c.transform);
            }
        }
        return context;
    }
}
