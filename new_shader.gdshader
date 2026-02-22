shader_type canvas_item;

uniform float radius : hint_range(0.0, 1.0) = 1.0;
uniform vec2 center = vec2(0.5, 0.5);
uniform vec4 transition_color : source_color = vec4(0.0, 0.0, 0.0, 1.0);

void fragment() {
    float dist = distance(UV, center);

    if (dist > radius) {
        COLOR = transition_color; // Outside circle (covering screen)
    } else {
        COLOR = vec4(0.0, 0.0, 0.0, 0.0); // Transparent hole
    }
}