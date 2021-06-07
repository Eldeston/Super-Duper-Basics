#include "/lib/util.glsl"
#include "/lib/structs.glsl"
#include "/lib/settings.glsl"

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
    uniform sampler2D tex;

    void main(){
        vec4 shdColor = texture2D(tex, texcoord);
        shdColor.rgb *= glcolor.rgb;

    /* DRAWBUFFERS:0 */
        gl_FragData[0] = shdColor;
    }
#endif