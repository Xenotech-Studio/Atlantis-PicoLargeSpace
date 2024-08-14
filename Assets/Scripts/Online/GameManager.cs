using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using Photon.Pun;
using Unity.XR.PXR;
using UnityEngine.SocialPlatforms;
using UnityEngine.XR;

public class GameManager : MonoBehaviour
{
    public static GameObject LocalPlayer;
    public GameObject PlayerPrefeb;

    private int frame;
    private Vector3 globlePos;
    private PxrSensorState2 sensorState;
 
    void Start()
    {
        initPlayer();
    }

    private void initPlayer()
    {      
        /*
        //Camera data
        PXR_Plugin.System.UPxr_GetPredictedMainSensorStateNew(ref sensorState, ref frame);
        DebugHelper.Instance.Log("InitPlayer"+ sensorState.globalPose.position.x.ToString());
        //
        globlePos.x = sensorState.globalPose.position.x;
        globlePos.y = 0;
        globlePos.z = - sensorState.globalPose.position.z;
        //
        */

        if (PhotonNetwork.IsConnected)
        {
            LocalPlayer = PhotonNetwork.Instantiate(PlayerPrefeb.name, Vector3.zero, Quaternion.identity, 0);
        }
        else
        {
            LocalPlayer = Instantiate(PlayerPrefeb, Vector3.zero, Quaternion.identity);
            Debug.Log("以非联网模式启动场景");
        }

        #if UNITY_ANDROID && !UNITY_EDITOR
        #endif
         //  LocalPlayer = PhotonNetwork.Instantiate(PlayerPrefeb.name, Vector3.zero, Quaternion.identity, 0);
    }
}
