shader_type canvas_item;

uniform vec2 resolution = vec2(1280.0, 720.0);
uniform int n = 8;
uniform int colors = 4;
uniform float spread = 2.0;

const int bayer2[] = {
    0, 2,
    3, 1
};

const int bayer4[] = {
    0, 8, 2, 10,
    12, 4, 14, 6,
    3, 11, 1, 9,
    15, 7, 13, 5
};

const int bayer8[] = {
    0, 32, 8, 40, 2, 34, 10, 42,
    48, 16, 56, 24, 50, 18, 58, 26,  
    12, 44,  4, 36, 14, 46,  6, 38, 
    60, 28, 52, 20, 62, 30, 54, 22,  
    3, 35, 11, 43,  1, 33,  9, 41,  
    51, 19, 59, 27, 49, 17, 57, 25, 
    15, 47,  7, 39, 13, 45,  5, 37, 
    63, 31, 55, 23, 61, 29, 53, 21
};
void fragment() {
	int x = int(UV.x * resolution.x);
	int y = int(UV.y * resolution.y);
	
	x = x % n;
	y = y % n;
	float M;
	if (n == 2)
		M = float(bayer2[x*n + y]) / pow(float(n), 2.0);
	else if (n == 4)
		M = float(bayer4[x*n + y]) / pow(float(n), 2.0);
	else if (n == 8)
		M = float(bayer8[x*n + y]) / pow(float(n), 2.0);
	
	M -= 0.5;
	vec4 color = COLOR + vec4(M * spread, M * spread, M * spread, 0.0);
	color = floor(color * float(colors - 1) + 0.5) / float(colors - 1);
	COLOR = color;
}
