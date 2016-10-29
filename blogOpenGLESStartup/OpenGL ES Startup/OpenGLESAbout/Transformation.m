//
//  Transformation.m
//  OpenGL ES Startup
//
//  Created by vanney on 2016/10/28.
//  Copyright © 2016年 vanney. All rights reserved.
//

#import "Transformation.h"

@interface Transformation ()
{
    GLKVector3 _right;
    GLKVector3 _up;
    GLKVector3 _front;

    float _depth;

    float _scaleStart;
    float _scaleEnd;

    GLKVector2 _translationStart;
    GLKVector2 _translationEnd;

    GLKVector3 _rotationStart;
    GLKQuaternion _rotationEnd;
}
@end


@implementation Transformation

- (instancetype)initWithDepth:(float)z scale:(float)s translation:(GLKVector2)t totation:(GLKVector3)r {
    self = [super init];
    if (self) {
        _right = GLKVector3Make(1.0f, 0.0f, 0.0f);
        _up = GLKVector3Make(0.0f, 1.0f, 0.0f);
        _front = GLKVector3Make(0.0f, 0.0f, 1.0f);

        _depth = z;

        _scaleEnd = s;

        _translationEnd = t;

        r.x = GLKMathDegreesToRadians(r.x);
        r.y = GLKMathDegreesToRadians(r.y);
        r.z = GLKMathDegreesToRadians(r.z);
        _rotationEnd = GLKQuaternionIdentity;
        _rotationEnd = GLKQuaternionMultiply(GLKQuaternionMakeWithAngleAndVector3Axis(-r.x, _right), _rotationEnd);
        _rotationEnd = GLKQuaternionMultiply(GLKQuaternionMakeWithAngleAndVector3Axis(-r.y, _up), _rotationEnd);
        _rotationEnd = GLKQuaternionMultiply(GLKQuaternionMakeWithAngleAndVector3Axis(-r.z, _front), _rotationEnd);
    }

    return self;
}

- (void)start {
    self.state = S_NEW;
    _scaleStart = _scaleEnd;
    _translationStart = GLKVector2Make(0.0f, 0.0f);
    _rotationStart = GLKVector3Make(0.0f, 0.0f, 0.0f);
}

- (void)scale:(float)s {
    self.state = S_SCALE;
    _scaleEnd = s * _scaleStart;
}

- (void)translate:(GLKVector2)t withMultiplier:(float)m {
    self.state = S_TRASLATION;
    t = GLKVector2MultiplyScalar(t, m);

    float dx = _translationEnd.x + (t.x - _translationStart.x);
    float dy = _translationEnd.y - (t.y - _translationStart.y);

    _translationEnd = GLKVector2Make(dx, dy);
    _translationStart = GLKVector2Make(t.x, t.y);
}

- (void)rotate:(GLKVector3)r withMultiplier:(float)m {
    self.state = S_ROTATION;
    float dx = r.x - _rotationStart.x;
    float dy = r.y - _rotationStart.y;
    float dz = r.z - _rotationStart.z;

    _rotationStart = GLKVector3Make(r.x, r.y, r.z);
    _rotationEnd = GLKQuaternionMultiply(GLKQuaternionMakeWithAngleAndVector3Axis(dx * m, _up), _rotationEnd);
    _rotationEnd = GLKQuaternionMultiply(GLKQuaternionMakeWithAngleAndVector3Axis(dy * m, _right), _rotationEnd);
    _rotationEnd = GLKQuaternionMultiply(GLKQuaternionMakeWithAngleAndVector3Axis(-dz, _front), _rotationEnd);
}

- (GLKMatrix4)getModelViewMatrix {
    GLKMatrix4 modelMatrix = GLKMatrix4Identity;
    GLKMatrix4 quaternionMatrix = GLKMatrix4MakeWithQuaternion(_rotationEnd);
    modelMatrix = GLKMatrix4Translate(modelMatrix, _translationEnd.x, _translationEnd.y, -_depth);
    modelMatrix = GLKMatrix4Multiply(modelMatrix, quaternionMatrix);
    modelMatrix = GLKMatrix4Scale(modelMatrix, _scaleEnd, _scaleEnd, _scaleEnd);

    return modelMatrix;
}

@end
