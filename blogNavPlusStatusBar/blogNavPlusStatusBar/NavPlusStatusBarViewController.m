//
//  NavPlusStatusBarViewController.m
//  blogNavPlusStatusBar
//
//  Created by vanney on 16/1/5.
//  Copyright © 2016年 vanney. All rights reserved.
//

#import "NavPlusStatusBarViewController.h"

@interface NavPlusStatusBarViewController ()

@property (nonatomic, strong) UINavigationBar *navBar;

@end

@implementation NavPlusStatusBarViewController

- (void)viewDidLoad {
    
    
    self.navBar = [[UINavigationBar alloc] initWithFrame:CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width, 64)];
    self.navBar.barTintColor = [UIColor blackColor];                                        // 设置导航栏背景色
    self.navBar.translucent = NO;                                                           // 关闭导航栏半透明
    self.navBar.tintColor = [UIColor redColor];                                             // 设置左右侧按钮颜色
    
    UINavigationItem *navItem = [[UINavigationItem alloc] initWithTitle:@"vanney9"];        // 设置UINavigationItem标题
    
    // setup left bar button item
    UIBarButtonItem *btnLeft = [[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStyleDone target:self action:nil];
    navItem.leftBarButtonItem = btnLeft;                                                    // 添加UINavigationItem左侧按钮
    
    // setup right bar button item
    UIBarButtonItem *btnRight = [[UIBarButtonItem alloc] initWithTitle:@"Next" style:UIBarButtonItemStyleDone target:self action:nil];
    navItem.rightBarButtonItem = btnRight;                                                  // 添加UINavigationItem右侧按钮
    
    // setup bar title color
    [self.navBar setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor greenColor]}];   // 设置导航栏标题属性
    
    // push navItem
    [self.navBar pushNavigationItem:navItem animated:YES];                                  // 将UINavigationItem压入导航栏中
    
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.navBar];
    
    // setup status bar
    [self setNeedsStatusBarAppearanceUpdate];
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

@end
