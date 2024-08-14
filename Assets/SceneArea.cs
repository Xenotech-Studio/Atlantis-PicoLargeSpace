using System;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class SceneArea : MonoBehaviour
{
    public string SceneName;
    
    // Start is called before the first frame update
    private void OnTriggerEnter(Collider other)
    {
        // if other contains player tag and active self
        if (other.CompareTag("Player") && other.gameObject.activeSelf)
        {
            // load scene by name, keep current scene
            UnityEngine.SceneManagement.SceneManager.LoadScene(SceneName, UnityEngine.SceneManagement.LoadSceneMode.Additive);
        }
    }

    private void OnTriggerExit(Collider other)
    {
        // if other contains player tag and active self
        if (other.CompareTag("Player") && other.gameObject.activeSelf)
        {
            // unload scene by name
            UnityEngine.SceneManagement.SceneManager.UnloadSceneAsync(SceneName);
        }
    }
}
