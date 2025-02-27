//
//  TOSOrderListBottomView.m
//  TOSClientKit
//
//  Created by 李成 on 2024/10/31.
//  Copyright © 2024 YanBo. All rights reserved.
//  底部自定义参数区域

#import "TOSOrderListBottomView.h"
#import "TIMConstants.h"
#import "TIMMasonry.h"
#import "YYKit.h"

@interface TOSOrderListBottomView ()

/// 分割线
@property (nonatomic, strong) UIView                * lineView;

/// 更多按钮
@property (nonatomic, strong) UIButton                * moreView;


@end


@implementation TOSOrderListBottomView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
        [self addSubview:self.lineView];
        [self addSubview:self.moreView];
        
        [self.lineView mas_TIMmakeTIMConstraints:^(TIMMASConstraintMaker *make) {
            make.left.mas_TIMequalTo(12.0f);
            make.right.mas_TIMequalTo(-12.0f);
            make.height.mas_TIMequalTo(1.0f);
            make.top.mas_TIMequalTo(0.0f);
        }];
        
        [self.moreView mas_TIMmakeTIMConstraints:^(TIMMASConstraintMaker *make) {
            make.bottom.mas_TIMequalTo(0);
            make.height.mas_TIMequalTo(30.0f);
            make.centerX.equalTo(self.mas_TIMcenterX);
            make.width.mas_TIMequalTo(40.0f);
        }];
        
        
    }
    return self;
}


#pragma mark - action

- (void)moreTouch {
    
    self.moreView.selected = !self.moreView.selected;
    
//    if (self.moreView.isSelected) {
//        NSLog(@"点击更多，需要展开");
//    }
//    else {
//        NSLog(@"点击更多，需要收起");
//    }
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(TOSOrderListBottomViewMoreClink)]) {
        [self.delegate TOSOrderListBottomViewMoreClink];
    }
    
    
}


#pragma mark - setter/getter

- (void)setModel:(TOSOrderListModel *)model {
    _model = model;
    
    
    if (model.extraInfoArr.count > 3) {
        self.moreView.hidden = NO;
    }
    else {
        self.moreView.hidden = YES;
    }
    /// 更多按钮的选中状态
    self.moreView.selected = model.showMore;
    
    for (UIView * item in self.subviews) {
        if ([item isKindOfClass:[UILabel class]]) {
            [item removeFromSuperview];
        }
    }
    
    CGFloat top = 8.0f;
    for (NSInteger i = 0; i < model.extraInfoArr.count; i++) {
        NSDictionary * dict = model.extraInfoArr[i];
        NSString * textStr = @"";
        if ([[dict allKeys] containsObject:@"name"]) {
            textStr = [NSString stringWithFormat:@"%@:", dict[@"name"]];
        }
        if ([[dict allKeys] containsObject:@"value"]) {
            textStr = [NSString stringWithFormat:@"%@%@", textStr, dict[@"value"]];
        }
        UILabel * label = [[UILabel alloc] initWithFrame:(CGRectMake(12.0, top, App_Frame_Width-32.0-24.0, 18.0f))];
        label.text = textStr;
        label.font = [UIFont fontWithName:@"PingFangSC-Regular" size:12.0f];
        label.textColor = [UIColor colorWithHexString:@"#8C8C8C"];
        label.lineBreakMode = NSLineBreakByTruncatingTail;
        [self addSubview:label];
        top += 18.0f + 4.0f;
        if (i > 2 && !model.showMore) {
            label.hidden = YES;
        }
    }
    
}



#pragma mark - lazy

- (UIView *)lineView {
    if (!_lineView) {
        _lineView = [[UIView alloc] initWithFrame:(CGRectZero)];
        _lineView.backgroundColor = [[UIColor colorWithHexString:@"#000000"] colorWithAlphaComponent:0.1f];
        
    }
    return _lineView;
}

- (UIButton *)moreView {
    if (!_moreView) {
        _moreView = [[UIButton alloc] initWithFrame:(CGRectZero)];
        [_moreView setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@/%@", FRAMEWORKS_BUNDLE_PATH, @"order_downArrow"]] forState:(UIControlStateNormal)];
        [_moreView setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@/%@", FRAMEWORKS_BUNDLE_PATH, @"order_upArrow"]] forState:(UIControlStateSelected)];
        [_moreView addTarget:self action:@selector(moreTouch) forControlEvents:(UIControlEventTouchUpInside)];
        
    }
    return _moreView;
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
