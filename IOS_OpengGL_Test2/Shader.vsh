attribute vec4 position;
attribute vec2 textureCoordinates;
uniform mat4 matrix;
varying vec2 fragmentTextureCoordinates;
#define add(a, b) ( a+b )
void main()
{
    gl_Position = matrix * position;
    fragmentTextureCoordinates =textureCoordinates.xy*2.;
    
}