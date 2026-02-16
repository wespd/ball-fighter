shader_type canvas_item;

uniform float force : hint_range(0.0, 1.0, 0.001);
uniform vec2 center;
uniform float mask_radius;
uniform float edge_size_multiplier;
uniform sampler2D SCREEN_TEXTURE : hint_screen_texture, filter_linear_mipmap;

void fragment() {
	float ratio = SCREEN_PIXEL_SIZE.x / SCREEN_PIXEL_SIZE.y;
	ratio = 1.0;
	vec2 scaled_uv = (SCREEN_UV - vec2(0.5, 0.0)) / vec2(ratio, 1.0) + vec2(0.5,0.0);
	float mask = (1.0 - smoothstep(mask_radius - 0.1, mask_radius, length(UV - center))) * 
			smoothstep(mask_radius -0.2, mask_radius -0.1, length(UV - center));
	vec2 disp = normalize(scaled_uv - center) * force * mask;
	COLOR = texture(SCREEN_TEXTURE, SCREEN_UV - disp);
}
