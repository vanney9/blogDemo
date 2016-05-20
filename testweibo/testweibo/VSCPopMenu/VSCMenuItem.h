//
//  MenuItem.h
//  testweibo
//
//  Created by vanney on 16/5/20.
//  Copyright © 2016年 vanney. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface VSCMenuItem : NSObject
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *iconName;
@property (nonatomic, assign) NSInteger index;

- (instancetype)initWithTitle:(NSString *)title iconName:(NSString *)iconName index:(NSInteger)index;
@end
