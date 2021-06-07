// Enable mipmap filtering on shadows
const bool shadowHardwareFiltering = true;

const int RGBA1 = 1;

const int RGB8 = 1;
const int RGB16 = 1;

const int RGB16F = 1;
const int RGBA16F = 1;

/* Buffer texture settings */
const int gcolorFormat = RGBA16F;

// Default resolution
const int noiseTextureResolution = 256;

const int shadowMapResolution = 1024; // Shadow map resolution [512 1024 1536 2048 2560 3072 3584 4096 4608 5120]

// Default AO
const float ambientOcclusionLevel = 1.0;

const float sunPathRotation = 45.0; // Light/sun/moon angle by degrees [-63.0 -54.0 -45.0 -36.0 -27.0 -18.0 -9.0 0.0 9.0 18.0 27.0 36.0 45.0 54.0 63.0]

// Shadow bias
const float shdBias = 0.021; // Don't go below the default value otherwise it'll mess up lighting