////
////  Camera.m
////  OpenGL ES Startup
////
////  Created by vanney on 2016/10/28.
////  Copyright © 2016年 vanney. All rights reserved.
////
//
//#import "Camera.h"
//
//@implementation Camera
//
//- (instancetype)init {
//    return [self initWithPosition:{{0.0f, 0.0f, 0.0f}} andUp:{{0.0f, 1.0f, 0.0f}}];
//}
//
//- (instancetype)initWithPosition:(GLKVector3)position andUp:(GLKVector3)up {
//    self = [super init];
//    if (self) {
//        self.Position = position;
//        self.WorldUp = up;
//        self.Front = {{0.0f, 0.0f, -1.0f}};
//
//        self.Yaw = YAW;
//        self.Pitch = PITCH;
//        self.MovementSpeed = SPEED;
//        self.GestureSensitivity = SENSITIVITY;
//        self.Zoom = ZOOM;
//
//        [self updateCameraVectors];
//    }
//
//    return self;
//}
//
//- (GLKMatrix4)getViewMatrix {
//    GLKVector3 center = GLKVector3Add(self.Position, self.Front);
//    return GLKMatrix4MakeLookAt(self.Position.x, self.Position.y, self.Position.z, center.x, center.y, center.z, self.Up.x, self.Up.y, self.Up.z);
//}
//
//- (void)scale:(float)s {
//    self.Position = GLKVector3Add(self.Position, GLKVector3AddScalar(self.Front, s));
//    [self updateCameraVectors];
//}
//
//- (void)translate:(GLKVector3)t withMultiplier:(float)m {
//    
//}
//
//
//
//
//#pragma mark - private method
//
//- (void)updateCameraVectors {
//    GLKVector3 front;
//    front.x = cos(GLKMathDegreesToRadians(self.Yaw)) * cos(GLKMathDegreesToRadians(self.Pitch));
//    front.y = sin(GLKMathDegreesToRadians(self.Pitch));
//    front.z = sin(GLKMathDegreesToRadians(self.Yaw)) * cos(GLKMathDegreesToRadians(self.Pitch));
//    self.Front = GLKVector3Normalize(front);
//
//    self.Right = GLKVector3Normalize(GLKVector3CrossProduct(self.Front, self.WorldUp));
//    self.Up = GLKVector3Normalize(GLKVector3CrossProduct(self.Right, self.Front));
//}
//
//@end
