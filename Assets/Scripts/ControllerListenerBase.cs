using UnityEngine;

namespace Versee.Interaction
{
    public abstract class ControllerListenerBase : MonoBehaviour
    {
        private bool _leftIndexTriggerDown;
        private bool _rightIndexTriggerDown;

        public void Update()
        {
            if (PlatformGetLIndexTrigger() > 0.5)
            {
                if (!_leftIndexTriggerDown)
                {
                    _leftIndexTriggerDown = true;
                    onLeftIndexTriggerClick();
                }

            }
            else
            {
                _leftIndexTriggerDown = false;
            }
            
            if (PlatformGetRIndexTrigger() > 0.5)
            {
                if (!_rightIndexTriggerDown)
                {
                    _rightIndexTriggerDown = true;
                    onRightIndexTriggerClick();
                }
            }
            else
            {
                _rightIndexTriggerDown = false;
            }
            
            childUpdate();
        }

        static public float PlatformGetLIndexTrigger()
        {
            float result;
            UnityEngine.XR.InputDevices.GetDeviceAtXRNode(UnityEngine.XR.XRNode.LeftHand).TryGetFeatureValue(UnityEngine.XR.CommonUsages.trigger, out result);
            //Debug.Log(result);
            return result;
        }
        
        static public float PlatformGetRIndexTrigger()
        {
            float result;
            UnityEngine.XR.InputDevices.GetDeviceAtXRNode(UnityEngine.XR.XRNode.RightHand).TryGetFeatureValue(UnityEngine.XR.CommonUsages.trigger, out result);
            //Debug.Log(result);
            return result;
        }
        
        static public Vector2 PlatformGetLThumbStick()
        {
            Vector2 result;
            UnityEngine.XR.InputDevices.GetDeviceAtXRNode(UnityEngine.XR.XRNode.LeftHand).TryGetFeatureValue(UnityEngine.XR.CommonUsages.primary2DAxis, out result);
            //Debug.Log(result);
            return result;
        }
        
        static public Vector2 PlatformGetRThumbStick()
        {
            Vector2 result;
            UnityEngine.XR.InputDevices.GetDeviceAtXRNode(UnityEngine.XR.XRNode.RightHand).TryGetFeatureValue(UnityEngine.XR.CommonUsages.primary2DAxis, out result);
            //Debug.Log(result);
            return result;
        }
        
        static public bool PlatformGetButtonA()
        {
            bool result;
            UnityEngine.XR.InputDevices.GetDeviceAtXRNode(UnityEngine.XR.XRNode.RightHand).TryGetFeatureValue(UnityEngine.XR.CommonUsages.primaryButton, out result);
            //Debug.Log(result);
            return result;
        }
        
        static public bool PlatformGetButtonB()
        {
            bool result;
            UnityEngine.XR.InputDevices.GetDeviceAtXRNode(UnityEngine.XR.XRNode.RightHand).TryGetFeatureValue(UnityEngine.XR.CommonUsages.secondaryButton, out result);
            //Debug.Log(result);
            return result;
        }
        
        static public bool PlatformGetButtonX()
        {
            bool result;
            UnityEngine.XR.InputDevices.GetDeviceAtXRNode(UnityEngine.XR.XRNode.LeftHand).TryGetFeatureValue(UnityEngine.XR.CommonUsages.primaryButton, out result);
            //Debug.Log(result);
            return result;
        }
        
        static public bool PlatformGetButtonY()
        {
            bool result;
            UnityEngine.XR.InputDevices.GetDeviceAtXRNode(UnityEngine.XR.XRNode.LeftHand).TryGetFeatureValue(UnityEngine.XR.CommonUsages.secondaryButton, out result);
            //Debug.Log(result);
            return result;
        }

        public abstract void onLeftIndexTriggerClick();
        public abstract void onRightIndexTriggerClick();

        public abstract void childUpdate();
    }
}
