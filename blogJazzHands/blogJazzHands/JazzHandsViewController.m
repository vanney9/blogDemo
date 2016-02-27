//
//  JazzHandsViewController.m
//  blogJazzHands
//
//  Created by vanney on 16/2/27.
//  Copyright © 2016年 vanney. All rights reserved.
//

#import "JazzHandsViewController.h"
#import <JazzHands/IFTTTJazzHands.h>
#import <Masonry.h>

@interface JazzHandsViewController ()
@property (nonatomic, strong) NSMutableDictionary *iconsDict, *tipsDict;

@end

@implementation JazzHandsViewController

#pragma mark - Life Cycle

- (instancetype)init {
    if (self = [super init]) {
        _iconsDict = [@{
                        @"0_image" : @"intro_icon_6",
                        @"1_image" : @"intro_icon_0",
                        @"2_image" : @"intro_icon_1",
                        @"3_image" : @"intro_icon_2",
                        @"4_image" : @"intro_icon_3",
                        @"5_image" : @"intro_icon_4",
                        @"6_image" : @"intro_icon_5",
                        } mutableCopy];
        _tipsDict = [@{
                       @"1_image" : @"intro_tip_0",
                       @"2_image" : @"intro_tip_1",
                       @"3_image" : @"intro_tip_2",
                       @"4_image" : @"intro_tip_3",
                       @"5_image" : @"intro_tip_4",
                       @"6_image" : @"intro_tip_5",
                       } mutableCopy];
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor colorWithRed:241.0f / 255.0f green:241.0f / 255.0f blue:241.0f / 255.0f alpha:1.0f];
    [self configureViews];
    [self configureAnimations];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Override Super Method

- (NSUInteger)numberOfPages {
    return 7;
}


#pragma mark - Private Method

- (void)configureViews {
    for (int i = 0; i < self.numberOfPages; i++) {
        NSString *imageKey = [self imageKeyForIndex:i];
        NSString *viewKey = [self viewKeyForIndex:i];
        NSString *iconImageName = [self.iconsDict objectForKey:imageKey];
        NSString *tipImageName = [self.tipsDict objectForKey:imageKey];
        
        if (iconImageName) {
            UIImageView *iconView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:iconImageName]];
            [self.contentView addSubview:iconView];
            [self.iconsDict setObject:iconView forKey:viewKey];
        }
        
        if (tipImageName) {
            UIImageView *tipView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:tipImageName]];
            [self.contentView addSubview:tipView];
            [self.tipsDict setObject:tipView forKey:viewKey];
        }
    }
}

- (void)configureAnimations {
    for (int i = 0; i < self.numberOfPages; i++) {
        NSString *viewKey = [self viewKeyForIndex:i];
        UIView *iconView = [self.iconsDict objectForKey:viewKey];
        UIView *tipView = [self.tipsDict objectForKey:viewKey];
        
        if (iconView) {
            if (i == 0) {
                [self keepView:iconView onPages:@[@(i + 1), @(i)] atTimes:@[@(i - 1), @(i)]];
                [iconView mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.top.mas_equalTo([UIScreen mainScreen].bounds.size.height / 7);
                }];
            } else {
                [self keepView:iconView onPage:i];
                [iconView mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.centerY.mas_equalTo(- [UIScreen mainScreen].bounds.size.height / 6);
                }];
            }
            
            IFTTTAlphaAnimation *iconAnimation = [IFTTTAlphaAnimation animationWithView:iconView];
            [iconAnimation addKeyframeForTime:i alpha:1.0f];
            [iconAnimation addKeyframeForTime:i - 0.5 alpha:0.0f];
            [iconAnimation addKeyframeForTime:i + 0.5 alpha:0.0f];
            [self.animator addAnimation:iconAnimation];
        }
        
        if (tipView) {
            [self keepView:tipView onPages:@[@(i + 1), @(i), @(i - 1)] atTimes:@[@(i - 1), @(i), @(i + 1)]];
            [tipView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(iconView.mas_bottom).with.offset(50);
            }];
            
            IFTTTAlphaAnimation *tipAnimation = [IFTTTAlphaAnimation animationWithView:tipView];
            [tipAnimation addKeyframeForTime:i + 0.5 alpha:0.0f];
            [tipAnimation addKeyframeForTime:i - 0.5 alpha:0.0f];
            [tipAnimation addKeyframeForTime:i alpha:1.0f];
            [self.animator addAnimation:tipAnimation];
        }
    }
}

- (NSString *)imageKeyForIndex:(NSInteger)index {
    return [NSString stringWithFormat:@"%ld_image", (long)index];
}

- (NSString *)viewKeyForIndex:(NSInteger)index {
    return [NSString stringWithFormat:@"%ld_view", (long)index];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
