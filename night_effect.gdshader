shader_type canvas_item;

uniform sampler2D screen_texture : hint_screen_texture, repeat_disable, filter_nearest;

uniform float Red: hint_range(-255, 255, 1);
uniform float Green: hint_range(-255, 255, 1);
uniform float Blue: hint_range(-255, 255, 1);

void fragment() {
	vec4 chosen_col = texture(screen_texture, SCREEN_UV);
	
	float red = (chosen_col.r * Red / 255.0);
	float green = (chosen_col.g * Green / 255.0);
	float blue = (chosen_col.b * Blue / 255.0);
	
	COLOR.rgb = chosen_col.rgb + vec3(red, green, blue);
}