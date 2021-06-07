#include "/lib/util.glsl"
#include "/lib/structs.glsl"
#include "/lib/settings.glsl"
#include "/lib/globalVar.glsl"

#include "/lib/globalSamplers.glsl"

#include "/lib/vertexWave.glsl"
#include "/lib/PBR.glsl"

INOUT float blockId;

INOUT vec2 lmcoord;
INOUT vec2 texcoord;

INOUT vec3 norm;
INOUT vec3 worldPos;

INOUT vec4 glcolor;

#ifdef VERTEX
    attribute vec2 mc_midTexCoord;

    attribute vec4 mc_Entity;
    attribute vec4 at_tangent;

    void main(){
        vec4 vertexPos = gl_ModelViewMatrix * gl_Vertex;

        texcoord = (gl_TextureMatrix[0] * gl_MultiTexCoord0).xy;
        lmcoord  = (gl_TextureMatrix[1] * gl_MultiTexCoord1).xy;
        blockId = mc_Entity.x;

	    norm = normalize(gl_NormalMatrix * gl_Normal);
        
	    gl_Position = gl_ProjectionMatrix * vertexPos;

        glcolor = gl_Color;
    }
#endif

#ifdef FRAGMENT
    uniform sampler2D texture;

    void main(){
        vec4 color = texture2D(texture, texcoord);
        color.rgb *= glcolor;

    /* DRAWBUFFERS:0 */
        gl_FragData[0] = color; //gcolor
    }
#endif