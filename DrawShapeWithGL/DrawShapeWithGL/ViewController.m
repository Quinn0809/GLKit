//
//  ViewController.m
//  DrawShapeWithGL
//
//  Created by Quinn_F on 2018/7/7.
//  Copyright © 2018年 Quinn. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

typedef struct{
    GLKVector3 position;
}SceneVertex;

static const SceneVertex vertices[] = {
    {{-0.5f, -0.5f, 0.0}}, // lower left corner
    {{ 0.5f, -0.5f, 0.0}}, // lower right corner
    {{-0.5f,  0.5f, 0.0}}  // upper left corner
    
};
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    GLKView *view = (GLKView*)self.view;
    NSAssert([view isKindOfClass:[GLKView class]], @"view is not a GLKView");
    
    view.context = [[EAGLContext alloc] initWithAPI:kEAGLRenderingAPIOpenGLES2];
    [EAGLContext setCurrentContext:view.context];
    
    self.baseEffect = [[GLKBaseEffect alloc] init];
    self.baseEffect.useConstantColor = GL_TRUE;
    self.baseEffect.constantColor = GLKVector4Make(1.0f, 1.0f, 1.0f, 1.0f);
    
    glClearColor(0, 0, 0, 1);
    
    
    glGenBuffers(1, &vertexBUfferID);
    glBindBuffer(GL_ARRAY_BUFFER, vertexBUfferID);
    glBufferData(GL_ARRAY_BUFFER, sizeof(vertices), vertices, GL_STATIC_DRAW);
    
    
}


- (void)glkView:(GLKView *)view drawInRect:(CGRect)rect{
    [self.baseEffect prepareToDraw];
    glClear(GL_COLOR_BUFFER_BIT);
    
    glEnableVertexAttribArray(GLKVertexAttribPosition);
    glVertexAttribPointer(0, 3, GL_FLOAT, GL_FALSE, sizeof(SceneVertex), NULL);
    
//    glDrawArrays(GL_LINES, 0, 3);
    glDrawArrays(GL_TRIANGLES, 0, 3);

}
@end
