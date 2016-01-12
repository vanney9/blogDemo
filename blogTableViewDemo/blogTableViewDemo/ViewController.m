//
//  ViewController.m
//  blogTableViewDemo
//
//  Created by vanney on 16/1/11.
//  Copyright © 2016年 vanney. All rights reserved.
//

#import "ViewController.h"

static const CGFloat HeaderHeight = 35.0f;

@interface ViewController () <UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation ViewController {
    NSArray *headerArray;
    NSArray *rowArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.


    // DataSource set
    headerArray = @[@"浏览设置", @"缓存设置", @"更多", @"", @""];
    rowArray = @[@[@"夜间模式切换"],
                 @[@"清除缓存"],
                 @[@"去评分", @"反馈", @"用户协议", @"版本号"],
                 @[@"退出当前账号"],
                 @[]];

    self.tableView.rowHeight = 44;                                  // set up cell height
    self.tableView.backgroundColor =
            [UIColor colorWithRed:235.0f / 255.0f green:235.0f / 255.0f blue:235.0f / 255.0f alpha:1.0f];   // set up UITableView background color
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];                             // 不显示多余的cell
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"stefanie"];              // register cell for reuse
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Private Method



#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return headerArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSArray *rowData = rowArray[section];
    return rowData.count;
}

// set up header

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return HeaderHeight;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    CGFloat screenWidth = [[UIScreen mainScreen] bounds].size.width;

    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, screenWidth, HeaderHeight)];
    headerView.backgroundColor =
            [UIColor colorWithRed:235.0f / 255.0f green:235.0f / 255.0f blue:235.0f / 255.0f alpha:1.0f];

    UILabel *headerLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 0, screenWidth - 40, HeaderHeight)];
    headerLabel.text = headerArray[section];
    headerLabel.textColor = [UIColor colorWithRed:85.0f / 255.0f green:85.0f / 255.0f blue:85.0f / 255.0f alpha:1.0f];
    headerLabel.font = [UIFont systemFontOfSize:17];
    
    [headerView addSubview:headerLabel];
    
    return headerView;
}

// set up row

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"stefanie"];
    
    cell.textLabel.text = rowArray[indexPath.section][indexPath.row];
    cell.textLabel.textColor = [UIColor colorWithRed:128 / 255.0 green:127 / 255.0 blue:125 / 255.0 alpha:1];
    cell.textLabel.font = [UIFont systemFontOfSize:17];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    if (indexPath.section == 0) {
        UISwitch *nightModeSwitch = [UISwitch new];
        cell.accessoryView = nightModeSwitch;
    } else if (indexPath.section == 2 && indexPath.row == 3) {
        UILabel *versionLabel = [UILabel new];
        versionLabel.text = @"1.0";
        versionLabel.textColor = [UIColor colorWithRed:135 / 255.0 green:135 / 255.0 blue:135 / 255.0 alpha:1];
        versionLabel.font = [UIFont systemFontOfSize:17];
        cell.accessoryView = versionLabel;
        [versionLabel sizeToFit];
    } else if (indexPath.section == 3) {
        cell.textLabel.textAlignment = NSTextAlignmentCenter;
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    
    return cell;
}


#pragma mark - TableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}



@end
