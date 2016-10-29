//
//  ViewController.m
//  OpenGL ES Startup
//
//  Created by vanney on 2016/10/27.
//  Copyright © 2016年 vanney. All rights reserved.
//

#import "ViewController.h"

#import "Shader.h"
#import "Transformation.h"
#include <math.h>

static const GLfloat vertices[] = {
        -0.5f, -0.5f, -0.5f,  0.0f, 0.0f,
        0.5f, -0.5f, -0.5f,  1.0f, 0.0f,
        0.5f,  0.5f, -0.5f,  1.0f, 1.0f,
        0.5f,  0.5f, -0.5f,  1.0f, 1.0f,
        -0.5f,  0.5f, -0.5f,  0.0f, 1.0f,
        -0.5f, -0.5f, -0.5f,  0.0f, 0.0f,

        -0.5f, -0.5f,  0.5f,  0.0f, 0.0f,
        0.5f, -0.5f,  0.5f,  1.0f, 0.0f,
        0.5f,  0.5f,  0.5f,  1.0f, 1.0f,
        0.5f,  0.5f,  0.5f,  1.0f, 1.0f,
        -0.5f,  0.5f,  0.5f,  0.0f, 1.0f,
        -0.5f, -0.5f,  0.5f,  0.0f, 0.0f,

        -0.5f,  0.5f,  0.5f,  1.0f, 0.0f,
        -0.5f,  0.5f, -0.5f,  1.0f, 1.0f,
        -0.5f, -0.5f, -0.5f,  0.0f, 1.0f,
        -0.5f, -0.5f, -0.5f,  0.0f, 1.0f,
        -0.5f, -0.5f,  0.5f,  0.0f, 0.0f,
        -0.5f,  0.5f,  0.5f,  1.0f, 0.0f,

        0.5f,  0.5f,  0.5f,  1.0f, 0.0f,
        0.5f,  0.5f, -0.5f,  1.0f, 1.0f,
        0.5f, -0.5f, -0.5f,  0.0f, 1.0f,
        0.5f, -0.5f, -0.5f,  0.0f, 1.0f,
        0.5f, -0.5f,  0.5f,  0.0f, 0.0f,
        0.5f,  0.5f,  0.5f,  1.0f, 0.0f,

        -0.5f, -0.5f, -0.5f,  0.0f, 1.0f,
        0.5f, -0.5f, -0.5f,  1.0f, 1.0f,
        0.5f, -0.5f,  0.5f,  1.0f, 0.0f,
        0.5f, -0.5f,  0.5f,  1.0f, 0.0f,
        -0.5f, -0.5f,  0.5f,  0.0f, 0.0f,
        -0.5f, -0.5f, -0.5f,  0.0f, 1.0f,

        -0.5f,  0.5f, -0.5f,  0.0f, 1.0f,
        0.5f,  0.5f, -0.5f,  1.0f, 1.0f,
        0.5f,  0.5f,  0.5f,  1.0f, 0.0f,
        0.5f,  0.5f,  0.5f,  1.0f, 0.0f,
        -0.5f,  0.5f,  0.5f,  0.0f, 0.0f,
        -0.5f,  0.5f, -0.5f,  0.0f, 1.0f
};

//static const GLuint indices[] = {
//        0, 1, 3,
//        1, 2, 3
//};

static const GLKVector3 cubePositions[] = {
        {{0.0f, 0.0f, 0.0f}},
        {{2.0f, 5.0f, -15.0f}},
        {{-1.5f, -2.2f, -2.5f}},
        {{-3.8f, -2.0f, -12.3f}},
        {{2.4f, -0.4f, -3.5f}},
        {{-1.7f,  3.0f, -7.5f}},
        {{1.3f, -2.0f, -2.5f}},
        {{1.5f,  2.0f, -2.5f}},
        {{1.5f,  0.2f, -1.5f}},
        {{-1.3f,  1.0f, -1.5f}}
};

static GLuint VAO, VBO;

@interface ViewController ()
//@property (nonatomic, assign) GLuint VAO, VBO, VEO;
@property (nonatomic, strong) Shader *shader;
@property (nonatomic, strong) GLKTextureInfo *containerTexture;
@property (nonatomic, strong) GLKTextureInfo *faceTexture;

@property (nonatomic, strong) Transformation *transformation;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    GLKView *view = (GLKView *)self.view;
    NSAssert([view isKindOfClass:[GLKView class]], @"View controller`s view is not a GLKview");
    
    view.delegate = self;
    view.drawableDepthFormat = GLKViewDrawableDepthFormat24;
    
    // setup context
    view.context = [[EAGLContext alloc]initWithAPI:kEAGLRenderingAPIOpenGLES3];
    [EAGLContext setCurrentContext:view.context];

    // setup transformation
    self.transformation = [[Transformation alloc] initWithDepth:0 scale:1.0f translation:GLKVector2Make(0.0f, 0.0f) totation:GLKVector3Make(0.0f, 0.0f, 0.0f)];
    GLKMatrix4 initm = [self.transformation getModelViewMatrix];
    for (int i = 0; i < 4; ++i) {
        for (int j = 0; j < 4; ++j) {
            printf("%f\t", initm.m[i * 4 + j]);
        }
        printf("\n");
    }

    // load shader
    self.shader = [[Shader alloc] initWithVertexPath:@"vertex" andFragmentPaht:@"fragment"];
    if (!self.shader) {
        NSLog(@"vanney code log : error with shader");
        exit(1);
    }

    // load texture
    NSError *error;
    NSString *containerPath = [[NSBundle mainBundle] pathForResource:@"container" ofType:@"jpg"];
    self.containerTexture = [GLKTextureLoader textureWithContentsOfFile:containerPath options:nil error:&error];
    NSString *facePath = [[NSBundle mainBundle] pathForResource:@"awesomeface" ofType:@"png"];
    self.faceTexture = [GLKTextureLoader textureWithContentsOfFile:facePath options:nil error:&error];
    //glBindTexture(self.containerTexture.target, self.containerTexture.name);

    // initialize vertex data
    glGenVertexArrays(1, &VAO);
    glGenBuffers(1, &VBO);
    //glGenBuffers(1, &VEO);

    glBindVertexArray(VAO);
    glBindBuffer(GL_ARRAY_BUFFER, VBO);
    glBufferData(GL_ARRAY_BUFFER, sizeof(vertices), vertices, GL_STATIC_DRAW);
    //glBindBuffer(GL_ELEMENT_ARRAY_BUFFER, self.VEO);
    //glBufferData(GL_ELEMENT_ARRAY_BUFFER, sizeof(indices), indices, GL_STATIC_DRAW);
    glVertexAttribPointer(GLKVertexAttribPosition, 3, GL_FLOAT, GL_FALSE, 5 * sizeof(GLfloat), (GLvoid *) 0);
    glEnableVertexAttribArray(GLKVertexAttribPosition);
    glVertexAttribPointer(GLKVertexAttribTexCoord0, 2, GL_FLOAT, GL_FALSE, 5 * sizeof(GLfloat), (GLvoid *) (3 * sizeof(GLfloat)));
    glEnableVertexAttribArray(GLKVertexAttribTexCoord0);
    glBindVertexArray(0);
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma GLKViewDelegate

- (void)glkView:(GLKView *)view drawInRect:(CGRect)rect {
    glEnable(GL_DEPTH_TEST);
    glClearColor(0.2f, 0.3f, 0.3f, 1.0f);
    glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT);
    //glClear(GL_COLOR_BUFFER_BIT);

    [self.shader use];

    GLKMatrix4 projectionMatrix = GLKMatrix4MakePerspective(M_PI_4, self.view.bounds.size.width / self.view.bounds.size.height, 0.1f, 100.0f);
    glUniformMatrix4fv(glGetUniformLocation(self.shader.program, "projection"), 1, GL_FALSE, projectionMatrix.m);
    GLKMatrix4 viewMatrix = GLKMatrix4MakeLookAt(0.0f, 0.0f, 3.0f, 0.0f, 0.0f, 0.0f, 0.0f, 1.0f, 0.0f);
    glUniformMatrix4fv(glGetUniformLocation(self.shader.program, "view"), 1, GL_FALSE, viewMatrix.m);

    // bind texture
    glActiveTexture(GL_TEXTURE0);
    glBindTexture(self.containerTexture.target, self.containerTexture.name);
    glUniform1i(glGetUniformLocation(self.shader.program, "ourTexture1"), 0);
    glActiveTexture(GL_TEXTURE1);
    glBindTexture(self.faceTexture.target, self.faceTexture.name);
    glUniform1i(glGetUniformLocation(self.shader.program, "ourTexture2"), 1);

    glBindVertexArray(VAO);
    GLKMatrix4 transModel = [self.transformation getModelViewMatrix];
    for (int i = 0; i < 10; ++i) {
        //GLKMatrix4 modelMatrix = GLKMatrix4TranslateWithVector3(GLKMatrix4Identity, cubePositions[i]);
        GLKMatrix4 modelMatrix = GLKMatrix4TranslateWithVector3(transModel, cubePositions[i]);
        GLfloat radian = (GLfloat) (20.0f * i / 180 * M_PI);
        modelMatrix = GLKMatrix4RotateWithVector3(modelMatrix, radian, GLKVector3Make(1.0f, 0.3f, 0.5f));
        glUniformMatrix4fv(glGetUniformLocation(self.shader.program, "model"), 1, GL_FALSE, modelMatrix.m);
        glDrawArrays(GL_TRIANGLES, 0, 36);
    }
    glBindVertexArray(0);
}


# pragma Gesture Action

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.transformation start];
}

- (IBAction)pan:(UIPanGestureRecognizer *)sender {
    if ((sender.numberOfTouches == 1) && ((self.transformation.state == S_NEW) || (self.transformation.state == S_TRASLATION))) {
        CGPoint translation = [sender translationInView:sender.view];
        float x = translation.x / sender.view.frame.size.width;
        float y = translation.y / sender.view.frame.size.height;
        [self.transformation translate:GLKVector2Make(x, y) withMultiplier:1.0f];
    } else if ((sender.numberOfTouches == 2) && ((self.transformation.state == S_NEW) || (self.transformation.state == S_ROTATION))) {
        const float m = GLKMathDegreesToRadians(0.5f);
        CGPoint rotation = [sender translationInView:sender.view];
        [self.transformation rotate:GLKVector3Make(rotation.x, rotation.y, 0.0f) withMultiplier:m];
    }
}

- (IBAction)pinch:(UIPinchGestureRecognizer *)sender {
    if ((self.transformation.state == S_NEW) || (self.transformation.state == S_SCALE)) {
        float scale = [sender scale];
        [self.transformation scale:scale];
    }
}

- (IBAction)rotation:(UIRotationGestureRecognizer *)sender {
    if ((self.transformation.state == S_NEW) || (self.transformation.state == S_ROTATION)) {
        float rotation = [sender rotation];
        [self.transformation rotate:GLKVector3Make(0.0f, 0.0f, rotation) withMultiplier:1.0f];
    }
}
@end
