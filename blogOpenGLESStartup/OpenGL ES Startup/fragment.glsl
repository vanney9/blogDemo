#version 300 es

in highp vec2 TexCoord;
out lowp vec4 color;

uniform lowp sampler2D ourTexture1;
uniform lowp sampler2D ourTexture2;

void main() {
    //color = vec4(1.0f, 0.5f, 0.2f, 1.0f);
    color = mix(texture(ourTexture1, TexCoord), texture(ourTexture2, TexCoord), 0.2);
}
