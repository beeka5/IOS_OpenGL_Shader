#import "GLViewController.h"
#import "GLProgram.h"
#import "GLView.h"
#import "GLCommon.h"
#import "GLTexture.h"

static const Vertex3D planeFan[] =
{
    {1,0,1},
    {1,0,-1},
    {-1,0,-1},
    {-1,0,1},
    
};

const ushort indices[]={
    0,1,2,
    3,0,2,
};
static const Vertex3D plane[] =
{
    {1,0,1},
    {1,0,-1},
    {-1,0,-1},
    
    {-1,0,-1},
    {-1,0,1},
    {1,0,1},
    
};

static  TextureCoord plane_texCod[] =
{
    {1,0},
    {1,1},
    {0,1},
    
    {0,1},
    {0,0},
    {1,0},
};
static const Vertex3D vertices[] =
{
    {-0.276385, -0.850640, -0.447215},
    {0.000000, 0.000000, -1.000000},
    {0.723600, -0.525720, -0.447215},
    {0.723600, -0.525720, -0.447215},
    {0.000000, 0.000000, -1.000000},
    {0.723600, 0.525720, -0.447215},
    {-0.894425, 0.000000, -0.447215},
    {0.000000, 0.000000, -1.000000},
    {-0.276385, -0.850640, -0.447215},
    {-0.276385, 0.850640, -0.447215},
    {0.000000, 0.000000, -1.000000},
    {-0.894425, 0.000000, -0.447215},
    {0.723600, 0.525720, -0.447215},
    {0.000000, 0.000000, -1.000000},
    {-0.276385, 0.850640, -0.447215},
    {0.723600, -0.525720, -0.447215},
    {0.723600, 0.525720, -0.447215},
    {0.894425, 0.000000, 0.447215},
    {-0.276385, -0.850640, -0.447215},
    {0.723600, -0.525720, -0.447215},
    {0.276385, -0.850640, 0.447215},
    {-0.894425, 0.000000, -0.447215},
    {-0.276385, -0.850640, -0.447215},
    {-0.723600, -0.525720, 0.447215},
    {-0.276385, 0.850640, -0.447215},
    {-0.894425, 0.000000, -0.447215},
    {-0.723600, 0.525720, 0.447215},
    {0.723600, 0.525720, -0.447215},
    {-0.276385, 0.850640, -0.447215},
    {0.276385, 0.850640, 0.447215},
    {0.894425, 0.000000, 0.447215},
    {0.276385, -0.850640, 0.447215},
    {0.723600, -0.525720, -0.447215},
    {0.276385, -0.850640, 0.447215},
    {-0.723600, -0.525720, 0.447215},
    {-0.276385, -0.850640, -0.447215},
    {-0.723600, -0.525720, 0.447215},
    {-0.723600, 0.525720, 0.447215},
    {-0.894425, 0.000000, -0.447215},
    {-0.723600, 0.525720, 0.447215},
    {0.276385, 0.850640, 0.447215},
    {-0.276385, 0.850640, -0.447215},
    {0.276385, 0.850640, 0.447215},
    {0.894425, 0.000000, 0.447215},
    {0.723600, 0.525720, -0.447215},
    {0.276385, -0.850640, 0.447215},
    {0.894425, 0.000000, 0.447215},
    {0.000000, 0.000000, 1.000000},
    {-0.723600, -0.525720, 0.447215},
    {0.276385, -0.850640, 0.447215},
    {0.000000, 0.000000, 1.000000},
    {-0.723600, 0.525720, 0.447215},
    {-0.723600, -0.525720, 0.447215},
    {0.000000, 0.000000, 1.000000},
    {0.276385, 0.850640, 0.447215},
    {-0.723600, 0.525720, 0.447215},
    {0.000000, 0.000000, 1.000000},
    {0.894425, 0.000000, 0.447215},
    {0.276385, 0.850640, 0.447215},
    {0.000000, 0.000000, 1.000000},
};
static const TextureCoord textureCoordinates[] =
{
    {0.648752, 0.445995},
    {0.914415, 0.532311},
    {0.722181, 0.671980},
    {0.722181, 0.671980},
    {0.914415, 0.532311},
    {0.914415, 0.811645},
    {0.254949, 0.204901},
    {0.254949, 0.442518},
    {0.028963, 0.278329},
    {0.480936, 0.278329},
    {0.254949, 0.442518},
    {0.254949, 0.204901},
    {0.838115, 0.247091},
    {0.713611, 0.462739},
    {0.589108, 0.247091},
    {0.722181, 0.671980},
    {0.914415, 0.811645},
    {0.648752, 0.897968},
    {0.648752, 0.445995},
    {0.722181, 0.671980},
    {0.484562, 0.671981},
    {0.254949, 0.204901},
    {0.028963, 0.278329},
    {0.115283, 0.012663},
    {0.480936, 0.278329},
    {0.254949, 0.204901},
    {0.394615, 0.012663},
    {0.838115, 0.247091},
    {0.589108, 0.247091},
    {0.713609, 0.031441},
    {0.648752, 0.897968},
    {0.484562, 0.671981},
    {0.722181, 0.671980},
    {0.644386, 0.947134},
    {0.396380, 0.969437},
    {0.501069, 0.743502},
    {0.115283, 0.012663},
    {0.394615, 0.012663},
    {0.254949, 0.204901},
    {0.464602, 0.031442},
    {0.713609, 0.031441},
    {0.589108, 0.247091},
    {0.713609, 0.031441},
    {0.962618, 0.031441},
    {0.838115, 0.247091},
    {0.028963, 0.613069},
    {0.254949, 0.448877},
    {0.254949, 0.686495},
    {0.115283, 0.878730},
    {0.028963, 0.613069},
    {0.254949, 0.686495},
    {0.394615, 0.878730},
    {0.115283, 0.878730},
    {0.254949, 0.686495},
    {0.480935, 0.613069},
    {0.394615, 0.878730},
    {0.254949, 0.686495},
    {0.254949, 0.448877},
    {0.480935, 0.613069},
    {0.254949, 0.686495},
};
// START:extension
@interface GLViewController ()
{
    GLuint      positionAttribute;
    GLuint      textureCoordinateAttribute;
    GLuint      ProjMatrixUniform;
    GLuint      MVmatrixUniform;
    GLuint      textureUniform;
    GLuint      textureUniform2;
    GLuint      blendmode;
    GLuint      res;
    GLuint      voaID;
    
    
    GLKMatrix4    projectionMatrix;
    GLKMatrix4    rotationMatrix;
    GLKMatrix4    translationMatrix;
    GLKMatrix4    modelViewMatrix;
    GLKMatrix4    cameraMatrix;
    GLKMatrix4    matrix;
    
    
    GLKVector3 targetV;
    GLKVector3 camPos;
    GLKVector3 upV;
    
    GLKMatrix4    lookAt;
    GLfloat stepSize;
    
    
}
@end
// END:extension

@implementation GLViewController
@synthesize program, texture,obj_texture;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
     
    }
    return self;
}

// START:setup
- (void)setup
{
    GLProgram *theProgram = [[GLProgram alloc] initWithVertexShaderFilename:@"Shader"
                                                     fragmentShaderFilename:@"Shader"];
    self.program = theProgram;
   
    
    [self.program addAttribute:@"position"];
    [self.program addAttribute:@"textureCoordinates"];
    
    if (![self.program link])
    {
        NSLog(@"Link failed");
        
        NSString *progLog = [self.program programLog];
        NSLog(@"Program Log: %@", progLog); 
        
        NSString *fragLog = [self.program fragmentShaderLog];
        NSLog(@"Frag Log: %@", fragLog);
        
        NSString *vertLog = [self.program vertexShaderLog];
        NSLog(@"Vert Log: %@", vertLog);
        
        [(GLView *)self.view stopAnimation];
        self.program = nil;
    }
    
    positionAttribute = [program attributeIndex:@"position"];
    textureCoordinateAttribute = [program attributeIndex:@"textureCoordinates"];
    MVmatrixUniform = [program uniformIndex:@"modelViewMatrix"];
    ProjMatrixUniform = [program uniformIndex:@"projectionMatrix"];
    textureUniform = [program uniformIndex:@"texture"];
    textureUniform2 = [program uniformIndex:@"texture2"];
    blendmode=[program uniformIndex:@"blendMode"];
    res=[self.program uniformIndex:@"uResolution"];

    glEnable(GL_DEPTH_TEST);
	glEnable(GL_CULL_FACE);
    glEnable(GL_TEXTURE_2D);
    glEnable(GL_BLEND);
//    glBlendFunc(GL_ONE, GL_ZERO);
    glBlendFunc(GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA);
    
    GLTexture *theTexture = [[GLTexture alloc] initWithFilename:@"DieTexture.png"];
    self.obj_texture = theTexture;
    
    GLTexture *theTexture2 = [[GLTexture alloc] initWithFilename:@"checker.png"];
    self.texture = theTexture2;
   
  
     targetV =GLKVector3Make(0.f, 3.f, -60.f);
     camPos = GLKVector3Make(0.f,3.f, 3.f);
     upV=GLKVector3Make(0, 1, 0);
    
    
    stepSize=1;
}
// END:setup
// START:draw
- (void)draw
{
  
    glClearColor(0.0f, 0.0f, 0.0f, 1.0f);
    glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT);
    [self.program use];
 
   
   cameraMatrix= GLKMatrix4MakePerspective(65.f, (self.view.frame.size.width )/(self.view.frame.size.height), .1f, 1000.f);
   lookAt= GLKMatrix4MakeLookAt(camPos.x, camPos.y, camPos.z, targetV.x, targetV.y, targetV.z, upV.x, upV.y, upV.z);
   translationMatrix= GLKMatrix4MakeTranslation(-camPos.x, -camPos.y, -camPos.z);

    projectionMatrix=  GLKMatrix4Multiply(lookAt, translationMatrix);
    projectionMatrix=  GLKMatrix4Multiply(cameraMatrix, projectionMatrix);
 
    glUniformMatrix4fv(ProjMatrixUniform, 1, FALSE, projectionMatrix.m);

// //-----------///draw icosahedran
//    
    glPushMatrix();
    
    glVertexAttribPointer(positionAttribute, 3, GL_FLOAT, 0, 0, vertices);
    glEnableVertexAttribArray(positionAttribute);
    
    glVertexAttribPointer(textureCoordinateAttribute, 2, GL_FLOAT, 0, 0, textureCoordinates);
    glEnableVertexAttribArray(textureCoordinateAttribute);

    
    modelViewMatrix=GLKMatrix4Scale(GLKMatrix4Identity,2, 2, 2);
 
    glUniformMatrix4fv(MVmatrixUniform, 1, FALSE, modelViewMatrix.m);
    
    glActiveTexture (GL_TEXTURE0);
    [obj_texture use];
    glUniform1i (textureUniform, 0);
    glUniform1i(blendmode, 3);

    glDrawArrays(GL_TRIANGLES, 0, sizeof(vertices) / sizeof(Vertex3D));
    
  
    glPopMatrix();
    
    
    /*!
     *  @author Bikash maharjan, 15-07-22 14:07:08
     *
     *  @br Draw plane
     *
     *  @since
     */
    modelViewMatrix=GLKMatrix4Scale(modelViewMatrix, 5, 5, 5);
    glUniformMatrix4fv(MVmatrixUniform, 1, FALSE, modelViewMatrix.m);
    
    glVertexAttribPointer(positionAttribute, 3, GL_FLOAT, 0, 0, planeFan);
    glEnableVertexAttribArray(positionAttribute);

    glVertexAttribPointer(textureCoordinateAttribute, 2, GL_FLOAT, 0, 0, plane_texCod);
    glEnableVertexAttribArray(textureCoordinateAttribute);
//
    glActiveTexture (GL_TEXTURE0);
    [texture use];
    glUniform1i (textureUniform, 0);
//    glActiveTexture (GL_TEXTURE1);
//    [obj_texture use];
//    
//    glUniform1i (textureUniform2, 1);
    
    glUniform1i(blendmode, 1);
//    int resolute[2]={320,568};
//    glUniform2iv(res, 1,resolute);
    
//    glDrawArrays(GL_TRIANGLES, 0, sizeof(planeFan) / sizeof(Vertex3D));
      glDrawElements(GL_TRIANGLES, 6, GL_UNSIGNED_SHORT, indices);
    

}

-(void)moveF{
    GLKVector3 v=GLKVector3Normalize(GLKVector3Subtract(targetV, camPos));
    v=GLKVector3MultiplyScalar(v, stepSize);
    v = GLKVector3Add(camPos,v );
    camPos=v;
    
}

-(void)moveB{
    GLKVector3 v=GLKVector3Normalize(GLKVector3Subtract(targetV, camPos));
    v=GLKVector3MultiplyScalar(v, stepSize);
    v = GLKVector3Subtract(camPos,v );
    camPos=v;
}
-(void)moveL{
    GLKVector3 v=GLKVector3Normalize(GLKVector3Subtract(targetV, camPos));
    v=GLKVector3Normalize(GLKVector3CrossProduct(v,upV));
    v=GLKVector3MultiplyScalar(v, stepSize);
    v = GLKVector3Subtract(camPos,v );
    camPos=v;
}
-(void)moveR{
    GLKVector3 v=GLKVector3Normalize(GLKVector3Subtract(targetV, camPos));
    v=GLKVector3Normalize(GLKVector3CrossProduct(upV,v));
    v=GLKVector3MultiplyScalar(v, stepSize);
    v = GLKVector3Subtract(camPos,v );
    camPos=v;

}

-(void)rotateH:(GLKVector2)change{
    //horizontal rotation
    GLKMatrix4 mat= GLKMatrix4RotateWithVector3(GLKMatrix4Identity, DEGREES_TO_RADIANS(change.x), GLKVector3Make(0, 1, 0));
    targetV=GLKMatrix4MultiplyVector3(mat, targetV);

    //vertical rotation
    GLKVector3 v=GLKVector3Normalize(GLKVector3Subtract(targetV, camPos));
    v=GLKVector3Normalize(GLKVector3CrossProduct(upV,v));

    mat= GLKMatrix4RotateWithVector3(GLKMatrix4Identity, DEGREES_TO_RADIANS(change.y), v);
    upV = GLKMatrix4MultiplyVector3(mat, upV);
    targetV=GLKMatrix4MultiplyVector3(mat, targetV);

}


// END:draw
#pragma mark -
- (void)viewDidUnload 
{
    [super viewDidUnload];
}
- (void)dealloc 
{
   program = nil;
    
}
@end
