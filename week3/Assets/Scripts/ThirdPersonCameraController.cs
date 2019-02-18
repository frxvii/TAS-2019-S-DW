using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class ThirdPersonCameraController : MonoBehaviour {

    #region Internal References
    private Transform _app;
    private Transform _view;
    private Transform _cameraBaseTransform;
    private Transform _cameraTransform;
    private Transform _cameraLookTarget;
    private Transform _avatarTransform;
    private Transform _ObjectOfInterest;
    private Transform _ST01;
    private Transform _ST02;
    private Transform _ST03;
    private Transform OOI;
    private Rigidbody _avatarRigidbody;
    
    private Vector3 CamChaDis;
    private Vector3 CamObjDis;
    private float outputOfDotProduct1;
    #endregion

    #region Public Tuning Variables
    public Vector3 avatarObservationOffset_Base;
    public float followDistance_Base;
    public float verticalOffset_Base;
    public float pitchGreaterLimit;
    public float pitchLowerLimit;
    public float fovAtUp;
    public float fovAtDown;
    public float _searchRadius;
    public float idleTime;
    
    
    #endregion

    #region Persistent Outputs
    //Positions
    private Vector3 _camRelativePostion_Auto;

    //Directions
    private Vector3 _avatarLookForward;

    //Scalars
    private float _followDistance_Applied;
    private float _verticalOffset_Applied;
    #endregion

    private void Awake()
    {
        _app = GameObject.Find("Application").transform;
        _view = _app.Find("View");
        _cameraBaseTransform = _view.Find("CameraBase");
        _cameraTransform = _cameraBaseTransform.Find("Camera");
        _cameraLookTarget = _cameraBaseTransform.Find("CameraLookTarget");
        _ObjectOfInterest = _view.Find("ObjectOfInterest");
        _ST01 = _ObjectOfInterest.Find("ShinyThings01");
        _ST02 = _ObjectOfInterest.Find("ShinyThings02");
        _ST03 = _ObjectOfInterest.Find("ShinyThings03");
        _avatarTransform = _view.Find("AIThirdPersonController");
        _avatarRigidbody = _avatarTransform.GetComponent<Rigidbody>();
        idleTime = 0f;
        
    }

    private void Update()
    {
        
        if (_Helper_IsIdle())
            _IdleUpdate();
        else if (Input.GetMouseButton(1))
            _ManualUpdate();
        else
            _AutoUpdate();
        print(_Help_IsThereOOI());
        
        
        
        
        
        
        
            

    }

    #region States
    private void _AutoUpdate()
    {
        _ComputeData();
        _FollowAvatar();
        _LookAtAvatar();
        
    }
    private void _ManualUpdate()
    {
        //_FollowAvatar();
         
        _currentPosManual = _avatarTransform.position;
        if (_lastPosManual != _currentPosManual)
            _ManualControl();
        else 
            _ManualCameraRotate();
        _lastPosManual = _currentPosManual;
    }
    private void _IdleUpdate()
    {
        _ComputeData();
        _LookAtObject();
        //_ManualControl();
    }
    #endregion

    #region Internal Logic

    float _standingToWalkingSlider = 0;

    private void _ComputeData()
    {
        _avatarLookForward = Vector3.Normalize(Vector3.Scale(_avatarTransform.forward, new Vector3(1, 0, 1)));

        if (_Helper_IsWalking())
        {
            _standingToWalkingSlider = Mathf.MoveTowards(_standingToWalkingSlider, 1, Time.deltaTime * 3);
        }
        else
        {
            _standingToWalkingSlider = Mathf.MoveTowards(_standingToWalkingSlider, 0, Time.deltaTime);
        }

        float _followDistance_Walking = followDistance_Base;
        float _followDistance_Standing = followDistance_Base * 2;

        float _verticalOffset_Walking = verticalOffset_Base;
        float _verticalOffset_Standing = verticalOffset_Base * 4;

        _followDistance_Applied = Mathf.Lerp(_followDistance_Standing, _followDistance_Walking, _standingToWalkingSlider);
        _verticalOffset_Applied = Mathf.Lerp(_verticalOffset_Standing, _verticalOffset_Walking, _standingToWalkingSlider);

        if(_Help_IsThereOOI())
        {
            float st01dis = Vector3.Distance(_ST01.position,_avatarTransform.position);
            float st02dis = Vector3.Distance(_ST02.position,_avatarTransform.position);
            float st03dis = Vector3.Distance(_ST03.position,_avatarTransform.position);
            
            if(st01dis<st02dis)
            {
                if(st01dis<st03dis)
                    
                    OOI = _ST01;
                    
                else
                    OOI = _ST03;
            }
            else
            {
                if(st02dis<st03dis)
                    
                    OOI = _ST02;
                    
                else
                    OOI = _ST03;
            }
            
            //CamChaDis = _avatarTransform.position - OoiDetect.position;
            //CamObjDis = OOI.position - _cameraTransform.position;
            //CamChaDis = Vector3.Normalize(CamChaDis);
            //CamObjDis = Vector3.Normalize(CamObjDis);
            //outputOfDotProduct1 = Vector3.Dot(CamChaDis,CamObjDis);
        }
            
        
    }
    private void _FollowAvatar()
    {
        _camRelativePostion_Auto = _avatarTransform.position;

        _cameraLookTarget.position = _avatarTransform.position + avatarObservationOffset_Base;
        _cameraTransform.position = _avatarTransform.position - _avatarLookForward * _followDistance_Applied + Vector3.up * _verticalOffset_Applied;
    }

    private void _LookAtAvatar()
    {
        _cameraTransform.LookAt(_cameraLookTarget);
    }

    private void _LookAtObject()
    //if the angle between character and object is larger than 80 degrees, the camera zoom out
    //if the angle is smaller than 80, camera rotate to the object
    {
        if (_Help_IsThereOOI())
            if (Vector3.Angle(_avatarTransform.forward, OOI.position - _avatarTransform.position) <= 80f)
                {
                _cameraLookTarget.position = Vector3.MoveTowards(_cameraLookTarget.position, OOI.position, Time.deltaTime);
                _cameraTransform.LookAt(_cameraLookTarget);
                }
            else
                {
                _cameraTransform.position = 
                    Vector3.MoveTowards(_cameraTransform.position, _avatarTransform.position - _avatarLookForward * _followDistance_Applied * 1.5f + Vector3.up * _verticalOffset_Applied * 3f, Time.deltaTime);
                _cameraTransform.LookAt(_cameraLookTarget);
                
                }
            //Debug.Log(Vector3.Angle(_avatarTransform.forward, OOI.position - _avatarTransform.position));
        
    }
    private void _ManualCameraRotate()
    {
        
        //transform.RotateAround : move the axis to target.postion, then rotate along this axis.
        //characters barely rotate vertically, so the world axis if fine in y axis.
        
        _cameraTransform.RotateAround (_avatarTransform.position, Vector3.up, Input.GetAxis("Mouse X"));
        //because target's local x axis changes, after the character moves. (when a character moves, its face direction rotates)
        //use local instead of world axis.
        
        _cameraTransform.RotateAround (_avatarTransform.position, _cameraTransform.transform.right, -1f * Input.GetAxis("Mouse Y"));
        
    }
    
    
    private void _ManualControl()
    {
        Vector3 _camEulerHold = _cameraTransform.localEulerAngles;
        
        if (Input.GetAxis("Mouse X") != 0)
            _camEulerHold.y += Input.GetAxis("Mouse X");

        if (Input.GetAxis("Mouse Y") != 0)
        {
            float temp = _camEulerHold.x - Input.GetAxis("Mouse Y");
            temp = (temp + 360) % 360;

            if (temp < 180)
                temp = Mathf.Clamp(temp, 0, 80);
            else
                temp = Mathf.Clamp(temp, 360 - 80, 360);

            _camEulerHold.x = temp;
        }

        //Debug.Log("The V3 to be applied is " + _camEulerHold);
        _cameraTransform.localRotation = Quaternion.Euler(_camEulerHold);
        
    }
    #endregion

    #region Helper Functions

    private Vector3 _lastPos;
    private Vector3 _currentPos;
    private Transform _Helper_WhatIsClosest;
    private Vector3 lastWalk;
    private Vector3 currentWalk;
    private Vector3 _lastPosManual;
    private Vector3 _currentPosManual;
    

    private bool _Helper_IsIdle()

    {
        _currentPos = _avatarTransform.position;
        if (_lastPos == _currentPos && !Input.GetMouseButton(1))
            idleTime = idleTime + Time.deltaTime;
        else
            idleTime = 0f;
        _lastPos = _currentPos;
        if (idleTime > 2.0f)
            return true;
        else return false;
    }

    private bool _Helper_IsWalking()
    
    {
        lastWalk = currentWalk;
        currentWalk = _avatarTransform.position;
        float velInst = Vector3.Distance(lastWalk, currentWalk) / Time.deltaTime;
        //lastWalk = currentWalk;
        if (velInst > 0.15f)
            return true;
        else return false;
    }

    private bool _Help_IsThereOOI()
    {
        Collider[] stuffInSphere = 
            Physics.OverlapSphere(_avatarTransform.position, _searchRadius = 20);

        bool _oOIPresent = false;

        for (int i = 0; i < stuffInSphere.Length; i++)
        {
            if (stuffInSphere[i].tag == "ObjectOfInterest")
                _oOIPresent = true;
        }

        return _oOIPresent;
    }
    

    #endregion
}
