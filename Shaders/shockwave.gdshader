shader_type canvas_item;

// This texture allows us to read the screen behind this object
uniform sampler2D screen_texture : hint_screen_texture, filter_linear_mipmap;

// The center of the shockwave (Normalized 0.0 to 1.0)
uniform vec2 center;
uniform float force;
uniform float size;
uniform float thickness;

void fragment() {
    // Calculate aspect ratio so the circle isn't squashed
    float ratio = SCREEN_PIXEL_SIZE.x / SCREEN_PIXEL_SIZE.y;
    vec2 scaledUV = (SCREEN_UV - vec2(0.5, 0.0)) / vec2(ratio, 1.0) + vec2(0.5, 0.0);
    
    // We must also adjust the center position to match the aspect ratio correction
    vec2 scaledCenter = (center - vec2(0.5, 0.0)) / vec2(ratio, 1.0) + vec2(0.5, 0.0);
    
    // Calculate the mask (the ring shape)
    float mask = (1.0 - smoothstep(size - 0.1, size, length(scaledUV - scaledCenter))) *
                 smoothstep(size - thickness - 0.1, size - thickness, length(scaledUV - scaledCenter));
    
    // Calculate displacement
    vec2 disp = normalize(scaledUV - scaledCenter) * force * mask;
    
    // Output the distorted screen texture
    COLOR = texture(screen_texture, SCREEN_UV - disp);
}