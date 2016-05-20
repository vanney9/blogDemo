//
//  VSCBlurView.m
//  testweibo
//
//  Created by vanney on 16/5/19.
//  Copyright © 2016年 vanney. All rights reserved.
//

#import "VSCBlurView.h"

#define kVSCBlurView_FinalAlpha 0.5

@implementation VSCBlurView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        self.alpha = 0.0;
        _isShow = NO;
        _showDuration = 0.3;
        _dismissDuration = 0.3;
    }

    return self;
}

- (void)showBlurViewAtView:(UIView *)view {
    [self removeFromSuperview];
    self.alpha = 0.0;
    [view insertSubview:self atIndex:0];
    [UIView animateWithDuration:_showDuration animations:^{
        self.alpha = kVSCBlurView_FinalAlpha;
    } completion:^(BOOL finished) {
        _isShow = YES;
        if (_didShowBlurView) {
            _didShowBlurView();
        }
    }];
}

- (void)dismiss {
    [UIView animateWithDuration:_dismissDuration animations:^{
        self.alpha = 0.0;
    } completion:^(BOOL finished) {
        _isShow = NO;
        [self removeFromSuperview];
        if (_didDismissBlurView) {
            _didDismissBlurView();
        }
    }];
}

@end
