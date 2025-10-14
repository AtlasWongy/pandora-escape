shader_type canvas_item;

//uniform vec4 color = vec4(1.0, 1.0, 1.0, 1.0);

//void vertext() {}

//void fragment() { COLOR = color; }
uniform vec4 new_color : source_color;
uniform float tolerance : hint_range(0.0, 1.0) = 0.05;

void fragment() {
    vec4 tex_color = texture(TEXTURE, UV);

    bool is_white = distance(tex_color.rgb, vec3(1.0)) < tolerance;

    if (is_white) {
        COLOR = tex_color;
    } 
    else {
        COLOR = new_color * tex_color.a;
    }
}
