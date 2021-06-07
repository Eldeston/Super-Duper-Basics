#include "/lib/util.glsl"
#include "/lib/settings.glsl"
#include "/lib/globalVar.glsl"

#include "/lib/globalSamplers.glsl"

#include "/lib/lighting/shdDistort.glsl"
#include "/lib/vertexWave.glsl"

INOUT float blockId;

INOUT vec2 texcoord;

INOUT vec3 worldPos;

INOUT vec4 color;

#ifdef VERTEX
    attribute vec2 mc_midTexCoord;
    attribute vec4 mc_Entity;

    void main(){
        vec4 vertexPos = shadowModelViewInverse * (shadowProjectionInverse * ftransform());
        worldPos = vertexPos.xyz + cameraPosition;

        texcoord = (gl_TextureMatrix[0] * gl_MultiTexCoord0).xy;
        blockId = mc_Entity.x;
        
        #ifdef ANIMATE
            getWave(vertexPos.xyz, worldPos, texcoord, mc_midTexCoord, mc_Entity.x);
        #endif

        gl_Position = shadowProjection * (shadowModelView * vertexPos);

        gl_Position.xyz = distort(gl_Position.xyz);

        #ifndef RENDER_FOLIAGE_SHD
            if(mc_Entity.x == 10001.0 || mc_Entity.x == 10002.0 || mc_Entity.x == 10003.0 || mc_Entity.x == 10004.0 || mc_Entity.x == 10007.0 || mc_Entity.x == 10011.0 || mc_Entity.x == 10013.0)
                gl_Position = vec4(10);
        #endif

        color = gl_Color;
    }
#endif

#ifdef FRAGMENT
    uniform sampler2D tex;

    void main(){
        vec4 shdColor = texture2D(tex, texcoord);
        shdColor.rgb *= color.rgb;

    /* DRAWBUFFERS:0 */
        gl_FragData[0] = shdColor;
    }
#endif