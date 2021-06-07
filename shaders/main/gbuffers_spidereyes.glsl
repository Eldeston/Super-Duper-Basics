#include "/lib/utility/util.glsl"
#include "/lib/structs.glsl"
#include "/lib/settings.glsl"

#include "/lib/globalVars/constants.glsl"

INOUT vec2 texcoord;
INOUT vec4 glcolor;

#ifdef VERTEX
    void main(){
        gl_Position = ftransform();
        texcoord = (gl_TextureMatrix[0] * gl_MultiTexCoord0).xy;
        glcolor = gl_Color;
    }
#endif

#ifdef FRAGMENT
    uniform sampler2D texture;

    void main(){
        vec4 color = texture2D(texture, texcoord);
        color.rgb *= glcolor.rgb;

        if(color.a < 0.01) discard;

    /* DRAWBUFFERS:0 */
        gl_FragData[0] = color; //gcolor
    }
#endif