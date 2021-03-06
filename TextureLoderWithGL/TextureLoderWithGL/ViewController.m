//
//  ViewController.m
//  TextureLoderWithGL
//
//  Created by Quinn_F on 2018/7/7.
//  Copyright © 2018年 Quinn. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (nonatomic , strong) EAGLContext* mContext;
@property(nonatomic,strong) GLKBaseEffect *baseEffect;

@end

@implementation ViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self setupConfig];
    [self uploadVertexArray];
    [self uploadTexture];

}

- (void)setupConfig{
    self.mContext = [[EAGLContext alloc] initWithAPI:kEAGLRenderingAPIOpenGLES2];
    GLKView *view = (GLKView*)self.view;
    view.context = self.mContext;
    view.drawableColorFormat = GLKViewDrawableColorFormatRGBA8888;  //颜色缓冲区格式
    [EAGLContext setCurrentContext:view.context];
}
- (void)uploadVertexArray{
    GLfloat vertexData[] =
    {
        0.5, -0.1, 0.0f,    //1.0f, 0.0f, //右下
        0.5, 0.5, -0.0f,    //1.0f, 1.0f, //右上
        -0.5, 0.5, 0.0f,   // 0.0f, 1.0f, //左上
        
//        0.5, -0.1, 0.0f,    1.0f, 0.0f, //右下
//        -0.5, 0.5, 0.0f,    0.0f, 1.0f, //左上
//        -0.5, -0.1, 0.0f,   0.0f, 0.0f, //左下
    };
    GLuint buffer;
    glGenBuffers(1, &buffer);
    glBindBuffer(GL_ARRAY_BUFFER, buffer);
    glBufferData(GL_ARRAY_BUFFER, sizeof(vertexData), vertexData, GL_STATIC_DRAW);
    
    glEnableVertexAttribArray(GLKVertexAttribPosition);
    glVertexAttribPointer(GLKVertexAttribPosition, 3, GL_FLOAT, GL_FALSE, sizeof(GLfloat) * 3, (GLfloat *)NULL + 0);
//    glEnableVertexAttribArray(GLKVertexAttribTexCoord0);
//    glVertexAttribPointer(GLKVertexAttribTexCoord0, 2, GL_FLOAT, GL_FALSE, sizeof(GLfloat) * 5, (GLfloat *)NULL + 3);
    
    /*
     glVertexAttribPointer函数的参数非常多，所以我会逐一介绍它们：
     
     第一个参数指定我们要配置的顶点属性。还记得我们在顶点着色器中使用layout(location = 0)定义了position顶点属性的位置值(Location)吗？它可以把顶点属性的位置值设置为0。因为我们希望把数据传递到这一个顶点属性中，所以这里我们传入0。
     第二个参数指定顶点属性的大小。顶点属性是一个vec3，它由3个值组成，所以大小是3。
     第三个参数指定数据的类型，这里是GL_FLOAT(GLSL中vec*都是由浮点数值组成的)。
     下个参数定义我们是否希望数据被标准化(Normalize)。如果我们设置为GL_TRUE，所有数据都会被映射到0（对于有符号型signed数据是-1）到1之间。我们把它设置为GL_FALSE。
     第五个参数叫做步长(Stride)，它告诉我们在连续的顶点属性组之间的间隔。由于下个组位置数据在3个float之后，我们把步长设置为3 * sizeof(float)。要注意的是由于我们知道这个数组是紧密排列的（在两个顶点属性之间没有空隙）我们也可以设置为0来让OpenGL决定具体步长是多少（只有当数值是紧密排列时才可用）。一旦我们有更多的顶点属性，我们就必须更小心地定义每个顶点属性之间的间隔，我们在后面会看到更多的例子（译注: 这个参数的意思简单说就是从这个属性第二次出现的地方到整个数组0位置之间有多少字节）。
     最后一个参数的类型是void*，所以需要我们进行这个奇怪的强制类型转换。它表示位置数据在缓冲中起始位置的偏移量(Offset)。由于位置数据在数组的开头，所以这里是0。我们会在后面详细解释这个参数。
     */
    
    /*
     glEnableVertexAttribArray，以顶点属性位置值作为参数，启用顶点属性；
     */
}
- (void)uploadTexture{
    //texture
//    NSString* filePath = [[NSBundle mainBundle] pathForResource:@"leaves" ofType:@"gif"];
//    NSDictionary* options = [NSDictionary dictionaryWithObjectsAndKeys:@(1), GLKTextureLoaderOriginBottomLeft, nil];//GLKTextureLoaderOriginBottomLeft 纹理坐标系是相反的
//    GLKTextureInfo* textureInfo = [GLKTextureLoader textureWithContentsOfFile:filePath options:options error:nil];
    self.baseEffect = [[GLKBaseEffect alloc] init];
//    self.baseEffect.texture2d0.enabled = GL_TRUE;
//    self.baseEffect.texture2d0.name = textureInfo.name;
}
- (void)glkView:(GLKView *)view drawInRect:(CGRect)rect{
    glClearColor(0.1f, 0.1f, 1.0f, 1.0f);
    glClear(GL_COLOR_BUFFER_BIT);

    [self.baseEffect prepareToDraw];


    
    //    glDrawArrays(GL_LINES, 0, 3);
    glDrawArrays(GL_TRIANGLES, 0, 3);
    
}
@end
