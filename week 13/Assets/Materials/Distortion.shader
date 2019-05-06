// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "Distortion"
{
	Properties
	{
		_TextureSample0("Texture Sample 0", 2D) = "white" {}
		_MainTex("MainTex", 2D) = "white" {}
		_DistortionStrenghth("DistortionStrenghth", Range( 0 , 1)) = 0
		_ScanLine("ScanLine", 2D) = "white" {}
	}
	
	SubShader
	{
		
		
		Tags { "RenderType"="Opaque" }
		LOD 100

		CGINCLUDE
		#pragma target 3.0
		ENDCG
		Blend Off
		Cull Back
		ColorMask RGBA
		ZWrite On
		ZTest LEqual
		Offset 0 , 0
		
		
		
		Pass
		{
			Name "Unlit"
			
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			#pragma multi_compile_instancing
			#include "UnityCG.cginc"
			#include "UnityShaderVariables.cginc"


			struct appdata
			{
				float4 vertex : POSITION;
				float4 color : COLOR;
				UNITY_VERTEX_INPUT_INSTANCE_ID
				float4 ase_texcoord : TEXCOORD0;
			};
			
			struct v2f
			{
				float4 vertex : SV_POSITION;
				UNITY_VERTEX_INPUT_INSTANCE_ID
				UNITY_VERTEX_OUTPUT_STEREO
				float4 ase_texcoord : TEXCOORD0;
				float4 ase_texcoord1 : TEXCOORD1;
			};

			uniform sampler2D _MainTex;
			uniform sampler2D _TextureSample0;
			uniform float _DistortionStrenghth;
			uniform sampler2D _ScanLine;
			float3 mod2D289( float3 x ) { return x - floor( x * ( 1.0 / 289.0 ) ) * 289.0; }
			float2 mod2D289( float2 x ) { return x - floor( x * ( 1.0 / 289.0 ) ) * 289.0; }
			float3 permute( float3 x ) { return mod2D289( ( ( x * 34.0 ) + 1.0 ) * x ); }
			float snoise( float2 v )
			{
				const float4 C = float4( 0.211324865405187, 0.366025403784439, -0.577350269189626, 0.024390243902439 );
				float2 i = floor( v + dot( v, C.yy ) );
				float2 x0 = v - i + dot( i, C.xx );
				float2 i1;
				i1 = ( x0.x > x0.y ) ? float2( 1.0, 0.0 ) : float2( 0.0, 1.0 );
				float4 x12 = x0.xyxy + C.xxzz;
				x12.xy -= i1;
				i = mod2D289( i );
				float3 p = permute( permute( i.y + float3( 0.0, i1.y, 1.0 ) ) + i.x + float3( 0.0, i1.x, 1.0 ) );
				float3 m = max( 0.5 - float3( dot( x0, x0 ), dot( x12.xy, x12.xy ), dot( x12.zw, x12.zw ) ), 0.0 );
				m = m * m;
				m = m * m;
				float3 x = 2.0 * frac( p * C.www ) - 1.0;
				float3 h = abs( x ) - 0.5;
				float3 ox = floor( x + 0.5 );
				float3 a0 = x - ox;
				m *= 1.79284291400159 - 0.85373472095314 * ( a0 * a0 + h * h );
				float3 g;
				g.x = a0.x * x0.x + h.x * x0.y;
				g.yz = a0.yz * x12.xz + h.yz * x12.yw;
				return 130.0 * dot( m, g );
			}
			
			
			v2f vert ( appdata v )
			{
				v2f o;
				UNITY_SETUP_INSTANCE_ID(v);
				UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO(o);
				UNITY_TRANSFER_INSTANCE_ID(v, o);

				float4 ase_clipPos = UnityObjectToClipPos(v.vertex);
				float4 screenPos = ComputeScreenPos(ase_clipPos);
				o.ase_texcoord = screenPos;
				
				o.ase_texcoord1.xy = v.ase_texcoord.xy;
				
				//setting value to unused interpolator channels and avoid initialization warnings
				o.ase_texcoord1.zw = 0;
				float3 vertexValue =  float3(0,0,0) ;
				#if ASE_ABSOLUTE_VERTEX_POS
				v.vertex.xyz = vertexValue;
				#else
				v.vertex.xyz += vertexValue;
				#endif
				o.vertex = UnityObjectToClipPos(v.vertex);
				return o;
			}
			
			fixed4 frag (v2f i ) : SV_Target
			{
				UNITY_SETUP_INSTANCE_ID(i);
				fixed4 finalColor;
				float4 screenPos = i.ase_texcoord;
				float4 ase_screenPosNorm = screenPos / screenPos.w;
				ase_screenPosNorm.z = ( UNITY_NEAR_CLIP_VALUE >= 0 ) ? ase_screenPosNorm.z : ase_screenPosNorm.z * 0.5 + 0.5;
				float3 appendResult3 = (float3(ase_screenPosNorm.x , ase_screenPosNorm.y , 0.0));
				float mulTime19 = _Time.y * 2.0;
				float2 temp_cast_2 = (sin( mulTime19 )).xx;
				float2 uv023 = i.ase_texcoord1.xy * float2( 1,1 ) + temp_cast_2;
				float2 temp_cast_3 = (uv023.y).xx;
				float simplePerlin2D20 = snoise( temp_cast_3 );
				float3 appendResult13 = (float3(ase_screenPosNorm.x , ase_screenPosNorm.y , 0.0));
				
				
				finalColor = ( tex2D( _MainTex, ( float4( appendResult3 , 0.0 ) + ( tex2D( _TextureSample0, appendResult3.xy ) * _DistortionStrenghth ) + (simplePerlin2D20*0.2 + 0.01) ).rg ) * tex2D( _ScanLine, appendResult13.xy ) * 1.5 );
				return finalColor;
			}
			ENDCG
		}
	}
	CustomEditor "ASEMaterialInspector"
	
	
}
/*ASEBEGIN
Version=16600
-103;701;2335;1091;1567.062;761.6708;1.363187;True;True
Node;AmplifyShaderEditor.RangedFloatNode;9;-1063.378,-485.7905;Float;False;Constant;_Float0;Float 0;3;0;Create;True;0;0;False;0;2;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleTimeNode;19;-910.5807,-482.8341;Float;False;1;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SinOpNode;17;-741.8499,-483.4448;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ScreenPosInputsNode;2;-757.2442,-224.2212;Float;False;0;False;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.DynamicAppendNode;3;-466.9785,-211.2794;Float;False;FLOAT3;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;23;-618.9025,-550.0065;Float;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.NoiseGeneratorNode;20;-311.6768,-436.4052;Float;True;Simplex2D;1;0;FLOAT2;0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;5;-429.5932,50.85114;Float;False;Property;_DistortionStrenghth;DistortionStrenghth;2;0;Create;True;0;0;False;0;0;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;4;-249.3476,-146.6734;Float;True;Property;_TextureSample0;Texture Sample 0;0;0;Create;True;0;0;False;0;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;22;-213.9982,-621.4854;Float;False;Constant;_Float2;Float 2;4;0;Create;True;0;0;False;0;0.2;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;27;-212.7545,-523.1693;Float;False;Constant;_Float3;Float 3;4;0;Create;True;0;0;False;0;0.01;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.ScreenPosInputsNode;12;42.06615,241.2451;Float;False;0;False;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;6;58.1317,21.24619;Float;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.ScaleAndOffsetNode;21;14.8153,-462.9431;Float;False;3;0;FLOAT;0;False;1;FLOAT;1;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;13;291.3319,269.1868;Float;False;FLOAT3;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleAddOpNode;7;267.5163,-312.857;Float;False;3;3;0;FLOAT3;0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;15;580.9265,129.6923;Float;False;Constant;_Float1;Float 1;4;0;Create;True;0;0;False;0;1.5;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;10;517.8495,242.3567;Float;True;Property;_ScanLine;ScanLine;3;0;Create;True;0;0;False;0;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;8;482.6983,-297.7708;Float;True;Property;_MainTex;MainTex;1;0;Create;True;0;0;False;0;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;11;905.1447,-68.78567;Float;False;3;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleAddOpNode;14;862.596,-449.0611;Float;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode;1;1100.299,-294.1001;Float;False;True;2;Float;ASEMaterialInspector;0;1;Distortion;0770190933193b94aaa3065e307002fa;True;Unlit;0;0;Unlit;2;True;0;1;False;-1;0;False;-1;0;1;False;-1;0;False;-1;True;0;False;-1;0;False;-1;True;False;True;0;False;-1;True;True;True;True;True;0;False;-1;True;False;255;False;-1;255;False;-1;255;False;-1;7;False;-1;1;False;-1;1;False;-1;1;False;-1;7;False;-1;1;False;-1;1;False;-1;1;False;-1;True;1;False;-1;True;3;False;-1;True;True;0;False;-1;0;False;-1;True;1;RenderType=Opaque=RenderType;True;2;0;False;False;False;False;False;False;False;False;False;True;0;False;0;;0;0;Standard;1;Vertex Position,InvertActionOnDeselection;1;0;1;True;False;2;0;FLOAT4;0,0,0,0;False;1;FLOAT3;0,0,0;False;0
WireConnection;19;0;9;0
WireConnection;17;0;19;0
WireConnection;3;0;2;1
WireConnection;3;1;2;2
WireConnection;23;1;17;0
WireConnection;20;0;23;2
WireConnection;4;1;3;0
WireConnection;6;0;4;0
WireConnection;6;1;5;0
WireConnection;21;0;20;0
WireConnection;21;1;22;0
WireConnection;21;2;27;0
WireConnection;13;0;12;1
WireConnection;13;1;12;2
WireConnection;7;0;3;0
WireConnection;7;1;6;0
WireConnection;7;2;21;0
WireConnection;10;1;13;0
WireConnection;8;1;7;0
WireConnection;11;0;8;0
WireConnection;11;1;10;0
WireConnection;11;2;15;0
WireConnection;1;0;11;0
ASEEND*/
//CHKSM=EBFD3D88CC154EC24A9B5F27F402E0EE8F41890D