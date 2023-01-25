Shader "BasicBlending" {
    Properties {
        _BaseColor ("Base Color", Color) = (1, 1, 1, 1)

        [Enum(UnityEngine.Rendering.BlendMode)] 
        _SrcBlend("Source Blend Factor", Int) = 1

        [Enum(UnityEngine.Rendering.BlendMode)] 
        _DstBlend("Destination Blend Factor", Int) = 1
    }
    SubShader {
        Tags { 
            "RenderType" = "Transparent"
            "Queue" = "Transparent"
            "RenderPipeline" = "UniversalPipeline"
        }

        Pass {
            Blend [_SrcBlend] [_DstBlend]

            Tags {
                "LightMode" = "UniversalForward"
            }

            HLSLPROGRAM
            #pragma vertex vert
            #pragma fragment frag

            #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Core.hlsl"

            struct appdata {
                float4 positionOS : Position;
                float2 uv : TEXCOORD0;
            };

            struct v2f {
                float4 positionCS : SV_Position;
                float2 uv : TEXCOORD0;
            };

            sampler2D _BaseTex;

            CBUFFER_START(UnityPerMaterial)
                float4 _BaseColor;
            CBUFFER_END

            v2f vert (appdata v) {
                v2f o;
                o.positionCS = TransformObjectToHClip(v.positionOS.xyz);
                o.uv = v.uv;
                return o;
            }

            float4 frag (v2f i) : SV_Target {
                return _BaseColor;
            }
            ENDHLSL
        }
    }
    Fallback Off
}