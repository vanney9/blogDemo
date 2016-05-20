//
//  VSCBlurView.h
//  testweibo
//
//  Created by vanney on 16/5/19.
//  Copyright © 2016年 vanney. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface VSCBlurView : UIView
@property (nonatomic, assign) BOOL isShow;
@property (nonatomic, assign) NSTimeInterval showDuration;
@property (nonatomic, assign) NSTimeInterval dismissDuration;

@property (nonatomic, copy) void (^didShowBlurView)();
@property (nonatomic, copy) void (^didDismissBlurView)();

- (void)showBlurViewAtView:(UIView *)view;
- (void)dismiss;
@end
