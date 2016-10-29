//
//  Shader.m
//  OpenGL ES Startup
//
//  Created by vanney on 2016/10/27.
//  Copyright © 2016年 vanney. All rights reserved.
//

#import "Shader.h"

@implementation Shader

- (instancetype)initWithVertexPath:(NSString *)vertexPath andFragmentPaht:(NSString *)fragmentPath {
    self = [super init];
    if (self) {
        // load glsl file
        NSString *vertexFile = [[NSBundle mainBundle] pathForResource:vertexPath ofType:@"glsl"];
        NSString *fragmentFile = [[NSBundle mainBundle] pathForResource:fragmentPath ofType:@"glsl"];

        NSError *error;

        NSString *vertexString = [NSString stringWithContentsOfFile:vertexFile encoding:NSUTF8StringEncoding error:&error];
        if (!vertexString) {
            NSLog(@"vanney code log : error loading vertex shader : %@", error.localizedDescription);
            exit(1);
        }

        NSString *fragmentString = [NSString stringWithContentsOfFile:fragmentFile encoding:NSUTF8StringEncoding error:&error];
        if (!fragmentString) {
            NSLog(@"vanney code log : error loading fragment shader : %@", error.localizedDescription);
            exit(1);
        }


        // compiler
        GLuint vertexShader, fragmentShader;
        GLint compilerSuccess, linkSuccess;
        GLchar messages[512];

        vertexShader = glCreateShader(GL_VERTEX_SHADER);
        const GLchar *vertexStringUTF8 = [vertexString UTF8String];
        glShaderSource(vertexShader, 1, &vertexStringUTF8, NULL);
        glCompileShader(vertexShader);
        glGetShaderiv(vertexShader, GL_COMPILE_STATUS, &compilerSuccess);
        if (compilerSuccess == GL_FALSE) {
            glGetShaderInfoLog(vertexShader, sizeof(messages), NULL, messages);
            NSLog(@"vanney code log : compile vertex shader error : %@", [NSString stringWithUTF8String:messages]);
            exit(1);
        }

        fragmentShader = glCreateShader(GL_FRAGMENT_SHADER);
        const GLchar *fragmentStringUTF8 = [fragmentString UTF8String];
        glShaderSource(fragmentShader, 1, &fragmentStringUTF8, NULL);
        glCompileShader(fragmentShader);
        glGetShaderiv(fragmentShader, GL_COMPILE_STATUS, &compilerSuccess);
        if (compilerSuccess == GL_FALSE) {
            glGetShaderInfoLog(fragmentShader, sizeof(messages), NULL, messages);
            NSLog(@"vanney code log : compile fragment shader error : %@", [NSString stringWithUTF8String:messages]);
            exit(1);
        }


        // link
        self.program = glCreateProgram();
        glAttachShader(self.program, vertexShader);
        glAttachShader(self.program, fragmentShader);
        glLinkProgram(self.program);
        glGetProgramiv(self.program, GL_LINK_STATUS, &linkSuccess);
        if (linkSuccess == GL_FALSE) {
            glGetProgramInfoLog(self.program, sizeof(messages), NULL, messages);
            NSLog(@"vanney code log : link shader error : %@", [NSString stringWithUTF8String:messages]);
            exit(1);
        }

        glDeleteShader(vertexShader);
        glDeleteShader(fragmentShader);
    }

    return self;
}

- (void)use {
    glUseProgram(self.program);
}

@end
