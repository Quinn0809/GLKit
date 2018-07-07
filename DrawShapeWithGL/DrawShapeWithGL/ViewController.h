//
//  ViewController.h
//  DrawShapeWithGL
//
//  Created by Quinn_F on 2018/7/7.
//  Copyright © 2018年 Quinn. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <GLKit/GLKit.h>
@interface ViewController : GLKViewController{
    GLuint vertexBUfferID;
}
@property(nonatomic,strong) GLKBaseEffect *baseEffect;


@end

