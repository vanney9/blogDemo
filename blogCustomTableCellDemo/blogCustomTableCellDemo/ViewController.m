//
//  ViewController.m
//  blogCustomTableCellDemo
//
//  Created by vanney on 16/3/8.
//  Copyright © 2016年 vanney. All rights reserved.
//

#import "ViewController.h"
#import "CustomTableViewCell.h"

@interface ViewController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation ViewController

#pragma mark - Life Cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewCellStyleDefault];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.tableFooterView = [UIView new];
    _tableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 50)];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [_tableView registerClass:[CustomTableViewCell class] forCellReuseIdentifier:kCellIdentifierText];
    [_tableView registerClass:[CustomTableViewCell class] forCellReuseIdentifier:kCellIdentifierPassword];

    [self.view addSubview:_tableView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *identifier = indexPath.row == 2 ? kCellIdentifierPassword : kCellIdentifierText;
    CustomTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];

    switch (indexPath.row) {
        case 0: {
            cell.textField.keyboardType = UIKeyboardTypeDefault;
            [cell setPlaceholder:@" 用户名(个性后缀)" value:@""];
            break;
        }
        case 1: {
            cell.textField.keyboardType = UIKeyboardTypeEmailAddress;
            [cell setPlaceholder:@" 邮箱" value:@""];
            break;
        }
        case 2: {
            cell.textField.keyboardType = UIKeyboardTypeDefault;
            [cell setPlaceholder:@" 设置密码" value:@""];
            break;
        }

        default:
            break;
    }

    return cell;
}


#pragma mark - UITableViewDelegate


@end
