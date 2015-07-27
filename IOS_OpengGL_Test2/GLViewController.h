#import <UIKit/UIKit.h>
#import <OpenGLES/ES2/gl.h>
#import <OpenGLES/ES2/glext.h>
#import <GLKit/GLKit.h>

@class GLProgram, GLTexture;

@interface GLViewController : UIViewController 
{
}
@property (nonatomic, retain) GLProgram *program;
@property (nonatomic, retain) GLTexture *texture;
@property (nonatomic, retain) GLTexture *obj_texture;
- (void)draw;
- (void)setup;

-(void)moveF;
-(void)moveB;
-(void)moveL;
-(void)moveR;

-(void)rotateV:(GLKVector2)change;
-(void)rotateH:(GLKVector2)change;

@end
