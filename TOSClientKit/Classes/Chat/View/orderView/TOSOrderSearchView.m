//
//  TOSOrderSearchView.m
//  TOSClientKit
//
//  Created by 李成 on 2024/10/30.
//  Copyright © 2024 YanBo. All rights reserved.
//  订单抽屉的顶部搜索区域

#import "TOSOrderSearchView.h"
#import "TIMMasonry.h"
#import "TIMConstants.h"
#import "TIMYYKit.h"

@interface TOSOrderSearchView ()<UITextFieldDelegate>

/// 输入框
@property (nonatomic, strong) UITextField                * textField;

@property (nonatomic, strong) UIButton                * searchView;

@end




@implementation TOSOrderSearchView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
        [self addSubview:self.textField];
        [self addSubview:self.searchView];
        
        [self.textField mas_TIMmakeTIMConstraints:^(TIMMASConstraintMaker *make) {
            make.left.mas_TIMequalTo(16.0f);
            make.top.bottom.mas_TIMequalTo(0);
            make.width.mas_TIMequalTo(self.mas_TIMwidth).offset(-68.0f);
            
        }];
        
        [self.searchView mas_TIMmakeTIMConstraints:^(TIMMASConstraintMaker *make) {
            make.top.bottom.mas_TIMequalTo(0);
            make.right.mas_TIMequalTo(-12.0f);
            make.width.mas_TIMequalTo(40.0f);
        }];
        
        
    }
    return self;
}



#pragma mark - action

- (void)searchTouch {
    
    /// 输入框放弃第一响应者
    [self.textField resignFirstResponder];
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(TOSOrderSearchViewClickSearch:)]) {
        [self.delegate TOSOrderSearchViewClickSearch:self.textField.text];
    }
    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    if (self.delegate && [self.delegate respondsToSelector:@selector(TOSOrderSearchViewClickSearch:)]) {
        [self.delegate TOSOrderSearchViewClickSearch:textField.text];
    }
    return YES;
}

#pragma mark - setter

- (void)setPlaceholder:(NSString *)placeholder {
    _placeholder = placeholder;
    
    NSMutableAttributedString * attributedStr = [[NSMutableAttributedString alloc] initWithString:placeholder];
    [attributedStr addAttributes:@{
        NSForegroundColorAttributeName: [UIColor colorWithHexString:@"#BFBFBF"],
        NSFontAttributeName: [UIFont fontWithName:@"PingFangSC-Regular" size:14.0f],
    } range:(NSMakeRange(0, placeholder.length))];
    self.textField.attributedPlaceholder = attributedStr;
    
}


#pragma mark - lazy

- (UITextField *)textField {
    if (!_textField) {
        _textField = [[UITextField alloc] initWithFrame:(CGRectZero)];
        _textField.returnKeyType = UIReturnKeySend;
        _textField.delegate = self;
        _textField.font = [UIFont fontWithName:@"PingFangSC-Regular" size:14.0f];
        NSString *placeholderStr = @"请输入";
        NSMutableAttributedString * attributedStr = [[NSMutableAttributedString alloc] initWithString:placeholderStr];
        [attributedStr addAttributes:@{
            NSForegroundColorAttributeName: [UIColor colorWithHexString:@"#BFBFBF"],
            NSFontAttributeName: [UIFont fontWithName:@"PingFangSC-Regular" size:14.0f],
        } range:(NSMakeRange(0, placeholderStr.length))];
        _textField.attributedPlaceholder = attributedStr;
        _textField.backgroundColor = [UIColor colorWithHexString:@"#FFFFFF"];
        _textField.layer.cornerRadius = 8.0f;
        _textField.layer.masksToBounds = YES;
        // 左侧视图
        UIView * leftView = [[UIView alloc] initWithFrame:(CGRectMake(0, 0, 40.0, 36.0))];
        UIImageView * leftImageView = [[UIImageView alloc] initWithFrame:(CGRectMake(14, 8.0, 20.0, 20.0))];
        NSString *image = [NSString stringWithFormat:@"%@/%@",FRAMEWORKS_BUNDLE_PATH, @"order_search"];
        leftImageView.image = [UIImage imageNamed:image];
        [leftView addSubview:leftImageView];
        _textField.leftView = leftView;
        _textField.leftViewMode = UITextFieldViewModeAlways;
        _textField.textColor = [UIColor colorWithHexString:@"#262626"];
        
        
    }
    return _textField;
}

- (UIButton *)searchView {
    if (!_searchView) {
        _searchView = [[UIButton alloc] initWithFrame:(CGRectZero)];
        [_searchView setTitle:@"搜索" forState:(UIControlStateNormal)];
        [_searchView setTitleColor:[UIColor colorWithHexString:@"#262626"] forState:(UIControlStateNormal)];
        _searchView.titleLabel.font = [UIFont fontWithName:@"PingFangSC-Medium" size:14.0f];
        [_searchView addTarget:self action:@selector(searchTouch) forControlEvents:(UIControlEventTouchUpInside)];
        
        
    }
    return _searchView;
}



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
