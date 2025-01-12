shader_type canvas_item;

uniform sampler2D depth_map; // The depth map texture
uniform vec2 light_position; // Position of the flashlight in screen space
uniform vec2 resolution;     // Screen resolution
uniform float dimming_factor : hint_range(0.0, 10.0); // Controls the dimming effect intensity

void fragment() {
    // Convert the UV to screen coordinates
    vec2 screen_uv = FRAGCOORD.xy / resolution;

    // Compute the depth at this fragment
    float depth_value = texture(depth_map, screen_uv).r;

    // Calculate the distance from the light source
    vec2 light_screen_pos = light_position / resolution;
    float distance = length(screen_uv - light_screen_pos);

    // Dim the light based on distance and depth
    float dimming = clamp(1.0 - dimming_factor * distance * depth_value, 0.0, 1.0);

    // Apply the dimming effect to the current light fragment
    COLOR *= vec4(dimming, dimming, dimming, 1.0);
}
