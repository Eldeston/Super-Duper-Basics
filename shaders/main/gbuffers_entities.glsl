#include "/lib/utility/util.glsl"
#include "/lib/structs.glsl"
#include "/lib/settings.glsl"

#include "/lib/globalVars/constants.glsl"

#include "/lib/lighting/PBR.glsl"

INOUT vec2 texcoord;

INOUT vec4 glcolor;

#ifdef VERTEX
    void main(){
        vec4 vertexPos = gl_ModelViewMatrix * gl_Vertex;

        texcoord = (gl_TextureMatrix[0] * gl_MultiTexCoord0).xy;
        
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