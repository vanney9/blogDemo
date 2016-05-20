//
//  MenuButton.h
//  testweibo
//
//  Created by vanney on 16/5/20.
//  Copyright © 2016年 vanney. All rights reserved.
//

#import <UIKit/UIKit.h>

@class VSCMenuItem;

@interface VSCMenuButton : UIView
- (instancetype)initWithFrame:(CGRect)frame item:(VSCMenuItem *)item;
@end
