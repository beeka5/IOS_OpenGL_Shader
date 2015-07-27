attribute vec4 position;
attribute vec2 textureCoordinates;
uniform mat4 modelViewMatrix;
uniform mat4 projectionMatrix;
varying vec2 fragmentTextureCoordinates;

void main()
{
    gl_Position = projectionMatrix * modelViewMatrix * position;
    fragmentTextureCoordinates =textureCoordinates;
    
}