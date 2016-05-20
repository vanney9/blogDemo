//
//  VSCPopMenu.m
//  testweibo
//
//  Created by vanney on 16/5/20.
//  Copyright © 2016年 vanney. All rights reserved.
//

#import "VSCPopMenu.h"
#import "VSCBlurView.h"
#import "VSCMenuButton.h"
#import "VSCMenuItem.h"
#import "POP.h"

#define kVSCPopMenu_ItemHeight 110
#define kVSCPopMenu_VerticalPadding 10
#define kVSCPopMenu_HorizontalPadding 10
#define kScreen_Width [UIScreen mainScreen].bounds.size.width
#define kScreen_Height [UIScreen mainScreen].bounds.size.height
#define kVSCPopMenu_AnimationTimeInterval 0.1

@implementation VSCPopMenu

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype)initWithFrame:(CGRect)frame items:(NSArray *)items {
    self = [super initWithFrame:frame];
    if (self) {
        _isShow = NO;
        _numPerLine = 3;
        _itemArray = items;
        [self setupBlurView];
    }

    return self;
}

- (void)setupBlurView {
    if (!_blurView) {
        _blurView = [[VSCBlurView alloc] initWithFrame:self.bounds];
        __weak typeof(self) weakSelf = self;
        _blurView.didShowBlurView = ^{
            [weakSelf showButtons];
        };
        _blurView.didDismissBlurView = ^{

        };
    }
}

- (void)showButtons {
    NSInteger itemNum = _itemArray.count;
    NSInteger lineNum = (NSInteger) ceilf(itemNum / (float) _numPerLine);
    CGFloat itemWidth = (kScreen_Width - kVSCPopMenu_HorizontalPadding) / _numPerLine - kVSCPopMenu_HorizontalPadding;

    CGFloat moveY = (kScreen_Height + lineNum * (kVSCPopMenu_VerticalPadding + kVSCPopMenu_ItemHeight)) / 2;
    for (VSCMenuItem *item in _itemArray) {
        CGRect toRect = [self getRectWithHeight:kVSCPopMenu_ItemHeight width:itemWidth index:item.index lineNum:lineNum perLineNum:_numPerLine];
        CGRect fromRect = toRect;
        fromRect.origin.y -= moveY;
        VSCMenuButton *button = [[VSCMenuButton alloc] initWithFrame:fromRect item:item];
        [self addSubview:button];
        CFTimeInterval delaySecond = (itemNum - item.index) * kVSCPopMenu_AnimationTimeInterval / 5;
        [self startAnimationFromPosition:fromRect toPosition:toRect atView:button beginTime:delaySecond];
    }
}

- (void)dismiss {
    _isShow = NO;
    for (UIView *subview in self.subviews) {
        if ([subview isKindOfClass:[VSCMenuButton class]]) {
            [subview removeFromSuperview];
        }
    }
    [self removeFromSuperview];
}

- (CGRect)getRectWithHeight:(CGFloat)height width:(CGFloat)width index:(NSInteger)index lineNum:(NSInteger)lineNum perLineNum:(NSInteger)perLineNum {
    NSInteger whichLine = (NSInteger) ceilf((index + 1) / (CGFloat) perLineNum) - 1;
    NSInteger whichRow = index - whichLine * perLineNum;

    CGFloat startY = (kScreen_Height - 64 - lineNum * (height + kVSCPopMenu_VerticalPadding)) / 2;
    CGFloat resultX = kVSCPopMenu_HorizontalPadding + whichRow * (width + kVSCPopMenu_HorizontalPadding);
    CGFloat resultY = startY + whichLine * (kVSCPopMenu_VerticalPadding + height);

    return CGRectMake(resultX, resultY, width, height);
}

- (void)startAnimationFromPosition:(CGRect)from toPosition:(CGRect)to atView:(UIView *)view beginTime:(CFTimeInterval)beginTime {
    POPSpringAnimation *springAnimation = [POPSpringAnimation animation];
    springAnimation.property = [POPAnimatableProperty propertyWithName:kPOPViewFrame];
    springAnimation.removedOnCompletion = YES;
    NSLog(@"vanney code log... [VSCPopMenu] cacurrentmediatime is %f", CACurrentMediaTime());
    springAnimation.beginTime = beginTime + CACurrentMediaTime();

    CGFloat springBounciness = 6;
    springAnimation.springBounciness = springBounciness;

    CGFloat springSpeed = 2;
    springAnimation.springSpeed = springSpeed;

    springAnimation.fromValue = [NSValue valueWithCGRect:from];
    springAnimation.toValue = [NSValue valueWithCGRect:to];

    [view pop_addAnimation:springAnimation forKey:@"POPSpringAnimationKey"];
}

- (void)showMenuAtView:(UIView *)view {
    [view addSubview:self];
    [_blurView showBlurViewAtView:self];
    _isShow = YES;

}


@end
