#ifdef WORLD_LIGHT
	uniform float shdFade;
#endif

vec4 complexShadingGbuffers(matPBR material, positionVectors posVector, float dither){
	#ifdef WORLD_SKYLIGHT_AMOUNT
		material.light.y = WORLD_SKYLIGHT_AMOUNT;
	#endif

	return material.albedo;
}