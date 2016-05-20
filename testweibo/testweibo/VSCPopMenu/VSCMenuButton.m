//
//  MenuButton.m
//  testweibo
//
//  Created by vanney on 16/5/20.
//  Copyright © 2016年 vanney. All rights reserved.
//

#import "VSCMenuButton.h"
#import "VSCMenuItem.h"

@interface VSCMenuButton ()
@property (nonatomic, strong) VSCMenuItem *item;
@property (nonatomic, strong) UIImageView *iconView;
@property (nonatomic, strong) UILabel *titleLabel;
@end

@implementation VSCMenuButton

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype)initWithFrame:(CGRect)frame item:(VSCMenuItem *)item {
    self = [super initWithFrame:frame];
    if (self) {
        _item = item;

        UIImage *image = [UIImage imageNamed:_item.iconName];
        CGSize imageSize = image.size;
        _iconView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, imageSize.width, imageSize.height)];
        _iconView.image = image;
        _iconView.center = CGPointMake(CGRectGetMidX(self.bounds), CGRectGetMidY(self.bounds));
        [self addSubview:_iconView];

        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_iconView.frame), CGRectGetWidth(self.bounds), 35)];
        _titleLabel.textColor = [UIColor blackColor];
        _titleLabel.font = [UIFont systemFontOfSize:15];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.text = _item.title;
        _titleLabel.backgroundColor = [UIColor clearColor];
        [self addSubview:_titleLabel];
    }

    return self;
}

@end
