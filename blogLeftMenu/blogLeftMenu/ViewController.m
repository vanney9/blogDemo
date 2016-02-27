//
//  ViewController.m
//  blogLeftMenu
//
//  Created by vanney on 16/1/19.
//  Copyright © 2016年 vanney. All rights reserved.
//

#import "ViewController.h"
#import "LeftMenuView.h"

@interface ViewController ()

@property (nonatomic, strong) LeftMenuView *menuView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.menuView = [[NSBundle mainBundle] loadNibNamed:@"LeftMenuView" owner:self options:nil].lastObject;
    [self.view addSubview:self.menuView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
