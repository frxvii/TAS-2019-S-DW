// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "Jellyfish"
{
	Properties
	{
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "TransparentCutout"  "Queue" = "Transparent+0" }
		Cull Off
		CGPROGRAM
		#include "UnityShaderVariables.cginc"
		#pragma target 3.0
		#pragma surface surf Standard keepalpha addshadow fullforwardshadows vertex:vertexDataFunc 
		struct Input
		{
			half filler;
		};

		void vertexDataFunc( inout appdata_full v, out Input o )
		{
			UNITY_INITIALIZE_OUTPUT( Input, o );
			float3 ase_vertex3Pos = v.vertex.xyz;
			float temp_output_126_0 = ( ( 0.5 / ( ase_vertex3Pos.y * ase_vertex3Pos.y ) ) * ( ase_vertex3Pos.x * cos( ( ( 7.0 * ase_vertex3Pos.y ) + ( _Time.y * 3.0 ) ) ) ) );
			float ifLocalVar82 = 0;
			if( -1.25 >= ase_vertex3Pos.y )
				ifLocalVar82 = temp_output_126_0;
			else
				ifLocalVar82 = ( ( ase_vertex3Pos.x * cos( ( ( 7.0 * ase_vertex3Pos.y ) + ( _Time.y * 3.0 ) ) ) ) * ( ase_vertex3Pos.y * ase_vertex3Pos.y * 0.3 ) );
			float temp_output_109_0 = ( ( ase_vertex3Pos.z * sin( ( ( 7.0 * ase_vertex3Pos.y ) + ( _Time.y * 3.0 ) ) ) ) * ( 0.5 / ( ase_vertex3Pos.y * ase_vertex3Pos.y ) ) );
			float ifLocalVar89 = 0;
			if( -1.25 >= ase_vertex3Pos.y )
				ifLocalVar89 = temp_output_109_0;
			else
				ifLocalVar89 = ( ( ase_vertex3Pos.y * ase_vertex3Pos.y * 0.3 ) * ( ase_vertex3Pos.z * sin( ( ( 7.0 * ase_vertex3Pos.y ) + ( _Time.y * 3.0 ) ) ) ) );
			float4 appendResult2 = (float4(ifLocalVar82 , 0.0 , ifLocalVar89 , 0.0));
			v.vertex.xyz += appendResult2.xyz;
		}

		void surf( Input i , inout SurfaceOutputStandard o )
		{
			o.Alpha = 1;
		}

		ENDCG
	}
	Fallback "Diffuse"
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=16301
-2.285714;34.85714;1450;548;1220.551;1943.321;1.445945;True;False
Node;AmplifyShaderEditor.CommentaryNode;156;-2788.235,230.6297;Float;False;1227.187;632.6749;Offset value of Z axis;6;155;100;102;101;103;154;;1,1,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;152;-2741.245,-415.8862;Float;False;1176.32;615.1693;Offset value of Z axis;6;151;150;57;39;45;38;;1,1,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;142;-2728.678,-1735.749;Float;False;1155.002;613.0009;Offset value of X axis;6;141;140;119;116;118;117;;1,1,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;146;-2750.487,-1110.483;Float;False;1181.588;641.0016;Offset value of X axis;6;145;144;33;54;81;34;;1,1,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;145;-2577.2,-730.479;Float;False;443.7997;261.0002;Use Time as the parameter of sin;3;72;41;71;;1,1,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;150;-2691.245,-365.8861;Float;False;495.4714;307.8738;Offset sin/cos by sampling y position;3;70;69;68;;1,1,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;151;-2617.993,-49.23526;Float;False;420.744;248.5178;Use Time as the parameter of sin;3;73;75;74;;1,1,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;144;-2700.487,-1060.482;Float;False;566.3591;309.0004;Offset sin/cos by sampling y position;3;65;67;66;;1,1,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;155;-2738.235,596.3049;Float;False;525.4728;266.9998;Use Time as the parameter of sin;3;97;96;98;;1,1,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;154;-2698.339,280.6297;Float;False;480.3054;306.334;Offset sin/cos by sampling y position;3;94;95;99;;1,1,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;140;-2678.678,-1685.749;Float;False;540;305;Offset sin/cos by sampling y position;3;115;112;111;;1,1,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;141;-2556.678,-1356.049;Float;False;417.0002;233.0001;Use Time as the parameter of sin;3;110;114;113;;1,1,1,1;0;0
Node;AmplifyShaderEditor.PosVertexDataNode;65;-2650.487,-930.4803;Float;False;0;0;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;75;-2553.124,84.28263;Float;False;Constant;_Float5;Float 5;0;0;Create;True;0;0;False;0;3;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.PosVertexDataNode;94;-2648.339,407.9637;Float;False;0;0;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.PosVertexDataNode;111;-2628.678,-1565.749;Float;False;0;0;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;67;-2602.299,-1010.481;Float;False;Constant;_Float2;Float 2;0;0;Create;True;0;0;False;0;7;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;95;-2627.041,330.6298;Float;False;Constant;_Float9;Float 9;0;0;Create;True;0;0;False;0;7;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.PosVertexDataNode;68;-2641.244,-237.0125;Float;False;0;0;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;97;-2611.761,748.3041;Float;False;Constant;_Float10;Float 10;0;0;Create;True;0;0;False;0;3;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;72;-2511.2,-584.4785;Float;False;Constant;_Float4;Float 4;0;0;Create;True;0;0;False;0;3;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleTimeNode;96;-2646.336,653.7228;Float;False;1;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;113;-2509.678,-1239.048;Float;False;Constant;_ScaleofTime;Scale of Time;0;0;Create;True;0;0;False;0;3;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleTimeNode;110;-2506.678,-1306.049;Float;False;1;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleTimeNode;41;-2527.2,-680.4791;Float;False;1;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleTimeNode;73;-2567.992,4.117359;Float;False;1;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;112;-2591.678,-1640.749;Float;False;Constant;_ScaleofY;Scale of Y;0;0;Create;True;0;0;False;0;7;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;70;-2595.302,-315.886;Float;False;Constant;_Float3;Float 3;0;0;Create;True;0;0;False;0;7;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;69;-2364.771,-240.7981;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;71;-2302.4,-660.0791;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;115;-2307.678,-1513.749;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;66;-2303.127,-906.6738;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;99;-2387.034,415.4257;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;114;-2308.677,-1305.049;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;74;-2366.248,0.7647893;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;157;-1514.322,488.7063;Float;False;702.6877;362.5927;Amplitude of Z offset, Y gets smaller, amplitude gets smaller.;5;138;139;132;134;137;;1,1,1,1;0;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;98;-2381.762,646.3049;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;143;-1505.595,-1618.932;Float;False;715.7107;369.9388;Amplitude of X offset, Y gets smaller, amplitude gets smaller.;5;120;131;136;135;130;;1,1,1,1;0;0
Node;AmplifyShaderEditor.PosVertexDataNode;131;-1455.595,-1568.932;Float;False;0;0;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.CommentaryNode;153;-1536.767,-408.851;Float;False;754.5266;450.0004;Amplitude of Z offset, Y gets smaller, amplitude gets bigger;4;62;63;77;78;;1,1,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;149;-1525.143,-935.002;Float;False;707.4647;465.1028;Amplitude of X offset, Y gets smaller, amplitude gets bigger;4;46;80;61;76;;1,1,1,1;0;0
Node;AmplifyShaderEditor.SimpleAddOpNode;54;-2040.998,-786.4793;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;57;-2094.558,-60.53677;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.PosVertexDataNode;138;-1464.322,538.7063;Float;False;0;0;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.PosVertexDataNode;135;-1452.606,-1427.994;Float;False;0;0;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleAddOpNode;100;-2107.442,585.98;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;116;-2062.677,-1418.749;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.PosVertexDataNode;137;-1459.791,672.2987;Float;False;0;0;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.PosVertexDataNode;46;-1396.391,-729.4203;Float;False;0;0;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SinOpNode;102;-1891.68,604.0825;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.PosVertexDataNode;63;-1278.634,-210.7333;Float;False;0;0;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;136;-1168.807,-1442.994;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;120;-1167.717,-1520.374;Float;False;Constant;_Float13;Float 13;0;0;Create;True;0;0;False;0;0.5;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.PosVertexDataNode;33;-2001.698,-1016.18;Float;False;0;0;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.CosOpNode;81;-1891.397,-786.0792;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;134;-1184.656,544.2555;Float;False;Constant;_Float11;Float 11;0;0;Create;True;0;0;False;0;0.5;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;139;-1158.217,699.3325;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;80;-1356.628,-584.8994;Float;False;Constant;_Float1;Float 1;0;0;Create;True;0;0;False;0;0.3;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.PosVertexDataNode;39;-1998.541,-209.3899;Float;False;0;0;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.PosVertexDataNode;76;-1475.143,-885.002;Float;False;0;0;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.PosVertexDataNode;101;-2036.565,395.2272;Float;False;0;0;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.PosVertexDataNode;117;-2053.876,-1674.65;Float;False;0;0;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SinOpNode;45;-1933.264,-63.38419;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.CosOpNode;118;-1904.676,-1418.749;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;78;-1256.767,-73.85069;Float;False;Constant;_Float0;Float 0;0;0;Create;True;0;0;False;0;0.3;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.PosVertexDataNode;77;-1486.767,-358.851;Float;False;0;0;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;62;-1021.441,-233.8118;Float;False;3;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;61;-986.6792,-853.4019;Float;False;3;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;119;-1724.194,-1243.886;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleDivideOpNode;130;-946.8843,-1458.696;Float;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;38;-1729.241,53.04052;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;148;-435.1086,-1287.63;Float;False;544.3301;421.2421;Control the movement of different parts of jellyfish;3;82;83;84;;1,1,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;158;-448.5675,-310.6091;Float;False;666.0221;409.6211;Control the movement of different parts of jellyfish;3;89;87;86;;1,1,1,1;0;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;103;-1700.092,302.4512;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;34;-1717.568,-1050.78;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleDivideOpNode;132;-968.6342,643.1609;Float;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.PosVertexDataNode;83;-385.1086,-1150.888;Float;False;0;0;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;84;-380.7176,-1237.63;Float;False;Constant;_Float6;Float 6;0;0;Create;True;0;0;False;0;-1.25;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.PosVertexDataNode;87;-398.5675,-174.6172;Float;False;0;0;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;86;-190.9253,-260.6091;Float;False;Constant;_Float7;Float 7;0;0;Create;True;0;0;False;0;-1.25;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;48;-666.9351,28.52606;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;47;-751.0567,-1050.033;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;109;-659.5866,320.0417;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;126;-749.4509,-1288.559;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ConditionalIfNode;89;19.4547,-102.988;Float;False;False;5;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ConditionalIfNode;82;-88.77863,-1068.387;Float;False;False;5;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.TransformPositionNode;164;53.76981,-1646.527;Float;False;Object;World;False;Fast;True;1;0;FLOAT3;0,0,0;False;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;161;-256.7536,-1624.735;Float;False;2;2;0;FLOAT;0;False;1;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.DynamicAppendNode;2;221.7347,-845.6068;Float;False;FLOAT4;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.RangedFloatNode;159;-549.1356,-1734.968;Float;False;Constant;_PositionScale;Position Scale;0;0;Create;True;0;0;False;0;4.72;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.NoiseGeneratorNode;160;330.0684,-1640.782;Float;False;Simplex2D;1;0;FLOAT2;0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.PosVertexDataNode;162;-554.082,-1643.237;Float;False;0;0;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;550.6318,-1146.175;Float;False;True;2;Float;ASEMaterialInspector;0;0;Standard;Jellyfish;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;Off;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Custom;0.5;True;True;0;False;TransparentCutout;;Transparent;All;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;True;0;0;False;-1;0;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;0;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;16;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;69;0;70;0
WireConnection;69;1;68;2
WireConnection;71;0;41;0
WireConnection;71;1;72;0
WireConnection;115;0;112;0
WireConnection;115;1;111;2
WireConnection;66;0;67;0
WireConnection;66;1;65;2
WireConnection;99;0;95;0
WireConnection;99;1;94;2
WireConnection;114;0;110;0
WireConnection;114;1;113;0
WireConnection;74;0;73;0
WireConnection;74;1;75;0
WireConnection;98;0;96;0
WireConnection;98;1;97;0
WireConnection;54;0;66;0
WireConnection;54;1;71;0
WireConnection;57;0;69;0
WireConnection;57;1;74;0
WireConnection;100;0;99;0
WireConnection;100;1;98;0
WireConnection;116;0;115;0
WireConnection;116;1;114;0
WireConnection;102;0;100;0
WireConnection;136;0;131;2
WireConnection;136;1;135;2
WireConnection;81;0;54;0
WireConnection;139;0;138;2
WireConnection;139;1;137;2
WireConnection;45;0;57;0
WireConnection;118;0;116;0
WireConnection;62;0;77;2
WireConnection;62;1;63;2
WireConnection;62;2;78;0
WireConnection;61;0;76;2
WireConnection;61;1;46;2
WireConnection;61;2;80;0
WireConnection;119;0;117;1
WireConnection;119;1;118;0
WireConnection;130;0;120;0
WireConnection;130;1;136;0
WireConnection;38;0;39;3
WireConnection;38;1;45;0
WireConnection;103;0;101;3
WireConnection;103;1;102;0
WireConnection;34;0;33;1
WireConnection;34;1;81;0
WireConnection;132;0;134;0
WireConnection;132;1;139;0
WireConnection;48;0;62;0
WireConnection;48;1;38;0
WireConnection;47;0;34;0
WireConnection;47;1;61;0
WireConnection;109;0;103;0
WireConnection;109;1;132;0
WireConnection;126;0;130;0
WireConnection;126;1;119;0
WireConnection;89;0;86;0
WireConnection;89;1;87;2
WireConnection;89;2;109;0
WireConnection;89;3;109;0
WireConnection;89;4;48;0
WireConnection;82;0;84;0
WireConnection;82;1;83;2
WireConnection;82;2;126;0
WireConnection;82;3;126;0
WireConnection;82;4;47;0
WireConnection;164;0;161;0
WireConnection;161;0;159;0
WireConnection;161;1;162;0
WireConnection;2;0;82;0
WireConnection;2;2;89;0
WireConnection;0;11;2;0
ASEEND*/
//CHKSM=684FA0692E4E6AF96DA4BBD3D06D6BF828C9BB10