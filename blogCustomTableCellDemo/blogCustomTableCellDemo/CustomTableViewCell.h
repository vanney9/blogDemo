//
//  CustomTableViewCell.h
//  blogCustomTableCellDemo
//
//  Created by vanney on 16/3/8.
//  Copyright © 2016年 vanney. All rights reserved.
//

#import <UIKit/UIKit.h>

#define kCellIdentifierText @"vanney_text"
#define kCellIdentifierPassword @"vanney_password"

@interface CustomTableViewCell : UITableViewCell

@property (nonatomic, strong) UITextField *textField;

- (void)setPlaceholder:(NSString *)phStr value:(NSString *)valueStr;

@end
