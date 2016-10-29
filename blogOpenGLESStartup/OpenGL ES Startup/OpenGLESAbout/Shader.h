//
//  Shader.h
//  OpenGL ES Startup
//
//  Created by vanney on 2016/10/27.
//  Copyright © 2016年 vanney. All rights reserved.
//

#import <Foundation/Foundation.h>

#include <OpenGLES/ES3/gl.h>
#include <OpenGLES/ES3/glext.h>



@interface Shader : NSObject

@property(nonatomic, assign) GLuint program;

- (instancetype)initWithVertexPath:(NSString *)vertexPath andFragmentPaht:(NSString *)fragmentPath;
- (void)use;

@end
