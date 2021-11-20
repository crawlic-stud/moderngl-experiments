#version 430

out vec4 fragColor;

uniform vec2 resolution;
uniform float time;

vec2 rotate2D(vec2 uv, float a) {
    float s = sin(a);
    float c = cos(a);
    return mat2(c, -s, s, c) * uv;
}

vec2 random(float t) {
    float x = fract(sin(t * 3453.329));
    float y = fract(sin((t + x) * 8532.732));
    return vec2(x, y);
}

void main() {
    vec2 uv = (gl_FragCoord.xy - 0.5 * resolution.xy) / resolution.y;
    vec3 col = vec3(0.0);

    // uv = rotate2D(uv, 3.14 / 2);

    float r = 0.17;
    float max_i = 360.0;
    int scale_factor = 10;
    for (float i=0.0; i < max_i; i++) {

        float factor = ((sin(time) * 0.5 + 0.5) + 0.3) / 100;
        i += factor;

        float a = i / scale_factor;

        // cardioid:
        // float dx = 2 * r * cos(a) - r * cos(2 * a);
        // float dy = 2 * r * sin(a) - r * sin(2 * a);

        // spiral:
        // float dx = a * sin(a) / 50;
        // float dy = a * cos(a) / 50;

        // some sort of star:
        // float dx = 4.4 * (cos(a) + cos(1.1 * a) / 1.1) / 20;
        // float dy = 4.4 * (sin(a) - sin(1.1 * a) / 1.1) / 20;

        // another star:
        // scale_factor = 20
        // float dx = 24.8 * (cos(a) + cos(6.2 * a) / 6.2) / 70;
        // float dy = 24.8 * (sin(a) - sin(6.2 * a) / 6.2) / 70;

        // infinity sign:
        float dx = sin(a + 3.14 / 2) / 1.5;
        float dy = sin(2 * a) / 3;

        // heart:
        // float dx = 16 * pow(sin(a), 3.0) / 50;
        // float dy = (13 * cos(a) - 5 * cos(2 * a) - 2 * cos(3 * a) - cos(4 * a)) / 50;

        // with shake:
        // col += 0.005 * factor / length(uv - vec2(dx - 0.5, dy) - 0.02 * random(i));

        // without shake
        // col += 0.0005 * factor / length(uv - vec2(dx + 0.1, dy));
        col += 0.001 / length(uv - vec2(dx, dy));
    }

    // color change
    col *= sin(vec3(0.2, 0.8, 0.9) * time) * 0.15 + 0.25;
    fragColor = vec4(col, 1.0);
}
