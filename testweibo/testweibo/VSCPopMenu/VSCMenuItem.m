//
//  MenuItem.m
//  testweibo
//
//  Created by vanney on 16/5/20.
//  Copyright © 2016年 vanney. All rights reserved.
//

#import "VSCMenuItem.h"

@implementation VSCMenuItem

- (instancetype)initWithTitle:(NSString *)title iconName:(NSString *)iconName index:(NSInteger)index {
    self = [super init];
    if (self) {
        _title = title;
        _iconName = iconName;
        _index = index;
    }

    return self;
}

@end
