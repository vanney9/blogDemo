//
//  VSCPopMenu.h
//  testweibo
//
//  Created by vanney on 16/5/20.
//  Copyright © 2016年 vanney. All rights reserved.
//

#import <UIKit/UIKit.h>

@class VSCBlurView;

@interface VSCPopMenu : UIView
@property (nonatomic, assign) BOOL isShow;
@property (nonatomic, strong) VSCBlurView *blurView;
@property (nonatomic, strong) NSArray *itemArray;
@property (nonatomic, assign) NSInteger numPerLine;

- (instancetype)initWithFrame:(CGRect)frame items:(NSArray *)items;
- (void)showMenuAtView:(UIView *)view;
- (void)dismiss;
@end
