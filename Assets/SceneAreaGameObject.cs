using System;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.Events;

public class SceneAreaGameObject : MonoBehaviour
{
    public GameObject SceneGameObject;
    
    public UnityEvent OnEnter;
    
    public bool DoExit = true;
    
    // Start is called before the first frame update
    private void OnTriggerEnter(Collider other)
    {
        // if other contains player tag and active self
        if (other.CompareTag("Player") && other.gameObject.activeSelf)
        {
            // load scene by name, keep current scene
            SceneGameObject.SetActive(true);
            
            OnEnter.Invoke();
        }
    }

    private void OnTriggerExit(Collider other)
    {
        // if other contains player tag and active self
        if (other.CompareTag("Player") && other.gameObject.activeSelf && DoExit)
        {
            // unload scene by name
            SceneGameObject.SetActive(false);
        }
    }
}
