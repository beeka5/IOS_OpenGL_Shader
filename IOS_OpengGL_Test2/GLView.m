#import <OpenGLES/ES2/gl.h>
#import <OpenGLES/ES2/glext.h>
#import "GLView.h"
#import "GLViewController.h"
#import "AppDelegate.h"

@interface GLView ()
{
    GLint               backingWidth; 
    GLint               backingHeight;
    GLuint              frameBuffer; 
    GLuint              renderBuffer;
    GLuint              depthBuffer;
    CGPoint             startPt;
}
@property (nonatomic, getter=isAnimating) BOOL animating;
@property (nonatomic, retain) EAGLContext *context;
@property (nonatomic, retain) CADisplayLink *displayLink;

- (IBAction)moveForward:(UIButton *)sender;
- (IBAction)moveRight:(UIButton *)sender;
- (IBAction)moveLeft:(UIButton *)sender;
- (IBAction)moveDown:(UIButton *)sender;
- (void)drawView;
@end

#pragma mark -
@implementation GLView
@synthesize controller, animating, context, animationFrameInterval, displayLink;
+ (Class)layerClass
{
    return [CAEAGLLayer class];
}

- (id)initWithCoder:(NSCoder*)coder
{    
    if (self = [super initWithCoder:coder])
    {
        CAEAGLLayer *eaglLayer = (CAEAGLLayer *)self.layer;
        eaglLayer.opaque = YES;
        
        EAGLContext *theContext = [[EAGLContext alloc] initWithAPI:kEAGLRenderingAPIOpenGLES2];
        self.context = theContext;
        
        
        if (!self.context || ![EAGLContext setCurrentContext:self.context])
        {
            
        
            return nil;
        }
        AppDelegate * del=[[UIApplication sharedApplication] delegate];
        controller=del.rootController;
        animating = NO;
        animationFrameInterval = 2;
       
    }
    return self;
}
- (void)createBuffers
{
    glGenFramebuffers(1, &frameBuffer);
    glGenRenderbuffers(1, &renderBuffer);
    glBindFramebuffer(GL_FRAMEBUFFER, frameBuffer);
    glBindRenderbuffer(GL_RENDERBUFFER, renderBuffer);
    [context renderbufferStorage:GL_RENDERBUFFER fromDrawable:(CAEAGLLayer *)self.layer];
    glFramebufferRenderbuffer(GL_FRAMEBUFFER, GL_COLOR_ATTACHMENT0, GL_RENDERBUFFER, renderBuffer); 
    glGetRenderbufferParameteriv(GL_RENDERBUFFER, GL_RENDERBUFFER_WIDTH, &backingWidth);
    glGetRenderbufferParameteriv(GL_RENDERBUFFER, GL_RENDERBUFFER_HEIGHT, &backingHeight);
    
    glGenRenderbuffers(1, &depthBuffer);
    glBindRenderbuffer(GL_RENDERBUFFER, depthBuffer);
    glRenderbufferStorage(GL_RENDERBUFFER, GL_DEPTH_COMPONENT16, backingWidth, backingHeight);
    glFramebufferRenderbuffer(GL_FRAMEBUFFER, GL_DEPTH_ATTACHMENT, GL_RENDERBUFFER, depthBuffer);
}

- (void)destroyBuffers
{
    glDeleteFramebuffers(1, &frameBuffer);
    frameBuffer = 0;
    glDeleteRenderbuffers(1, &renderBuffer);
    renderBuffer = 0;

    if(depthBuffer) 
    {
        glDeleteRenderbuffers(1, &depthBuffer);
        depthBuffer = 0;
    }
}

- (IBAction)moveForward:(UIButton *)sender {
    [controller moveF];
}

- (IBAction)moveRight:(UIButton *)sender {
    [controller moveR];
}

- (IBAction)moveLeft:(UIButton *)sender {
    [controller moveL];
}

- (IBAction)moveDown:(UIButton *)sender {
    [controller moveB];
}

- (void)drawView
{    
    glBindFramebuffer(GL_FRAMEBUFFER, frameBuffer);
    
    [controller draw];
    
    glBindRenderbuffer(GL_RENDERBUFFER, renderBuffer);
    [context presentRenderbuffer:GL_RENDERBUFFER];
    
}
- (void)layoutSubviews
{
    [EAGLContext setCurrentContext:context];
    [self destroyBuffers];
    [self createBuffers];
    [self drawView];
    
    
    glBindRenderbuffer(GL_RENDERBUFFER, renderBuffer);
    
    glGetRenderbufferParameteriv(GL_RENDERBUFFER, GL_RENDERBUFFER_WIDTH, &backingWidth);
    glGetRenderbufferParameteriv(GL_RENDERBUFFER, GL_RENDERBUFFER_HEIGHT, &backingHeight);
    
    if (glCheckFramebufferStatus(GL_FRAMEBUFFER) != GL_FRAMEBUFFER_COMPLETE)
        NSLog(@"Failed to make complete framebuffer object %x", glCheckFramebufferStatus(GL_FRAMEBUFFER));
    glViewport(0, 0, backingWidth, backingHeight);
    [controller setup];
}
- (NSInteger)animationFrameInterval
{
    return animationFrameInterval;
}
- (void)setAnimationFrameInterval:(NSInteger)frameInterval
{
    if (frameInterval >= 1)
    {
        animationFrameInterval = frameInterval;
        if (animating)
        {
            [self stopAnimation];
            [self startAnimation];
        }
    }
}
- (void)startAnimation
{
    if (!animating)
    {
        self.displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(drawView)];
        [displayLink setFrameInterval:animationFrameInterval];
        [displayLink addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
        
        animating = YES;
    }
}
- (void)stopAnimation
{
    if (animating)
    {
        [displayLink invalidate];
        self.displayLink = nil;
        
        animating = NO;
    }
}
- (void)dealloc
{
    controller = nil;
    
    if (frameBuffer)
    {
        glDeleteFramebuffers(1, &frameBuffer);
        frameBuffer = 0;
    }
    if (renderBuffer)
    {
        glDeleteRenderbuffers(1, &renderBuffer);
        renderBuffer = 0;
    }
    if (depthBuffer)
    {
        glDeleteRenderbuffers(1, &depthBuffer);
        depthBuffer = 0;
    }
    
    if ([EAGLContext currentContext] == self.context)
        [EAGLContext setCurrentContext:nil];
   context = nil;
    
    [displayLink invalidate];
     displayLink = nil;
    
    
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    UITouch *touch=[[touches allObjects] objectAtIndex:0];
    startPt=[touch locationInView:self];
    
}
-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
    UITouch *touch=[[touches allObjects] objectAtIndex:0];
    CGPoint newPt=[touch locationInView:self];
    GLKVector2 change;
    change.x=newPt.x-startPt.x;
    change.y=newPt.y-startPt.y;
    
    [controller rotateH:change];
    
    startPt=newPt;
    
}
-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    
}
@end
