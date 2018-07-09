//
//  ViewController.m
//  3DShapeWithGL
//
//  Created by Quinn_F on 2018/7/8.
//  Copyright © 2018年 Quinn. All rights reserved.
//

#import "ViewController.h"
#import <GLKit/GLKit.h>
@interface ViewController ()
@property(nonatomic,strong) GLKBaseEffect *baseEffect;
@property(nonatomic,strong) EAGLContext *context;
@property (nonatomic , assign) int mCount;
@property (nonatomic , assign) float mDegreeX;
@property (nonatomic , assign) float mDegreeY;
@property (nonatomic , assign) float mDegreeZ;


@property (nonatomic , assign) BOOL mBoolX;
@property (nonatomic , assign) BOOL mBoolY;
@property (nonatomic , assign) BOOL mBoolZ;
@end

@implementation ViewController
{
    dispatch_source_t timer;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self setupContext];
    [self configureEffect];
    [self configureVertices];
    _mBoolX = true;
}

-(void)setupContext{
    
    //新建OpenGLES 上下文
    self.context = [[EAGLContext alloc] initWithAPI:kEAGLRenderingAPIOpenGLES2];
    
    GLKView* view = (GLKView *)self.view;
    view.context = self.context;
    view.drawableColorFormat = GLKViewDrawableColorFormatRGBA8888;
    view.drawableDepthFormat = GLKViewDrawableDepthFormat24;
    
    [EAGLContext setCurrentContext:self.context];
    glEnable(GL_DEPTH_TEST);
}
- (void)configureEffect{
    self.baseEffect = [[GLKBaseEffect alloc]init];
//    self.baseEffect.useConstantColor = GL_TRUE;
//    self.baseEffect.constantColor = GLKVector4Make(0.0f, 0.0f, 0.0f, 1.0f);
}
- (void)configureVertices{
    
    GLfloat vertices[] = {
        0.5f,   0.5f,   0.0f,//左上
        0.5f,   -0.5f,  0.0f,//左下
        -0.5f,  -0.5f,  0.0f,//右下
        -0.5f,  0.5f,   0.0f,//左上
        0.0f,   0.0f,   1.0f,//顶点
    };
    GLuint indices[] =
    {
        0, 1, 2,
        0, 2, 3,
        0, 4, 1,
        0, 4, 3,
        3, 4, 2,
        2, 4, 1,
    };
    
    self.mCount = sizeof(indices) / sizeof(GLuint);

    GLuint vertexBuffer;
    glGenBuffers(1, &vertexBuffer);
    glBindBuffer(GL_ARRAY_BUFFER, vertexBuffer);
    glBufferData(GL_ARRAY_BUFFER, sizeof(vertices), vertices, GL_STATIC_DRAW);
    
    
    GLuint index;
    glGenBuffers(1, &index);
    glBindBuffer(GL_ELEMENT_ARRAY_BUFFER, index);
    glBufferData(GL_ELEMENT_ARRAY_BUFFER, sizeof(indices), indices, GL_STATIC_DRAW);
    
    glEnableVertexAttribArray(GLKVertexAttribPosition);
    glVertexAttribPointer(GLKVertexAttribPosition, 3, GL_FLOAT, GL_FALSE, sizeof(GLfloat)*3, (GLfloat *)NULL + 0);

    
    //初始的投影
    CGSize size = self.view.bounds.size;
    float aspect = fabs(size.width / size.height);
    GLKMatrix4 projectionMatrix = GLKMatrix4MakePerspective(GLKMathDegreesToRadians(120.0), aspect, 0.1f, 10.f);
    projectionMatrix = GLKMatrix4Scale(projectionMatrix, 1.0f, 1.0f, 1.0f);
    self.baseEffect.transform.projectionMatrix = projectionMatrix;
    
    GLKMatrix4 modelViewMatrix = GLKMatrix4Translate(GLKMatrix4Identity, 0.0f, 0.0f, -2.0f);
    
    modelViewMatrix = GLKMatrix4RotateY(modelViewMatrix, 5);
    
    self.baseEffect.transform.modelviewMatrix = modelViewMatrix;
    
    //定时器
    double delayInSeconds = 0.1;
    timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, dispatch_get_main_queue());
    dispatch_source_set_timer(timer, DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC, 0.0);
    dispatch_source_set_event_handler(timer, ^{
        self.mDegreeX += 0.1  * self.mBoolX;
        self.mDegreeY += 0.1 * self.mBoolY;
        self.mDegreeZ += 0.1 * self.mBoolZ;
        
    });
    dispatch_resume(timer);

}
/**
 *  场景数据变化
 */
- (void)update {
//    GLKMatrix4 modelViewMatrix = GLKMatrix4Translate(GLKMatrix4Identity, 0.0f, 0.0f, -2.0f);
//
//    modelViewMatrix = GLKMatrix4RotateX(modelViewMatrix, self.mDegreeX);
//    modelViewMatrix = GLKMatrix4RotateY(modelViewMatrix, self.mDegreeY);
//    modelViewMatrix = GLKMatrix4RotateZ(modelViewMatrix, self.mDegreeZ);
//
//    self.baseEffect.transform.modelviewMatrix = modelViewMatrix;
}

-(void)glkView:(GLKView *)view drawInRect:(CGRect)rect{
    glClearColor(0.1f, 0.1f, 0.1f, 1.0f);
    glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT);
    [self.baseEffect prepareToDraw];
    glDrawElements(GL_TRIANGLES, self.mCount, GL_UNSIGNED_INT, 0);
}

@end
