shader_type canvas_item;

uniform float progress : hint_range(0, 1);
uniform float block_size = 1;
uniform vec4 color : source_color;

float random(vec2 uv) {
    return fract(sin(dot(uv, vec2(12.9898, 78.233))) * 438.5453);
}

void fragment() {
	vec2 uv_snapped = floor(UV / TEXTURE_PIXEL_SIZE / vec2(block_size));
	COLOR = color;
	COLOR.a *= step(progress, random(uv_snapped));
}
