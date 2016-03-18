//
//  ViewController.m
//  demoMBProgressHUD
//
//  Created by vanney on 16/3/5.
//  Copyright (c) 2016 vanney9. All rights reserved.
//


#import "ViewController.h"
#import <MBProgressHUD.h>


@interface ViewController ()

@end

@implementation ViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    MBProgressHUD  *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDModeText;
    hud.detailsLabelFont = [UIFont boldSystemFontOfSize:15];
    hud.detailsLabelText = @"tip from vanney9.com";
    hud.margin = 10;
    hud.removeFromSuperViewOnHide = YES;
    [hud hide:YES afterDelay:2.0f];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end