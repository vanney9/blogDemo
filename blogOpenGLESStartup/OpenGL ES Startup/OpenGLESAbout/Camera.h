////
////  Camera.h
////  OpenGL ES Startup
////
////  Created by vanney on 2016/10/28.
////  Copyright © 2016年 vanney. All rights reserved.
////
//
//#import <Foundation/Foundation.h>
//
//#include <GLKit/GLKit.h>
//#include <OpenGLES/ES3/gl.h>
//#include <OpenGLES/ES3/glext.h>
//
//typedef enum Camera_Movement {
//    FORWARD,
//    BACKWARD,
//    LEFT,
//    RIGHT
//} Camera_Movement;
//
//const GLfloat YAW           = -90.0f;
//const GLfloat PITCH         = 0.0f;
//const GLfloat SPEED         = 3.0f;
//const GLfloat SENSITIVITY   = 0.1f;
//const GLfloat ZOOM          = 45.0f;
//
//@interface Camera : NSObject
//// camera attributes
//@property(nonatomic, assign) GLKVector3 Position;
//@property(nonatomic, assign) GLKVector3 Front;
//@property(nonatomic, assign) GLKVector3 Up;
//@property(nonatomic, assign) GLKVector3 Right;
//@property(nonatomic, assign) GLKVector3 WorldUp;
//// eular angles
//@property(nonatomic, assign) GLfloat Yaw;
//@property(nonatomic, assign) GLfloat Pitch;
//// camera options
//@property(nonatomic, assign) GLfloat MovementSpeed;
//@property(nonatomic, assign) GLfloat GestureSensitivity;
//@property(nonatomic, assign) GLfloat Zoom;
//
//- (instancetype)init;
//- (instancetype)initWithPosition:(GLKVector3)position andUp:(GLKVector3)up;
//- (GLKMatrix4)getViewMatrix;
//
//- (void)scale:(float)s;
//- (void)translate:(GLKVector3)t withMultiplier:(float)m;
//- (void)rotate:(GLKVector3)r withMultiplier:(float)m;
//@end
