#version 440

layout(location = 0) in vec2 qt_TexCoord0;
layout(location = 0) out vec4 fragColor;

layout(binding = 0) uniform sampler2D source;

float random(vec2 p)
{
    return fract(sin(dot(p, vec2(12.9898, 78.233))) * 43758.5453);
}

void main()
{
    vec2 uv = qt_TexCoord0;

    vec4 color = texture(source, uv);

    float noise = random(uv * 500.0);

    color.rgb += (noise - 0.5) * 0.15;

    fragColor = color;
}
