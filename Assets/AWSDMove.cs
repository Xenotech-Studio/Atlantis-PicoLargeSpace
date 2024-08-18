using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using Versee.Interaction;

public class AWSDMove : MonoBehaviour
{
    public Transform rootTransform;
    
    public float speed = 1.0f;
    
    public float Speed => Input.GetKey(KeyCode.LeftShift) ? speed * 3 : speed;
    
    bool turnLastFrame = false;

    // Update is called once per frame
    void Update()
    {
        if (Input.GetKey(KeyCode.W))
        {
            rootTransform.position += rootTransform.forward * Speed * Time.deltaTime;
        }
        if (Input.GetKey(KeyCode.S))
        {
            rootTransform.position -= rootTransform.forward * Speed * Time.deltaTime;
        }
        if (Input.GetKey(KeyCode.A))
        {
            rootTransform.position -= rootTransform.right * Speed * Time.deltaTime;
        }
        if (Input.GetKey(KeyCode.D))
        {
            rootTransform.position += rootTransform.right * Speed * Time.deltaTime;
        }
        
        // left and right arrow can turn 45 degrees per press
        if (Input.GetKeyDown(KeyCode.LeftArrow))
        {
            rootTransform.Rotate(Vector3.up, -45);
        }
        if (Input.GetKeyDown(KeyCode.RightArrow))
        {
            rootTransform.Rotate(Vector3.up, 45);
        }
        
        // when left controller index is pressed
        if (ControllerListenerBase.PlatformGetLIndexTrigger() > 0.5f && ControllerListenerBase.PlatformGetRIndexTrigger() > 0.5f)
        {
            // if right thumbstick push forward
            rootTransform.position += rootTransform.forward * ControllerListenerBase.PlatformGetRThumbStick().y * Speed * Time.deltaTime;
            
            // when right thumbstick push left or right, rotate the rootTransform (snap turn)
            bool isLeft = ControllerListenerBase.PlatformGetRThumbStick().x < -0.5f;
            bool isRight = ControllerListenerBase.PlatformGetRThumbStick().x > 0.5f;
            if (isLeft && !turnLastFrame)
            {
                rootTransform.Rotate(Vector3.up, -45);
                turnLastFrame = true;
            }
            else if (isRight && !turnLastFrame)
            {
                rootTransform.Rotate(Vector3.up, 45);
                turnLastFrame = true;
            }
            else if (!isLeft && !isRight)
            {
                turnLastFrame = false;
            }
        }
    }
}
