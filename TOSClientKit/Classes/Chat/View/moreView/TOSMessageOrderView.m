//
//  TOSMessageOrderView.m
//  TOSClientKit
//
//  Created by 李成 on 2024/10/30.
//  Copyright © 2024 YanBo. All rights reserved.
//

#import "TOSMessageOrderView.h"
#import "TIMConstants.h"
#import "TIMYYKit.h"
#import "TIMMasonry.h"
#import "UIImageView+YYWebImage.h"

@interface TOSMessageOrderView ()

/// 订单图片
@property (nonatomic, strong) UIImageView                * iconView;

/// 提示
@property (nonatomic, strong) UILabel                * tipsView;

/// 标题
@property (nonatomic, strong) UILabel                * titleView;

/// 价格
@property (nonatomic, strong) UILabel                * priceView;

/// 描述
@property (nonatomic, strong) UILabel                * subTitleView;

/// 数量
@property (nonatomic, strong) UILabel                * numberView;

/// 标签
@property (nonatomic, strong) UILabel                * tagView;

/// 状态
@property (nonatomic, strong) UILabel                * statusView;

@end

@implementation TOSMessageOrderView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.iconView];
        [self.iconView addSubview:self.tipsView];
        [self addSubview:self.titleView];
        [self addSubview:self.priceView];
        [self addSubview:self.subTitleView];
        [self addSubview:self.numberView];
        [self addSubview:self.tagView];
        [self addSubview:self.statusView];
        
        [self.iconView mas_TIMmakeTIMConstraints:^(TIMMASConstraintMaker *make) {
            make.leading.top.mas_TIMequalTo(12.0f);
            make.width.mas_TIMequalTo(72.0f);
            make.height.mas_TIMequalTo(72.0f);
        }];
        
        [self.tipsView mas_TIMmakeTIMConstraints:^(TIMMASConstraintMaker *make) {
            make.leading.top.mas_TIMequalTo(0.0f);
            make.width.mas_TIMequalTo(45.0f);
            make.height.mas_TIMequalTo(17.0f);
        }];
        
        [self.priceView mas_TIMmakeTIMConstraints:^(TIMMASConstraintMaker *make) {
            make.height.mas_TIMequalTo(22.0f);
            make.right.mas_TIMequalTo(-12.0f);
            make.width.mas_TIMequalTo(46.0f);
            make.top.equalTo(self.iconView.mas_TIMtop);
        }];
        
        [self.titleView mas_TIMmakeTIMConstraints:^(TIMMASConstraintMaker *make) {
            make.left.equalTo(self.iconView.mas_TIMright).offset(12.0f);
            make.top.equalTo(self.iconView.mas_TIMtop);
            make.right.equalTo(self.priceView.mas_TIMleft).offset(-12);
            make.height.mas_TIMequalTo(22.0f);
        }];
        
        [self.numberView mas_TIMmakeTIMConstraints:^(TIMMASConstraintMaker *make) {
            make.height.mas_TIMequalTo(18.0f);
            make.right.equalTo(self.priceView.mas_TIMright);
            make.width.mas_TIMequalTo(46.0f);
            make.top.equalTo(self.priceView.mas_TIMbottom).offset(2.0f);
        }];
        
        [self.subTitleView mas_TIMmakeTIMConstraints:^(TIMMASConstraintMaker *make) {
            make.left.equalTo(self.titleView.mas_TIMleft);
            make.top.equalTo(self.titleView.mas_TIMbottom).offset(2.0);
            make.height.mas_TIMequalTo(18.0f);
            make.right.equalTo(self.numberView.mas_TIMleft).offset(-12.0);
        }];
        
        [self.tagView mas_TIMmakeTIMConstraints:^(TIMMASConstraintMaker *make) {
            make.top.equalTo(self.subTitleView.mas_TIMbottom).offset(9.0);
            make.height.mas_TIMequalTo(16.0f);
            make.left.equalTo(self.subTitleView.mas_TIMleft);
            make.width.mas_TIMequalTo(41.0f);
        }];
        
        [self.statusView mas_TIMmakeTIMConstraints:^(TIMMASConstraintMaker *make) {
            make.right.equalTo(self.priceView.mas_TIMright);
            make.height.mas_TIMequalTo(22.0);
            make.width.mas_TIMequalTo(42.0f);
            make.top.equalTo(self.numberView.mas_TIMbottom).offset(6.0f);
        }];
        
        
        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapTouch)];
        [self addGestureRecognizer:tap];
        
    }
    return self;
}

- (void)tapTouch {
    
    if (self.clickTouch) {
        self.clickTouch(self.productModel);
    }
    
}


#pragma mark - setter

- (void)setProductModel:(TOSOrderProductModel *)productModel {
    _productModel = productModel;
    
    [self.iconView setImageWithURL:[NSURL URLWithString:productModel.img] placeholder:[UIImage imageNamed:[NSString stringWithFormat:@"%@/%@", FRAMEWORKS_BUNDLE_PATH, @"message_order_placeholder"]]];
    
    if (productModel.img.length) {
        [self.iconView mas_TIMupdateTIMConstraints:^(TIMMASConstraintMaker *make) {
            make.width.mas_TIMequalTo(72.0f);
        }];
        [self.titleView mas_TIMupdateTIMConstraints:^(TIMMASConstraintMaker *make) {
            make.left.equalTo(self.iconView.mas_TIMright).offset(12.0f);
        }];
    }
    else {
        [self.iconView mas_TIMupdateTIMConstraints:^(TIMMASConstraintMaker *make) {
            make.width.mas_TIMequalTo(0.0f);
        }];
        [self.titleView mas_TIMupdateTIMConstraints:^(TIMMASConstraintMaker *make) {
            make.left.equalTo(self.mas_TIMleft).offset(12.0f);
        }];
    }
    
    if (productModel.imgTag.length) {
        self.tipsView.hidden = NO;
        self.tipsView.text = productModel.imgTag;
    }
    else {
        self.tipsView.hidden = YES;
    }
    self.titleView.text = productModel.title;
    self.subTitleView.text = productModel.subtitle?:@"";
    self.priceView.text = productModel.price?:@"";
    self.numberView.text = productModel.amount?:@"";
    self.tagView.text = productModel.remark?:@"";
    self.statusView.text = productModel.status?:@"";
    
    if (productModel.subtitle.length) {
        [self.titleView mas_TIMupdateTIMConstraints:^(TIMMASConstraintMaker *make) {
            make.height.mas_TIMequalTo(22.0f);
        }];
        [self.subTitleView mas_TIMupdateTIMConstraints:^(TIMMASConstraintMaker *make) {
            make.height.mas_TIMequalTo(18.0f);
        }];
    } else {
        [self.titleView mas_TIMupdateTIMConstraints:^(TIMMASConstraintMaker *make) {
            make.height.mas_TIMequalTo(42.0f);
        }];
        [self.subTitleView mas_TIMupdateTIMConstraints:^(TIMMASConstraintMaker *make) {
            make.height.mas_TIMequalTo(0.0f);
        }];
    }
    
    CGSize priceTextSize = [self.priceView.text boundingRectWithSize:CGSizeMake(124.0, MAXFLOAT)
                                         options:(NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading)
                                        attributes:@{NSFontAttributeName: [UIFont fontWithName:@"PingFangSC-Regular" size:15.0]}
                                         context:nil].size;
    [self.priceView mas_TIMupdateTIMConstraints:^(TIMMASConstraintMaker *make) {
        make.width.mas_TIMequalTo(ceil(priceTextSize.width));
    }];
    
    
    
    CGSize statusTextSize = [self.statusView.text boundingRectWithSize:CGSizeMake(124.0, MAXFLOAT)
                                         options:(NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading)
                                        attributes:@{NSFontAttributeName: [UIFont fontWithName:@"PingFangSC-Medium" size:15.0]}
                                         context:nil].size;
    [self.statusView mas_TIMupdateTIMConstraints:^(TIMMASConstraintMaker *make) {
        make.width.mas_TIMequalTo(ceil(statusTextSize.width));
    }];
    
    /// tag最大的显示区域
    CGFloat tagWidth = CGRectGetWidth(self.frame) - 84.0f - ceil(statusTextSize.width) - 12.0f - 12.0f;
    /// tag文本展开需要的size
    CGSize tagTextSize = [self.tagView.text boundingRectWithSize:CGSizeMake(tagWidth, MAXFLOAT)
                                         options:(NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading)
                                        attributes:@{NSFontAttributeName: [UIFont fontWithName:@"PingFangSC-Regular" size:13.0]}
                                         context:nil].size;
    
    if ((ceil(tagTextSize.width)+84.0+ceil(statusTextSize.width)+24.0f) > CGRectGetWidth(self.frame)) {
        [self.tagView mas_TIMupdateTIMConstraints:^(TIMMASConstraintMaker *make) {
            make.width.mas_TIMequalTo(tagWidth);
        }];
    }
    else {
        [self.tagView mas_TIMupdateTIMConstraints:^(TIMMASConstraintMaker *make) {
            make.width.mas_TIMequalTo(ceil(tagTextSize.width));
        }];
    }
    
}


#pragma mark - lazy

- (UIImageView *)iconView {
    if (!_iconView) {
        _iconView = [[UIImageView alloc] initWithFrame:(CGRectZero)];
        _iconView.layer.cornerRadius = 6.0f;
        _iconView.layer.masksToBounds = YES;
        
    }
    return _iconView;
}

- (UILabel *)tipsView {
    if (!_tipsView) {
        _tipsView = [[UILabel alloc] initWithFrame:(CGRectZero)];
        _tipsView.textAlignment = NSTextAlignmentCenter;
        _tipsView.textColor = [UIColor colorWithHexString:@"#FFFFFF"];
        _tipsView.font = [UIFont fontWithName:@"PingFangSC-Regular" size:9];
        _tipsView.backgroundColor = [UIColor colorWithHexString:@"#3E3E3E"];
        if (@available(iOS 11.0, *)) {
            _tipsView.layer.maskedCorners = kCALayerMinXMinYCorner | kCALayerMaxXMaxYCorner;
        }
        _tipsView.layer.cornerRadius = 6.0f;
        _tipsView.layer.masksToBounds = YES;
        
        
    }
    return _tipsView;
}

- (UILabel *)titleView {
    if (!_titleView) {
        _titleView = [[UILabel alloc] initWithFrame:(CGRectZero)];
        _titleView.font = [UIFont fontWithName:@"PingFangSC-Medium" size:14.0];
        _titleView.textColor = [UIColor colorWithHexString:@"#262626"];
        _titleView.numberOfLines = 2;
        
    }
    return _titleView;
}

- (UILabel *)priceView {
    if (!_priceView) {
        _priceView = [[UILabel alloc] initWithFrame:(CGRectZero)];
        _priceView.font = [UIFont fontWithName:@"PingFangSC-Regular" size:14.0];
        _priceView.textColor = [UIColor colorWithHexString:@"#262626"];
        _priceView.textAlignment = NSTextAlignmentRight;
        
    }
    return _priceView;
}

- (UILabel *)subTitleView {
    if (!_subTitleView) {
        _subTitleView = [[UILabel alloc] initWithFrame:(CGRectZero)];
        _subTitleView.textColor = [UIColor colorWithHexString:@"#8C8C8C"];
        _subTitleView.font = [UIFont fontWithName:@"PingFangSC-Regular" size:12.0];
        
    }
    return _subTitleView;
}

- (UILabel *)numberView {
    if (!_numberView) {
        _numberView = [[UILabel alloc] initWithFrame:(CGRectZero)];
        _numberView.textColor = [UIColor colorWithHexString:@"#8C8C8C"];
        _numberView.font = [UIFont fontWithName:@"PingFangSC-Regular" size:12.0];
        _numberView.textAlignment = NSTextAlignmentRight;
        
    }
    return _numberView;
}

- (UILabel *)tagView {
    if (!_tagView) {
        _tagView = [[UILabel alloc] initWithFrame:(CGRectZero)];
        _tagView.textColor = [UIColor colorWithHexString:@"#EA5C66"];
        _tagView.font = [UIFont fontWithName:@"PingFangSC-Regular" size:11.0];
        _tagView.textAlignment = NSTextAlignmentCenter;
        _tagView.layer.borderWidth = 1.0f;
        _tagView.layer.borderColor = [UIColor colorWithHexString:@"#FEBFC4"].CGColor;
        _tagView.layer.cornerRadius = 2.0f;
        _tagView.layer.masksToBounds = YES;
        
    }
    return _tagView;
}

- (UILabel *)statusView {
    if (!_statusView) {
        _statusView = [[UILabel alloc] initWithFrame:(CGRectZero)];
        _statusView.font = [UIFont fontWithName:@"PingFangSC-Medium" size:14.0];
        _statusView.textColor = [UIColor colorWithHexString:@"#8C8C8C"];
        _statusView.textAlignment = NSTextAlignmentRight;
        
    }
    return _statusView;
}



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
