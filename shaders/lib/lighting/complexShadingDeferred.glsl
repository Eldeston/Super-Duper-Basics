vec3 complexShadingDeferred(matPBR material, positionVectors posVector, vec3 sceneCol, vec3 dither){
	// If smoothness is 0, don't do reflections
	if(material.smoothness > 0.005){
		bool isMetal = material.metallic > 0.9;

		// Get fresnel
		vec3 fresnel = getFresnelSchlick(max(dot(material.normal, normalize(-posVector.eyePlayerPos)), 0.0),
			isMetal ? material.albedo.rgb : vec3(material.metallic)) * material.smoothness;

		// Get SSR
		#ifdef SSR
			// Get model view normal
			vec3 gBMVNorm = mat3(gbufferModelView) * material.normal;

			#ifdef ROUGH_REFLECTIONS
				// Rough the normals with noise
				gBMVNorm = normalize(gBMVNorm + (dither * 0.8 - 0.4) * squared(1.0 - material.smoothness));

				// Assign new rough normals
				material.normal = mat3(gbufferModelViewInverse) * gBMVNorm;
			#endif

			// Get SSR
			vec4 SSRCol = getSSRCol(posVector.viewPos, posVector.screenPos, gBMVNorm);

			vec3 reflectCol = getSkyRender(vec3(0), normalize(reflect(posVector.eyePlayerPos, material.normal)), true);
			reflectCol = mix(reflectCol, SSRCol.rgb, SSRCol.a);
		#else
			vec3 reflectCol = getSkyRender(vec3(0), normalize(reflect(posVector.eyePlayerPos, material.normal)), true);
		#endif

		// Simplified and modified version of BSL's reflection PBR calculation
		sceneCol *= 1.0 - (isMetal ? vec3(material.smoothness) : fresnel);
		sceneCol += reflectCol * fresnel;
	}

	return sceneCol;
}