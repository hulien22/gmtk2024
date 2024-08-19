shader_type canvas_item;

uniform sampler2D SCREEN_TEXTURE: hint_screen_texture, filter_linear_mipmap;
//
//float rand(float x) { return fract(sin(x) * 43758.5453);}
//float triangle(float x) { return abs(1.0 - mod(abs(x), 2.0)) * 2.0 - 1.0;}
//
//void fragment(){
//float time = floor(TIME * 16.0) / 16.0;
//vec2 uv = UV; vec2 p = uv;
//p += vec2(triangle(p.y * rand(time) *4.0) * rand(time * 1.9) * 0.015,
//triangle(p.x * rand(time * 3.4) * 4.0) * rand(time * 2.1) * 0.015);
//p += vec2 (rand(p.x * 3.1 + p.y * 8.7) * 0.01,
//rand(p.x * 1.1 + p.y * 6.7) * 0.01);
//
//vec4 baseColor = vec4(texture(SCREEN_TEXTURE, uv).rgb, 1.0);
//vec4 edges = vec4(1.2) - (baseColor / vec4(texture(SCREEN_TEXTURE,p).rgb,1.0));
//baseColor.rgb = vec3(baseColor.r);
//COLOR = baseColor / vec4(length(edges));
//
//}

uniform vec4 u_bgColor = vec4(1.0, 1.0, 1.0, 1.0);
uniform float u_bgColorFactor: hint_range(0.0, 1.0) = 0.4;
uniform vec4 u_patternColor = vec4(0.0, 0.0, 0.0, 1.0);

uniform float u_threshold1: hint_range(0.0, 1.0) = 0.75;
uniform float u_threshold2: hint_range(0.0, 1.0) = 0.50;
uniform float u_threshold3: hint_range(0.0, 1.0) = 0.25;
uniform float u_threshold4: hint_range(0.0, 1.0) = 0.05;

uniform vec2 u_bgTiling = vec2(1.0, 1.0);
uniform vec2 u_patternTiling = vec2(1.0, 1.0);

uniform sampler2D u_bgTexture;
uniform sampler2D u_patternTexture;

const float C2_SQRT2 = 0.707106781;
const mat2 ROT_45 = mat2(vec2(C2_SQRT2, -C2_SQRT2), vec2(C2_SQRT2, C2_SQRT2));
const vec4 COLOR_WHITE = vec4(1.0, 1.0, 1.0, 1.0);

float getIntensity(vec3 color)
{
return 0.299*color.r + 0.587*color.g + 0.114*color.b;
}

vec4 getPatternColor(vec2 uv, float intensity)
{
vec2 patternUV1 = fract(vec2(-uv.x, uv.y) * u_patternTiling);
vec2 patternUV2 = fract(uv * u_patternTiling);
vec2 patternUV3 = fract(ROT_45*(uv + vec2(0.2358, 0.9123)) * u_patternTiling);
vec2 patternUV4 = fract((vec2(uv.x, -uv.y) + vec2(0.4123, 0.7218)) * u_patternTiling);
vec4 pCol1 = texture(u_patternTexture, patternUV1);
vec4 pCol2 = texture(u_patternTexture, patternUV2);
vec4 pCol3 = texture(u_patternTexture, patternUV3);
vec4 pCol4 = texture(u_patternTexture, patternUV4);

if(intensity > u_threshold1)
return vec4(1.0, 1.0, 1.0, 1.0);
if(intensity > u_threshold2)
return mix(pCol1, COLOR_WHITE, 0.5);
if(intensity > u_threshold3)
return mix(pCol1*pCol2, COLOR_WHITE, 0.3);
if(intensity > u_threshold4)
return mix(pCol1*pCol2*pCol3, COLOR_WHITE, 0.1);
return pCol1*pCol2*pCol3*pCol4*0.8;
}

void fragment()
{
vec4 origColor = texture(SCREEN_TEXTURE, SCREEN_UV);
float intensity = getIntensity(origColor.rgb);
//vec4 bgColor = mix(texture(u_bgTexture, fract(UV*u_bgTiling)), u_bgColor, u_bgColorFactor);

//float time = TIME * 1000.0;
//vec4 bgColor;
//if (int(time) % 1000 > 500) {
	//bgColor = mix(texture(u_bgTexture, fract(UV*u_bgTiling)), origColor, u_bgColorFactor);
//} else {
	//bgColor = mix(texture(u_patternTexture, fract(UV*u_patternTiling)), origColor, u_bgColorFactor);
//}
vec4 bgColor = mix(texture(u_bgTexture, fract(UV*u_bgTiling)), origColor, u_bgColorFactor);


//vec4 patternColor = getPatternColor(UV, intensity);
vec4 patternColor = vec4(1.0, 1.0, 1.0, 1.0);
vec4 color = mix(u_patternColor, bgColor, getIntensity(patternColor.rgb));
COLOR = color;
}