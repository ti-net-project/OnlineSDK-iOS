//
//  TOSOrderNoDataView.m
//  TOSClientKit
//
//  Created by 李成 on 2024/10/31.
//  Copyright © 2024 YanBo. All rights reserved.
//  无数据占位图

#import "TOSOrderNoDataView.h"
#import "TIMMasonry.h"
#import "TIMConstants.h"
#import "YYKit.h"

@interface TOSOrderNoDataView ()

/// 图片
@property (nonatomic, strong) UIImageView                * iconView;

/// 描述
@property (nonatomic, strong) UILabel                * describeView;



@end



@implementation TOSOrderNoDataView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
        [self addSubview:self.iconView];
        [self addSubview:self.describeView];
        
        [self.iconView mas_TIMmakeTIMConstraints:^(TIMMASConstraintMaker *make) {
            make.centerX.equalTo(self.mas_TIMcenterX);
            make.width.mas_TIMequalTo(140.0f);
            make.height.mas_TIMequalTo(91.0f);
            make.top.mas_TIMequalTo(0.0f);
        }];
        
        [self.describeView mas_TIMmakeTIMConstraints:^(TIMMASConstraintMaker *make) {
            make.left.right.mas_TIMequalTo(0);
            make.top.equalTo(self.iconView.mas_TIMbottom).offset(2);
            make.height.mas_TIMequalTo(18.0f);
        }];
        
        
    }
    return self;
}


#pragma mark - lazy

- (UIImageView *)iconView {
    if (!_iconView) {
        _iconView = [[UIImageView alloc] initWithFrame:(CGRectZero)];
        _iconView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@/%@", FRAMEWORKS_BUNDLE_PATH, @"order_noData"]];
        
    }
    return _iconView;
}

- (UILabel *)describeView {
    if (!_describeView) {
        _describeView = [[UILabel alloc] initWithFrame:(CGRectZero)];
        _describeView.textColor = [UIColor colorWithHexString:@"#BFBFBF"];
        _describeView.font = [UIFont fontWithName:@"PingFangSC-Regular" size:14.0f];
        _describeView.textAlignment = NSTextAlignmentCenter;
        _describeView.text = @"暂无数据";
        
    }
    return _describeView;
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
