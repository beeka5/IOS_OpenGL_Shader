#import <UIKit/UIKit.h>
#import <OpenGLES/ES2/gl.h>
#import <OpenGLES/ES2/glext.h>

@class GLProgram, GLTexture;

@interface GLViewController : UIViewController 
{
}
@property (nonatomic, retain) GLProgram *program;
@property (nonatomic, retain) GLTexture *texture;
@property (nonatomic, retain) GLTexture *obj_texture;
- (void)draw;
- (void)setup;
@end
