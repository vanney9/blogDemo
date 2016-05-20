//
//  ViewController.m
//  testweibo
//
//  Created by vanney on 16/5/19.
//  Copyright © 2016年 vanney. All rights reserved.
//

#import "ViewController.h"
#import "VSCPopMenu.h"
#import "VSCMenuItem.h"

@interface ViewController ()
@property (nonatomic, strong) VSCPopMenu *popMenu;
@end


@implementation ViewController

#pragma mark - Base Setting

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.

    //self.edgesForExtendedLayout = UIRectEdgeNone;

    // setup nav
    self.title = @"Vanney9.com";
    UIImageView *bgView = [[UIImageView alloc] initWithFrame:self.view.bounds];
    bgView.image = [UIImage imageNamed:@"lionheart"];
    [self.view addSubview:bgView];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"show" style:UIBarButtonItemStylePlain target:self action:@selector(rightBtnClicked)];

    self.view.backgroundColor = [UIColor yellowColor];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Nav Button Event

- (void)rightBtnClicked {
    NSLog(@"vanney code log... [ViewController] right btn clicked");
    /*if (!_blurView) {
        __weak typeof(self) weakSelf = self;
        _blurView = [[VSCBlurView alloc] initWithFrame:self.view.bounds];
        _blurView.didDismissBlurView = ^() {
            [weakSelf.navigationItem.rightBarButtonItem setTitle:@"show"];
        };
        _blurView.didShowBlurView = ^() {
            [weakSelf.navigationItem.rightBarButtonItem setTitle:@"dismiss"];
        };
    }

    if ([self.navigationItem.rightBarButtonItem.title isEqualToString:@"show"]) {
        [_blurView showBlurViewAtView:self.view];
    } else {
        [_blurView dismiss];
    }*/

    if (!_popMenu) {
        NSArray *items = @[
                [[VSCMenuItem alloc] initWithTitle:@"Vanney" iconName:@"pop_Project" index:0],
                [[VSCMenuItem alloc] initWithTitle:@"Stephen" iconName:@"pop_Task" index:1],
                [[VSCMenuItem alloc] initWithTitle:@"Curry" iconName:@"pop_Tweet" index:2],
                [[VSCMenuItem alloc] initWithTitle:@"Sun" iconName:@"pop_User" index:3],
                [[VSCMenuItem alloc] initWithTitle:@"Stefanie" iconName:@"pop_Message" index:4],
                [[VSCMenuItem alloc] initWithTitle:@"Yanzi" iconName:@"pop_2FA" index:5],
        ];

        _popMenu = [[VSCPopMenu alloc] initWithFrame:self.view.bounds items:items];
    }
    if (!_popMenu.isShow) {
        [_popMenu showMenuAtView:self.view];
    } else {
        [_popMenu dismiss];
    }

}

@end
