#include "/lib/util.glsl"
#include "/lib/structs.glsl"
#include "/lib/settings.glsl"
#include "/lib/globalVar.glsl"

#include "/lib/globalSamplers.glsl"

INOUT vec2 texcoord;

INOUT vec3 norm;

INOUT vec4 glcolor;

#ifdef VERTEX
    void main(){
        gl_Position = ftransform();

        texcoord = (gl_TextureMatrix[0] * gl_MultiTexCoord0).xy;

        norm = normalize(gl_NormalMatrix * gl_Normal);

        glcolor = gl_Color;
    }
#endif

#ifdef FRAGMENT
    uniform sampler2D texture;

    void main(){
        vec4 color = texture2D(texture, texcoord);
        color.rgb *= glcolor.rgb;

    /* DRAWBUFFERS:0 */
        gl_FragData[0] = color; //gcolor
    }
#endif