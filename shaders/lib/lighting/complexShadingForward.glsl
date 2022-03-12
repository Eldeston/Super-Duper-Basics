#ifdef WORLD_LIGHT
	uniform float shdFade;
#endif

uniform sampler2D lightmap;

vec4 complexShadingGbuffers(matPBR material, positionVectors posVector, float dither){
	#ifdef WORLD_SKYLIGHT_AMOUNT
		material.light.y = WORLD_SKYLIGHT_AMOUNT;
	#endif

	vec3 lightMapTex = pow(texture2D(lightmap, material.light).rgb, vec3(GAMMA)) * material.ambient;
	vec3 totalDiffuse = material.albedo.rgb * (lightMapTex + material.emissive * EMISSIVE_INTENSITY);

	return vec4(totalDiffuse, material.albedo.a);
}