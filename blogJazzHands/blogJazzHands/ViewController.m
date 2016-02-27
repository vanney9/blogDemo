//
//  ViewController.m
//  blogJazzHands
//
//  Created by vanney on 16/2/27.
//  Copyright © 2016年 vanney. All rights reserved.
//

#import "ViewController.h"
#import "JazzHandsViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)demoAction:(UIButton *)sender {
    JazzHandsViewController *jazzHandsVC = [[JazzHandsViewController alloc] init];
    [self presentViewController:jazzHandsVC animated:YES completion:nil];
}
@end
