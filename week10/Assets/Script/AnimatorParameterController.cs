using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class AnimatorParameterController : MonoBehaviour
{
    private float walkRun_TreeVal_X;
    private float walkRun_TreeVal_Y;
    private float time;

    private Animator _myAnimator;
    [Header("Tuning Values")]
    [Range(0.001f, 10.0f)] public float walkCycleTime;
    [Range(0.001f,1.00f)] public float walkRunMagnitude;
    [Range(0.001f,1.00f)] public float walkRunBlendTotal;
    
    // Start is called before the first frame update
    void Start()
    {
        _myAnimator = GetComponent<Animator>();
    }

    // Update is called once per frame
    void Update()
    {
        if (Input.GetKey(KeyCode.W))
            _myAnimator.SetBool("Idle_False_Move_True", true);
        else
            _myAnimator.SetBool("Idle_False_Move_True", false);

        idleTime += Time.deltaTime * 6;
        _myAnimator.SetBool("Idle_TreeVal_X")
        
        
        walkCycleTime = 1 - (walkRunBlendTotal * 0.75f);
        walkRunMagnitude = (walkRunBlendTotal * 0.75f) + 0.25f;
        
        time += (Mathf.PI * 2 * Time.deltaTime) / walkCycleTime;

        walkRun_TreeVal_X = Mathf.Cos(time);
        walkRun_TreeVal_Y = Mathf.Sin(time);

        _myAnimator.SetFloat("Walk_Treeval_X", walkRun_TreeVal_X);
        _myAnimator.SetFloat("Walk_Treeval_Y", walkRun_TreeVal_Y);
    }
}
