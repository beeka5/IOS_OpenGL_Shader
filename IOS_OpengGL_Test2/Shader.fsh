uniform sampler2D texture,texture2;
uniform highp vec2 uResolution;
varying mediump vec2 fragmentTextureCoordinates;

#define kBlendModeDifference 1

#define kBlendModeOverlay    2

#define BlendOverlay(a, b) ( (b<0.5) ? (2.0*b*a) : (1.0-2.0*(1.0-a)*(1.0-b)) )



uniform highp int blendMode;

void main()
{
    
    
//    blendMode=3;
    lowp vec4 sourceColor = texture2D(texture,fragmentTextureCoordinates);
    lowp vec4 destColor = texture2D(texture2,fragmentTextureCoordinates);


    
    if (blendMode == kBlendModeDifference) {
    
        gl_FragColor = sourceColor;
        
    } else if (blendMode == kBlendModeOverlay) {
    
        gl_FragColor.r = BlendOverlay(sourceColor.r, destColor.r);
//
        gl_FragColor.g = BlendOverlay(sourceColor.g, destColor.g);
//
        gl_FragColor.b = BlendOverlay(sourceColor.b, destColor.b);
//
        gl_FragColor.a = sourceColor.a;
        
    } else { // normal blending
//
        //direct color filling
        gl_FragColor = vec4(255,255,255,1.0);
        
//      fill gradient
//       lowp vec2 position =  gl_FragCoord.xy/uResolution;
//        lowp float gradient = position.x;
//        gl_FragColor = vec4(0., fragmentTextureCoordinates.x, 0., 1.);

//        create circle fill
//       lowp vec2 center = vec2(0.5, 0.5);
//        
//        // 2
//       lowp float radius = 0.5;
//        
//        // 3
//       lowp vec2 position = fragmentTextureCoordinates.xy-center;
//        
//        // 4
//        if (length(position) > radius) {
//            gl_FragColor = vec4(vec3(0.), 1.);
//        } else {
//            gl_FragColor = vec4(vec3(1.), 1.);
//        }
//
    }
}
