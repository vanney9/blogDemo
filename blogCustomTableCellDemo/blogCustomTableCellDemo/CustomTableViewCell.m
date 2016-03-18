//
//  CustomTableViewCell.m
//  blogCustomTableCellDemo
//
//  Created by vanney on 16/3/8.
//  Copyright © 2016年 vanney. All rights reserved.
//

#import "CustomTableViewCell.h"
#import <Masonry.h>

@interface CustomTableViewCell ()

@property (nonatomic, strong) UIView *lineView;
@property (nonatomic, strong) UIButton *pwdBtn;

@end

@implementation CustomTableViewCell

#pragma mark - Life Cycle

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        if (!_textField) {
            _textField = [UITextField new];
            [_textField setFont:[UIFont systemFontOfSize:17]];
            [self.contentView addSubview:_textField];
            [_textField mas_makeConstraints:^(MASConstraintMaker *make) {
                make.leading.equalTo(self.contentView).offset(18);
                make.trailing.equalTo(self.contentView).offset(-18);
                make.height.mas_equalTo(20);
                make.centerY.equalTo(self.contentView);
            }];
        }
    }
    return self;
}


#pragma mark - Super Method

- (void)layoutSubviews {
    [super layoutSubviews];

    if (!_lineView) {
        _lineView = [UIView new];
        _lineView.backgroundColor = [UIColor colorWithRed:221 / 255 green:221 / 255 blue:221 / 255 alpha:1.0];
        [self.contentView addSubview:_lineView];
        [_lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(0.5);
            make.leading.equalTo(self.contentView).offset(18);
            make.trailing.equalTo(self.contentView);
            make.bottom.equalTo(self.contentView);
        }];
    }

    if ([self.reuseIdentifier isEqualToString:kCellIdentifierPassword]) {
        if (!_pwdBtn) {
            _textField.secureTextEntry = YES;

            _pwdBtn = [[UIButton alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width - 44 - 18, 0, 44, 44)];
            [_pwdBtn setImage:[UIImage imageNamed:@"password_unlook"] forState:UIControlStateNormal];
            [_pwdBtn addTarget:self action:@selector(pwdBtnClicked) forControlEvents:UIControlEventTouchUpInside];
            [self.contentView addSubview:_pwdBtn];

            [_textField mas_updateConstraints:^(MASConstraintMaker *make) {
                make.trailing.equalTo(self.contentView).offset(CGRectGetMinX(_pwdBtn.frame) - [UIScreen mainScreen].bounds.size.width);
            }];
        }
    }
}


#pragma mark - Public Method

- (void)setPlaceholder:(NSString *)phStr value:(NSString *)valueStr {
    _textField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:phStr ? phStr : @"" attributes:@{NSForegroundColorAttributeName : [UIColor colorWithRed:144.0 / 255.0 green:144.0 / 255.0 blue:144.0 / 255.0 alpha:1.0]}];
    _textField.text = valueStr;
}


#pragma mark - Button Clicked Event

- (void)pwdBtnClicked {
    _textField.secureTextEntry = !_textField.secureTextEntry;
    [_pwdBtn setImage:[UIImage imageNamed:_textField.secureTextEntry ? @"password_unlook" : @"password_look"] forState:UIControlStateNormal];
}

- (void)prepareForReuse {
    NSLog(@"vanney code log... this method is important in some situation");
}



@end
