using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class AWSDMove : MonoBehaviour
{
    public Transform rootTransform;
    
    public float speed = 1.0f;
    
    public float Speed => Input.GetKey(KeyCode.LeftShift) ? speed * 3 : speed;

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
    }
}
