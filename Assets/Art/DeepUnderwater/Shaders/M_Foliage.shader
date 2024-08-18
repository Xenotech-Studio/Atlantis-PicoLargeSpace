// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "M_Foliage"
{
	Properties
	{
		Material_Texture2D_1("Albedo", 2D) = "white" {}
		Material_Texture2D_3("Mask", 2D) = "white" {}
		_Mat1_BaseColor("Mat1_BaseColor", Range( 0 , 5)) = 1
		Material_Texture2D_0("Normal", 2D) = "bump" {}
		_Mat1_Roughness("Mat1_Roughness", Range( 0 , 2)) = 0.5
		[Toggle(_USECOLOR_ON)] _UseColor("UseColor", Float) = 0
		_Mat1_Color("Mat1_Color", Color) = (1,1,1,0)
		_Invert("Invert", Float) = 0
		[Toggle(_USEALBEDOALPHA_ON)] _UseAlbedoAlpha("UseAlbedoAlpha", Float) = 0
		[Toggle(_MAT1_COLORTEXTURE_ON)] _Mat1_ColorTexture("Mat1_ColorTexture", Float) = 0
		[Toggle(_MAT1_ROUGHNESSTEXTURE_ON)] _Mat1_RoughnessTexture("Mat1_RoughnessTexture", Float) = 0
		_Mat1_RoughnessT("Mat1_RoughnessT", 2D) = "white" {}
		_Power("Power", Range( 0 , 0.5)) = 0.08
		_Noise("Noise", Range( 0 , 0.5)) = 0.08
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Transparent"  "Queue" = "Transparent+0" "IgnoreProjector" = "True" }
		Cull Off
		CGPROGRAM
		#include "UnityShaderVariables.cginc"
		#pragma target 3.0
		#pragma shader_feature_local _MAT1_COLORTEXTURE_ON
		#pragma shader_feature_local _USECOLOR_ON
		#pragma shader_feature_local _MAT1_ROUGHNESSTEXTURE_ON
		#pragma shader_feature_local _USEALBEDOALPHA_ON
		#pragma surface surf Standard alpha:fade keepalpha vertex:vertexDataFunc 
		struct Input
		{
			float3 worldPos;
			float2 uv_texcoord;
		};

		uniform float _Noise;
		uniform float _Power;
		uniform sampler2D Material_Texture2D_0;
		uniform float4 Material_Texture2D_0_ST;
		uniform float _Invert;
		uniform float _Mat1_BaseColor;
		uniform float4 _Mat1_Color;
		uniform sampler2D Material_Texture2D_1;
		uniform float4 Material_Texture2D_1_ST;
		uniform float _Mat1_Roughness;
		uniform sampler2D _Mat1_RoughnessT;
		uniform float4 _Mat1_RoughnessT_ST;
		uniform sampler2D Material_Texture2D_3;
		uniform float4 Material_Texture2D_3_ST;

		void vertexDataFunc( inout appdata_full v, out Input o )
		{
			UNITY_INITIALIZE_OUTPUT( Input, o );
			float3 ase_vertex3Pos = v.vertex.xyz;
			float3 ase_worldPos = mul( unity_ObjectToWorld, v.vertex );
			float temp_output_39_0 = ( ( ase_vertex3Pos.y * cos( ( ( ( ase_worldPos.x + ase_worldPos.z ) * _Noise ) + _Time.y ) ) ) * _Power );
			float4 appendResult41 = (float4(temp_output_39_0 , 0.0 , temp_output_39_0 , 0.0));
			v.vertex.xyz += appendResult41.xyz;
			v.vertex.w = 1;
		}

		void surf( Input i , inout SurfaceOutputStandard o )
		{
			float2 uvMaterial_Texture2D_0 = i.uv_texcoord * Material_Texture2D_0_ST.xy + Material_Texture2D_0_ST.zw;
			float3 break10 = UnpackNormal( tex2D( Material_Texture2D_0, uvMaterial_Texture2D_0 ) );
			float4 appendResult13 = (float4(break10.x , ( break10.y * _Invert ) , break10.z , 0.0));
			o.Normal = appendResult13.xyz;
			float4 temp_cast_1 = (_Mat1_BaseColor).xxxx;
			float2 uvMaterial_Texture2D_1 = i.uv_texcoord * Material_Texture2D_1_ST.xy + Material_Texture2D_1_ST.zw;
			float4 tex2DNode2 = tex2D( Material_Texture2D_1, uvMaterial_Texture2D_1 );
			#ifdef _USECOLOR_ON
				float4 staticSwitch18 = ( _Mat1_Color * tex2DNode2 );
			#else
				float4 staticSwitch18 = temp_cast_1;
			#endif
			#ifdef _MAT1_COLORTEXTURE_ON
				float4 staticSwitch20 = tex2DNode2;
			#else
				float4 staticSwitch20 = staticSwitch18;
			#endif
			o.Albedo = ( _Mat1_BaseColor * staticSwitch20 ).rgb;
			float4 temp_cast_3 = (_Mat1_Roughness).xxxx;
			float2 uv_Mat1_RoughnessT = i.uv_texcoord * _Mat1_RoughnessT_ST.xy + _Mat1_RoughnessT_ST.zw;
			#ifdef _MAT1_ROUGHNESSTEXTURE_ON
				float4 staticSwitch24 = tex2D( _Mat1_RoughnessT, uv_Mat1_RoughnessT );
			#else
				float4 staticSwitch24 = temp_cast_3;
			#endif
			o.Smoothness = staticSwitch24.r;
			float2 uvMaterial_Texture2D_3 = i.uv_texcoord * Material_Texture2D_3_ST.xy + Material_Texture2D_3_ST.zw;
			float4 temp_cast_5 = (tex2DNode2.a).xxxx;
			#ifdef _USEALBEDOALPHA_ON
				float4 staticSwitch14 = temp_cast_5;
			#else
				float4 staticSwitch14 = tex2D( Material_Texture2D_3, uvMaterial_Texture2D_3 );
			#endif
			o.Alpha = staticSwitch14.r;
		}

		ENDCG
	}
	Fallback "Diffuse"
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=18930
3355;155;1920;906;3215.21;-510.9657;1.497174;True;True
Node;AmplifyShaderEditor.WorldPosInputsNode;30;-2855.01,867.472;Inherit;False;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.RangedFloatNode;33;-2718.532,1061.809;Inherit;False;Property;_Noise;Noise;13;0;Create;True;0;0;0;False;0;False;0.08;0.08;0;0.5;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;31;-2592.532,785.8094;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.TimeNode;34;-2628.887,1241.539;Inherit;False;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;32;-2357.532,922.8094;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;35;-2185.532,1073.809;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;15;-1714.206,-500.1283;Inherit;False;Property;_Mat1_Color;Mat1_Color;6;0;Create;True;0;0;0;False;0;False;1,1,1,0;0.235849,0.235849,0.235849,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;2;-1656.482,-221.1286;Inherit;True;Property;Material_Texture2D_1;Albedo;0;0;Create;False;0;0;0;False;0;False;-1;abc00000000011634673642711658973;abc00000000011634673642711658973;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.PosVertexDataNode;38;-2029.532,951.8093;Inherit;False;0;0;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.CosOpNode;36;-2035.504,1306.458;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;19;-1445.12,-593.7974;Inherit;False;Property;_Mat1_BaseColor;Mat1_BaseColor;2;0;Create;True;1;Material_1;0;0;False;0;False;1;1;0;5;0;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;9;-1077.424,-30.60984;Inherit;True;Property;Material_Texture2D_0;Normal;3;0;Create;False;0;0;0;False;0;False;-1;abc00000000012122850438009226639;abc00000000012122850438009226639;True;0;True;bump;Auto;True;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;17;-1343.374,-414.4885;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.BreakToComponentsNode;10;-735.4246,35.81146;Inherit;False;FLOAT3;1;0;FLOAT3;0,0,0;False;16;FLOAT;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT;5;FLOAT;6;FLOAT;7;FLOAT;8;FLOAT;9;FLOAT;10;FLOAT;11;FLOAT;12;FLOAT;13;FLOAT;14;FLOAT;15
Node;AmplifyShaderEditor.RangedFloatNode;40;-1724.661,1427.29;Inherit;False;Property;_Power;Power;12;0;Create;True;0;0;0;False;0;False;0.08;0.08;0;0.5;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;37;-1804.532,1237.809;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;11;-783.0624,-165.8431;Inherit;False;Property;_Invert;Invert;7;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.StaticSwitch;18;-1184.604,-461.7285;Inherit;False;Property;_UseColor;UseColor;5;0;Create;True;0;0;0;False;0;False;0;0;0;True;;Toggle;2;Key0;Key1;Create;True;True;All;9;1;COLOR;0,0,0,0;False;0;COLOR;0,0,0,0;False;2;COLOR;0,0,0,0;False;3;COLOR;0,0,0,0;False;4;COLOR;0,0,0,0;False;5;COLOR;0,0,0,0;False;6;COLOR;0,0,0,0;False;7;COLOR;0,0,0,0;False;8;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;39;-1526.532,1206.809;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;22;-1035.479,503.5608;Inherit;False;Property;_Mat1_Roughness;Mat1_Roughness;4;0;Create;True;0;0;0;False;0;False;0.5;0.5;0;2;0;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;4;-1476.732,289.3799;Inherit;True;Property;Material_Texture2D_3;Mask;1;0;Create;False;0;0;0;False;0;False;-1;abc00000000015841410210242463388;abc00000000015841410210242463388;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;23;-1082.542,620.458;Inherit;True;Property;_Mat1_RoughnessT;Mat1_RoughnessT;11;0;Create;True;0;0;0;False;0;False;-1;abc00000000014223320513168256840;abc00000000014223320513168256840;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;12;-552.3325,-161.48;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;-1;False;1;FLOAT;0
Node;AmplifyShaderEditor.StaticSwitch;20;-943.8571,-391.3134;Inherit;False;Property;_Mat1_ColorTexture;Mat1_ColorTexture;9;0;Create;True;0;0;0;False;0;False;0;0;0;True;;Toggle;2;Key0;Key1;Create;True;True;All;9;1;COLOR;0,0,0,0;False;0;COLOR;0,0,0,0;False;2;COLOR;0,0,0,0;False;3;COLOR;0,0,0,0;False;4;COLOR;0,0,0,0;False;5;COLOR;0,0,0,0;False;6;COLOR;0,0,0,0;False;7;COLOR;0,0,0,0;False;8;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;42;-1002.532,1101.809;Inherit;False;2;2;0;FLOAT4;0,0,0,0;False;1;FLOAT4x4;0,0,0,0,0,1,0,0,0,0,1,0,0,0,0,1;False;1;FLOAT4;0
Node;AmplifyShaderEditor.StaticSwitch;24;-744.472,565.6003;Inherit;False;Property;_Mat1_RoughnessTexture;Mat1_RoughnessTexture;10;0;Create;True;0;0;0;False;0;False;0;0;0;True;;Toggle;2;Key0;Key1;Create;True;True;All;9;1;COLOR;0,0,0,0;False;0;COLOR;0,0,0,0;False;2;COLOR;0,0,0,0;False;3;COLOR;0,0,0,0;False;4;COLOR;0,0,0,0;False;5;COLOR;0,0,0,0;False;6;COLOR;0,0,0,0;False;7;COLOR;0,0,0,0;False;8;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;21;-583.327,-458.3151;Inherit;False;2;2;0;FLOAT;0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.StaticSwitch;14;-971.1859,290.8534;Inherit;False;Property;_UseAlbedoAlpha;UseAlbedoAlpha;8;0;Create;True;0;0;0;False;0;False;0;0;0;True;;Toggle;2;Key0;Key1;Create;True;True;All;9;1;COLOR;0,0,0,0;False;0;COLOR;0,0,0,0;False;2;COLOR;0,0,0,0;False;3;COLOR;0,0,0,0;False;4;COLOR;0,0,0,0;False;5;COLOR;0,0,0,0;False;6;COLOR;0,0,0,0;False;7;COLOR;0,0,0,0;False;8;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.DynamicAppendNode;45;-485.5324,1083.809;Inherit;False;FLOAT4;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.DynamicAppendNode;41;-1291.532,1110.809;Inherit;False;FLOAT4;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.RangedFloatNode;47;-625.5323,1426.809;Inherit;False;Constant;_Float3;Float 3;13;0;Create;True;0;0;0;False;0;False;0.05;0.05;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.ObjectToWorldMatrixNode;43;-1220.532,1340.809;Inherit;False;0;1;FLOAT4x4;0
Node;AmplifyShaderEditor.RotateAboutAxisNode;46;-285.5323,1259.809;Inherit;False;False;4;0;FLOAT3;0,0,0;False;1;FLOAT;0;False;2;FLOAT3;0,0,0;False;3;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.DynamicAppendNode;13;-388.3253,16.31146;Inherit;False;FLOAT4;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.BreakToComponentsNode;44;-781.5322,1095.809;Inherit;False;FLOAT4;1;0;FLOAT4;0,0,0,0;False;16;FLOAT;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT;5;FLOAT;6;FLOAT;7;FLOAT;8;FLOAT;9;FLOAT;10;FLOAT;11;FLOAT;12;FLOAT;13;FLOAT;14;FLOAT;15
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;153,-97;Float;False;True;-1;2;ASEMaterialInspector;0;0;Standard;M_Foliage;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;False;False;False;False;False;False;Off;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Transparent;0.5;True;False;0;True;Transparent;;Transparent;All;18;all;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;True;2;5;False;-1;10;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;True;Relative;0;;1;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;False;16;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;31;0;30;1
WireConnection;31;1;30;3
WireConnection;32;0;31;0
WireConnection;32;1;33;0
WireConnection;35;0;32;0
WireConnection;35;1;34;2
WireConnection;36;0;35;0
WireConnection;17;0;15;0
WireConnection;17;1;2;0
WireConnection;10;0;9;0
WireConnection;37;0;38;2
WireConnection;37;1;36;0
WireConnection;18;1;19;0
WireConnection;18;0;17;0
WireConnection;39;0;37;0
WireConnection;39;1;40;0
WireConnection;12;0;10;1
WireConnection;12;1;11;0
WireConnection;20;1;18;0
WireConnection;20;0;2;0
WireConnection;42;0;41;0
WireConnection;42;1;43;0
WireConnection;24;1;22;0
WireConnection;24;0;23;0
WireConnection;21;0;19;0
WireConnection;21;1;20;0
WireConnection;14;1;4;0
WireConnection;14;0;2;4
WireConnection;45;0;44;0
WireConnection;45;2;44;2
WireConnection;41;0;39;0
WireConnection;41;2;39;0
WireConnection;46;1;47;0
WireConnection;46;3;45;0
WireConnection;13;0;10;0
WireConnection;13;1;12;0
WireConnection;13;2;10;2
WireConnection;44;0;42;0
WireConnection;0;0;21;0
WireConnection;0;1;13;0
WireConnection;0;4;24;0
WireConnection;0;9;14;0
WireConnection;0;10;14;0
WireConnection;0;11;41;0
ASEEND*/
//CHKSM=CAD8134BC54CAEE190AAE454E9ACFCE0E32DCB89