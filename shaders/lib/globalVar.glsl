#define PI 3.14159265359
#define PI2 6.28318530718

uniform int isEyeInWater;

uniform float viewWidth;
uniform float viewHeight;

// Get frame time
uniform float frameTime;
uniform float frameTimeCounter;

// Get world time
uniform float adjustedTime;
uniform float day;
uniform float night;
uniform float dawnDusk;
uniform float twilight;
uniform float nightVision;
uniform float blindness;
uniform float rainStrength;

uniform float far;

uniform ivec2 eyeBrightnessSmooth;

// Position uniforms
uniform vec3 cameraPosition;
uniform vec3 previousCameraPosition;
uniform vec3 shadowLightPosition;

// Vec3 color uniforms
uniform vec3 fogColor;
uniform vec4 entityColor;

// View matrix uniforms
uniform mat4 gbufferModelView;
uniform mat4 gbufferModelViewInverse;
uniform mat4 gbufferPreviousModelView;

// Projection matrix uniforms
uniform mat4 gbufferProjection;
uniform mat4 gbufferProjectionInverse;
uniform mat4 gbufferPreviousProjection;

// Shadow view matrix uniforms
uniform mat4 shadowModelView;
uniform mat4 shadowModelViewInverse;

// Shadow projection matrix uniforms
uniform mat4 shadowProjection;
uniform mat4 shadowProjectionInverse;

// Enable mipmap filtering on shadows
const bool shadowHardwareFiltering = true;

const int shadowMapResolution = 1024; // Shadow map resolution [512 1024 1536 2048 2560 3072 3584 4096 4608 5120]
// Shadow noise tile
const int shdNoiseTile = 128;

// Lm noise tile
const int lmNoiseTile = 16;

const float sunPathRotation = 45.0; // Light/sun/moon angle by degrees [-63.0 -54.0 -45.0 -36.0 -27.0 -18.0 -9.0 0.0 9.0 18.0 27.0 36.0 45.0 54.0 63.0]

float eyeBrightFact = eyeBrightnessSmooth.y / 240.0;

float newDawnDusk = smoothstep(0.32, 0.96, dawnDusk);
float newTwilight = smoothstep(0.64, 0.96, twilight);

vec3 skyCol = toneSaturation(mix(mix(SKY_COL_NIGHT, SKY_COL_DAY, day), SKY_COL_DAWN_DUSK, newDawnDusk), 1.0 - rainStrength);
vec3 lightCol = mix(mix(LIGHT_COL_NIGHT, LIGHT_COL_DAY, day), LIGHT_COL_DAWN_DUSK, newDawnDusk) * (1.0 - rainStrength * 0.5);