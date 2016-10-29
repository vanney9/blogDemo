//
//  Transformation.h
//  OpenGL ES Startup
//
//  Created by vanney on 2016/10/28.
//  Copyright © 2016年 vanney. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <GLKit/GLKit.h>

typedef enum TransformationState {
    S_NEW,
    S_SCALE,
    S_TRASLATION,
    S_ROTATION
} TransformationState;

@interface Transformation : NSObject
@property(nonatomic, assign) TransformationState state;

- (instancetype)initWithDepth:(float)z scale:(float)s translation:(GLKVector2)t totation:(GLKVector3)r;
- (void)start;
- (void)scale:(float)s;
- (void)translate:(GLKVector2)t withMultiplier:(float)m;
- (void)rotate:(GLKVector3)r withMultiplier:(float)m;
- (GLKMatrix4)getModelViewMatrix;

@end
