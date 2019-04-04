using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class FlockManager : MonoBehaviour
{
    public GameObject myAutoAgentPrefab;
    [Range(1,500)]public int numberOfSpawns;

    List<GameObject> _allMyAgents = new List<GameObject>();
    Collider[] collInRad = new Collider[1];
    // Start is called before the first frame update
    void Start()
    {
        float rCubed = 3 * numberOfSpawns /  (4 * Mathf.PI * .01f);
        float r = Mathf.Pow(rCubed, .3333333f);

        for (int i = 0; i < numberOfSpawns; i++)
        {
            _allMyAgents.Add(Instantiate(myAutoAgentPrefab, Random.insideUnitSphere * r, Quaternion.identity, transform));
        }
    }

    // Update is called once per frame
    void Update()
    {
        foreach(GameObject g in _allMyAgents)
        {
            AutoAgentBehavior a = g.GetComponent<AutoAgentBehavior>();
            
            Physics.OverlapSphereNonAlloc(g.transform.position, 5, collInRad);

            // Currently getting a ref to itself so may do something weird

            a.PassArrayOfContext(collInRad);
        }
    }
}
