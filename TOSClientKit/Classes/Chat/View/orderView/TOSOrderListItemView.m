//
//  TOSOrderListItemView.m
//  TOSClientKit
//
//  Created by 李成 on 2024/10/31.
//  Copyright © 2024 YanBo. All rights reserved.
//  订单信息item

#import "TOSOrderListItemView.h"
#import "TIMMasonry.h"
#import "TIMConstants.h"
#import "TIMYYKit.h"


@interface TOSOrderListItemView ()

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

/// 功能按钮父视图
@property (nonatomic, strong) UIView                * functionBgView;

@end




@implementation TOSOrderListItemView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.userInteractionEnabled = YES;
        
        [self addSubview:self.iconView];
        [self.iconView addSubview:self.tipsView];
        [self addSubview:self.titleView];
        [self addSubview:self.priceView];
        [self addSubview:self.subTitleView];
        [self addSubview:self.numberView];
        [self addSubview:self.tagView];
        [self addSubview:self.statusView];
        [self addSubview:self.functionBgView];
        
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
            make.width.mas_TIMequalTo(70.0f);
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
        
        [self.statusView mas_TIMmakeTIMConstraints:^(TIMMASConstraintMaker *make) {
            make.right.equalTo(self.priceView.mas_TIMright);
            make.height.mas_TIMequalTo(18.0);
            make.width.mas_TIMequalTo(60.0f);
            make.top.equalTo(self.numberView.mas_TIMbottom).offset(2.0f);
        }];
        
        [self.tagView mas_TIMmakeTIMConstraints:^(TIMMASConstraintMaker *make) {
            make.top.equalTo(self.subTitleView.mas_TIMbottom).offset(2.0);
            make.height.mas_TIMequalTo(18.0f);
            make.left.equalTo(self.subTitleView.mas_TIMleft);
            make.width.mas_TIMequalTo(0.0f);
//            make.right.equalTo(self.statusView.mas_TIMleft).offset(-8);
        }];
        
        [self.functionBgView mas_TIMmakeTIMConstraints:^(TIMMASConstraintMaker *make) {
            make.left.mas_TIMequalTo(12.0f);
            make.right.mas_TIMequalTo(-12.0f);
            make.bottom.mas_TIMequalTo(-4.0f);
            make.top.equalTo(self.tagView.mas_TIMbottom).offset(4.0f);
        }];
        
        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapTouch)];
        [self addGestureRecognizer:tap];
        
        
    }
    return self;
}

/// 订单商品卡片视图点击
- (void)tapTouch {
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(TOSOrderListItemViewCradTouchClick:withModel:)]) {
        [self.delegate TOSOrderListItemViewCradTouchClick:self.tag withModel:self.model];
    }
    
    
}

/// 判断是否是16进制的颜色
- (BOOL)isValidHexColor:(NSString *)colorString {
    // 移除开头的“#”符号，如果存在的话
    if ([colorString hasPrefix:@"#"]) {
        colorString = [colorString substringFromIndex:1];
    }
    
    // 正则表达式：匹配 3、6 或 8 位的 16 进制字符
    NSString *hexColorRegex = @"^[0-9A-Fa-f]{3}([0-9A-Fa-f]{3})?$|^[0-9A-Fa-f]{8}$";
    NSPredicate *hexColorPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", hexColorRegex];
    
    return [hexColorPredicate evaluateWithObject:colorString];
}

#pragma mark - action

- (void)itemTouch:(UIButton *)sender {
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(TOSOrderListItemViewFunctionClick:withModel:)]) {
        [self.delegate TOSOrderListItemViewFunctionClick:sender.tag withModel:self.model];
    }
    
}

#pragma mark - setter/getter

- (void)setModel:(TOSOrderListProductModel *)model {
    _model = model;
    
//    [self.iconView setImageWithURL:[NSURL URLWithString:model.img] options:(YYWebImageOptionProgressive)];
    /// 使用占位图
    [self.iconView setImageWithURL:[NSURL URLWithString:model.img] placeholder:[UIImage imageNamed:[NSString stringWithFormat:@"%@/%@", FRAMEWORKS_BUNDLE_PATH, @"message_order_placeholder"]]];
//    NSLog(@"商品图片的地址：%@", model.img);
    CGFloat imageWidth = 72.0f;
    if (model.img.length) {
        [self.iconView mas_TIMupdateTIMConstraints:^(TIMMASConstraintMaker *make) {
            make.width.mas_TIMequalTo(72.0f);
        }];
        [self.titleView mas_TIMupdateTIMConstraints:^(TIMMASConstraintMaker *make) {
            make.left.equalTo(self.iconView.mas_TIMright).offset(12.0f);
        }];
    }
    else {
        imageWidth = 0.0f;
        [self.iconView mas_TIMupdateTIMConstraints:^(TIMMASConstraintMaker *make) {
            make.width.mas_TIMequalTo(0.0f);
        }];
        [self.titleView mas_TIMupdateTIMConstraints:^(TIMMASConstraintMaker *make) {
            make.left.equalTo(self.mas_TIMleft).offset(12.0f);
        }];
    }
    
    if (model.imgTag.length) {
        self.tipsView.hidden = NO;
        self.tipsView.text = model.imgTag;
    }
    else {
        self.tipsView.hidden = YES;
    }
    self.titleView.text = model.title;
    self.subTitleView.text = model.subtitle?:@"";
    self.priceView.text = model.price?:@"";
    self.numberView.text = model.amount?:@"";
    self.tagView.text = model.remark?:@"";
    self.statusView.text = model.status?:@"";
    
    if (model.subtitle.length) {
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
    
    
    CGSize statusTextSize = [self.statusView.text boundingRectWithSize:CGSizeMake(124.0, MAXFLOAT)
                                         options:(NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading)
                                        attributes:@{NSFontAttributeName: [UIFont fontWithName:@"PingFangSC-Regular" size:13.0]}
                                         context:nil].size;
    [self.statusView mas_TIMupdateTIMConstraints:^(TIMMASConstraintMaker *make) {
        make.width.mas_TIMequalTo(statusTextSize.width);
    }];
    
    /// tag最大的显示区域
    CGFloat tagMaxWidth = CGRectGetWidth(self.frame) - (imageWidth==0?0:84.0f) - ceil(statusTextSize.width) - 12.0f - 12.0f;
    /// tag文本展开需要的size
    CGSize tagTextSize = [self.tagView.text boundingRectWithSize:CGSizeMake(tagMaxWidth, MAXFLOAT)
                                         options:(NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading)
                                        attributes:@{NSFontAttributeName: [UIFont fontWithName:@"PingFangSC-Regular" size:13.0]}
                                         context:nil].size;
    NSLog(@"self.frame : %lf   tagTextSize.width: %lf   statusTextSize.width: %lf", CGRectGetWidth(self.frame), ceil(tagTextSize.width), ceil(statusTextSize.width));
    
//    if ((ceil(tagTextSize.width)+96.0+ceil(statusTextSize.width)+24.0f) > CGRectGetWidth(self.frame)) {
//        [self.tagView mas_TIMupdateTIMConstraints:^(TIMMASConstraintMaker *make) {
//            make.width.mas_TIMequalTo(tagWidth);
//        }];
//    }
//    else {
//
//    }
    [self.tagView mas_TIMupdateTIMConstraints:^(TIMMASConstraintMaker *make) {
        make.width.mas_TIMequalTo(ceil(tagTextSize.width));
    }];
    
    if (model.buttonConfigList.count) {
        ///  icon 占用区域的宽度为 72.0，默认为0.0
        CGFloat iconWidth = 0.0;
        if ([model.img isNotBlank]) {
            iconWidth = 72.0f;
        }
        /// 按钮最大宽度
        CGFloat buttonMaxWidth = 124.0;
        /// 按钮的高度
        CGFloat buttonHeight = 26.0;
        /// 按钮间距
        CGFloat spacing = 8.0;
        /// 父视图的宽度
        CGFloat totalWidth = App_Frame_Width-32.0f-24.0;
        /// 从右向左开始布局
        CGFloat xPosition = totalWidth;
        /// 初始 y 坐标
        CGFloat yPosition = 4.0;
        /// 标记当前是否为第一行
        BOOL isFirstRow = YES;
        NSArray<TOSOrderButtonConfigModel *> * itemsArray = model.buttonConfigList;
        for (NSInteger i = 0; i < model.buttonConfigList.count; i++) {
            
            TOSOrderButtonConfigModel * buttonConfig = itemsArray[i];
            // 计算按钮宽度
            CGFloat buttonWidth = [self widthForButtonWithTitle:buttonConfig.text maxWidth:buttonMaxWidth];
            // 检查是否需要换行
            if (isFirstRow) {
                // 第一行按钮布局需要考虑 icon 的宽度
                if (xPosition - buttonWidth < iconWidth) {
                    // 换行，重置 x 位置并增加 y 位置
                    xPosition = totalWidth;
                    yPosition += buttonHeight + spacing;
                    /// 后续行不需要考虑 icon 占位
                    isFirstRow = NO;
//                    /// 每行右侧第一个按钮
//                    isFirstButtonInRow = YES;
                }
            } else {
                // 非第一行布局时
                if (xPosition - buttonWidth < spacing) {
                    // 换行，重置 x 位置并增加 y 位置
                    xPosition = totalWidth;
                    yPosition += buttonHeight + spacing;
//                    /// 每行右侧第一个按钮
//                    isFirstButtonInRow = YES;
                }
            }
            UIButton * btn = [[UIButton alloc] initWithFrame:(CGRectZero)];
            [btn setTitle:[NSString stringWithFormat:@"%@", buttonConfig.text] forState:(UIControlStateNormal)];
            if (buttonConfig.style != nil) {
                if ([[buttonConfig.style allKeys] containsObject:@"color"] && [self isValidHexColor:buttonConfig.style[@"color"]]) {
                    [btn setTitleColor:[UIColor colorWithHexString:[NSString stringWithFormat:@"%@", buttonConfig.style[@"color"]]] forState:(UIControlStateNormal)];
                } else {
                    [btn setTitleColor:[UIColor colorWithHexString:@"#595959"] forState:(UIControlStateNormal)];
                }
                if ([[buttonConfig.style allKeys] containsObject:@"background"] && [self isValidHexColor:buttonConfig.style[@"background"]]) {
                    btn.backgroundColor = [UIColor colorWithHexString:[NSString stringWithFormat:@"%@", buttonConfig.style[@"background"]]];
                } else {
                    btn.backgroundColor = [UIColor colorWithHexString:@"#F9F9F9"];
                }
                
            }
            else {
                [btn setTitleColor:[UIColor colorWithHexString:@"#595959"] forState:(UIControlStateNormal)];
                btn.backgroundColor = [UIColor colorWithHexString:@"#F9F9F9"];
            }
            
            btn.titleLabel.lineBreakMode = NSLineBreakByTruncatingTail;
            btn.titleLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:12.0f];
            btn.titleEdgeInsets = UIEdgeInsetsMake(0.0, 14.0, 0.0, 14.0);
            btn.tag = i;
            btn.layer.cornerRadius = 13.0f;
            btn.layer.masksToBounds = YES;
            [btn addTarget:self action:@selector(itemTouch:) forControlEvents:(UIControlEventTouchUpInside)];
            
            [self.functionBgView addSubview:btn];
            
            [btn mas_TIMmakeTIMConstraints:^(TIMMASConstraintMaker *make) {
                make.left.mas_TIMequalTo(xPosition - buttonWidth);
                make.top.mas_TIMequalTo(yPosition);
                make.width.mas_TIMequalTo(buttonWidth);
                make.height.mas_TIMequalTo(26.0f);
            }];
            
            /// 更新下一个按钮的 x 位置
            xPosition -= (buttonWidth + spacing);
            
        }
    }
    
}

/// 根据按钮标题计算按钮的宽度，限制最大宽度
- (CGFloat)widthForButtonWithTitle:(NSString *)title maxWidth:(CGFloat)maxWidth {
    NSDictionary *attributes = @{NSFontAttributeName: [UIFont systemFontOfSize:13]};
    CGSize size = [title sizeWithAttributes:attributes];
    return MIN(size.width + 28.0, maxWidth); // 添加20.0用于按钮的内边距
}


#pragma mark - lazy

- (UIImageView *)iconView {
    if (!_iconView) {
        _iconView = [[UIImageView alloc] initWithFrame:(CGRectZero)];
        _iconView.layer.cornerRadius = TOSKitCustomInfo.shareCustomInfo.orderDrawer.productIconCorner;
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
        _tipsView.layer.cornerRadius = TOSKitCustomInfo.shareCustomInfo.orderDrawer.productIconCorner;
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
        _tagView.font = [UIFont fontWithName:@"PingFangSC-Regular" size:12.0];
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
        _statusView.font = [UIFont fontWithName:@"PingFangSC-Medium" size:12.0];
        _statusView.textColor = [UIColor colorWithHexString:@"#8C8C8C"];
        _statusView.textAlignment = NSTextAlignmentRight;
        
    }
    return _statusView;
}

- (UIView *)functionBgView {
    if (!_functionBgView) {
        _functionBgView = [[UIView alloc] initWithFrame:(CGRectZero)];
    }
    return _functionBgView;
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
