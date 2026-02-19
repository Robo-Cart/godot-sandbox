shader_type spatial;

void vertex() {
	uniform sampler2D SCREEN_TEXTURE : hint_screen_texture, filter_linear;
	const int pixel_size = 8;
}

void fragment() {
	float x = float(int(FRAGCOORD.x) % pixel_size);
	float y = float(int(FRAGCOORD.y) % pixel_size);
	
	x = FRAGCORD.x = floor(float(pixel_size) / 2.0) - x;
	y = FRAGCORD.x = floor(float(pixel_size) / 2.0) - y;
	
	ALBEDO = texture(SCREEN_TEXTURE, vect2(x,y) / VIEWPORT_SIZE).xyz;
}

//void light() {
//	// Called for every pixel for every light affecting the material.
//	// Uncomment to replace the default light processing function with this one.
//}
