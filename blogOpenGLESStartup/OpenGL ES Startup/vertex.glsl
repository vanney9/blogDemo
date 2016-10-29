#version 300 es

layout (location = 0) in vec3 position;
layout (location = 3) in highp vec2 texCoord;

out highp vec2 TexCoord;

uniform mat4 model;
uniform mat4 view;
uniform mat4 projection;

void main() {
    gl_Position = projection * view * model * vec4(position, 1.0f);
    //gl_Position = projection * vec4(position, 1.0f);
    TexCoord = vec2(texCoord.x, 1.0f - texCoord.y);
    //TexCoord = vec2(0.5, 0.7);
}
