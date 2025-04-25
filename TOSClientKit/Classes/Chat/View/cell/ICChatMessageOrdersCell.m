//
//  ICChatMessageOrdersCell.m
//  TOSClientKit
//
//  Created by 李成 on 2024/10/30.
//  Copyright © 2024 YanBo. All rights reserved.
//

#import "ICChatMessageOrdersCell.h"
#import "TOSMessageOrderView.h"
#import <TOSClientLib/TOSOrderMessage.h>
#import <TOSClientLib/NSObject+TIMModel.h>
#import "TIMMasonry.h"
#import "TIMConstants.h"
#import "TIMYYKit.h"
#import "SLButton.h"

@interface ICChatMessageOrdersCell ()

/// 查看更多
@property (nonatomic, strong) SLButton                * lookMoreView;

/// 展开按钮
@property (nonatomic, strong) UIButton                * moreView;

@end



@implementation ICChatMessageOrdersCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        
        
        
        
        
    }
    return self;
}


- (void)prepareForReuse {
    [super prepareForReuse];
    
    for (UIView * item in self.bubbleView.subviews) {
        [item removeFromSuperview];
    }
    
}


#pragma mark - action

- (void)lookMoreTouch {
    
    [self routerEventWithName:TinetRouterClickOrderCardEvent
                     userInfo:@{@"content"   : [self.modelFrame.model yy_modelToJSONObject]
                              }];
}


- (void)moreTouch {
//    NSLog(@"点击了更多按钮");
    self.moreView.selected = !self.moreView.selected;
    
    TOSOrderMessage * cardMessgae = (TOSOrderMessage *)self.modelFrame.model.message.extra;
    cardMessgae.showMore = self.moreView.selected;
    
    self.modelFrame.model = self.modelFrame.model;
    [self routerEventWithName:GXRobotCombinationHotIssueCellRefreshEventName
                     userInfo:@{MessageKey:self.modelFrame}];
    
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


#pragma mark - setter
- (void)setModelFrame:(TIMMessageFrame *)modelFrame {
    [super setModelFrame:modelFrame];
    
    TOSOrderMessage * cardMessgae = (TOSOrderMessage *)modelFrame.model.message.extra;
    
    if (cardMessgae.productList.count <= 0) {
//        NSLog(@"订单的原始数据为0");
//        NSLog(@"model:%@", [modelFrame.model.message className]);
        return;
    }
    
    for (UIView * item in self.bubbleView.subviews) {
        [item removeFromSuperview];
    }
    
    /// 头部的订单信息相关
    CGFloat top = cardMessgae.topOrderheight;
    TOSOrderMessageTopView * topView = [[TOSOrderMessageTopView alloc] initWithFrame:(CGRectMake(0, 0, CGRectGetWidth(modelFrame.chatLabelF), cardMessgae.topOrderheight))];
    topView.bubbleWidth = CGRectGetWidth(modelFrame.chatLabelF);
    topView.model = cardMessgae;
    [self.bubbleView addSubview:topView];
//    NSLog(@"订单消息的顶部的大小：%@", NSStringFromCGRect(topView.frame));
    
    NSInteger productListCount = cardMessgae.productList.count;
    if (cardMessgae.showMore == NO && productListCount > 3) {
        productListCount = 3;
    }
    __weak typeof(self) weakSelf = self;
    /// 商品item
    for (NSInteger i = 0; i < productListCount; i++) {
        TOSOrderProductModel * productModel = cardMessgae.productList[i];
        TOSMessageOrderView * orderView = [[TOSMessageOrderView alloc] initWithFrame:CGRectMake(0, top, CGRectGetWidth(modelFrame.chatLabelF), 84.0f)];
        orderView.productModel = productModel;
        orderView.clickTouch = ^(TOSOrderProductModel * _Nonnull model) {
            __strong typeof(weakSelf) strongSelf = weakSelf;
//            NSLog(@"商品的点击！");
            [strongSelf routerEventWithName:TinetRouterClickOrderCardEvent
                             userInfo:@{@"content"   : [model yy_modelToJSONObject]
                                      }];
        };
        [self.bubbleView addSubview:orderView];
        top += 84.0f+4.0f;
    }
    
    if ([cardMessgae.bottomButtonConfig allKeys].count) {
        if ([cardMessgae.bottomButtonConfig objectForKey:@"text"]) {
            NSString * text = cardMessgae.bottomButtonConfig[@"text"];
            self.lookMoreView.titleLabel.text = text;
            CGSize textSize = [text boundingRectWithSize:CGSizeMake(App_Frame_Width, MAXFLOAT)
                                                 options:(NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading)
                                                attributes:@{NSFontAttributeName: [UIFont fontWithName:@"PingFangSC-Regular" size:13.0]}
                                                 context:nil].size;
            self.lookMoreView.frame = CGRectMake(CGRectGetWidth(modelFrame.bubbleViewF)-(ceil(textSize.width)+56.0f), top+16.0, ceil(textSize.width)+56.0f, 20.0);
            /// 样式不为null
            if ([cardMessgae.bottomButtonConfig objectForKey:@"style"]) {
                NSDictionary * style = cardMessgae.bottomButtonConfig[@"style"];
                if ([[style allKeys] containsObject:@"color"] && [self isValidHexColor:style[@"color"]]) {
                    self.lookMoreView.titleLabel.textColor = [UIColor colorWithHexString:[NSString stringWithFormat:@"%@", style[@"color"]]];
                    
                } else {
                    self.lookMoreView.titleLabel.textColor = [UIColor colorWithHexString:@"#8C8C8C"];
                }
            }
            else {
                self.lookMoreView.titleLabel.textColor = [UIColor colorWithHexString:@"#8C8C8C"];
            }
            [self.bubbleView addSubview:self.lookMoreView];
            [self.lookMoreView setTitleImageLayoutStyle:(SLButtonStyleImageRight) space:4.0f];
            top += 36.0f;
        }
    }
    
    /// 更多按钮
    self.moreView.frame = CGRectMake(CGRectGetMidX(topView.frame)-20.0, top, 40.0f, 20.0f);
    [self.bubbleView addSubview:self.moreView];
    if (cardMessgae.productList.count > 3) {
        self.moreView.hidden = NO;
    } else {
        self.moreView.hidden = YES;
    }
    self.bubbleView.userInteractionEnabled = YES;
    
    
}

#pragma mark - lazy

- (SLButton *)lookMoreView {
    if (!_lookMoreView) {
        _lookMoreView = [[SLButton alloc] initWithFrame:(CGRectZero)];
        _lookMoreView.imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@/%@", FRAMEWORKS_BUNDLE_PATH, @"orderDrawer_rightArrow"]];
        _lookMoreView.titleLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:12.0f];
        [_lookMoreView addTarget:self action:@selector(lookMoreTouch) forControlEvents:(UIControlEventTouchUpInside)];
        
    }
    return _lookMoreView;
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



- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end


@interface TOSOrderMessageTopView ()

/// 店铺图标
@property (nonatomic, strong) UIImageView                * iconView;

/// 店铺名称
@property (nonatomic, strong) UILabel                * nameView;

/// 标签
@property (nonatomic, strong) UILabel                * tagView;

/// 状态
@property (nonatomic, strong) UILabel                * statusView;

/// 订单时间
@property (nonatomic, strong) UILabel                * timeView;

/// 单号
@property (nonatomic, strong) UILabel                * orderIdView;

@end


@implementation TOSOrderMessageTopView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
        [self addSubview:self.iconView];
        [self addSubview:self.nameView];
        [self addSubview:self.tagView];
        [self addSubview:self.statusView];
        [self addSubview:self.timeView];
        [self addSubview:self.orderIdView];
        
        [self.iconView mas_TIMmakeTIMConstraints:^(TIMMASConstraintMaker *make) {
            make.left.mas_TIMequalTo(12.0f);
            make.top.mas_TIMequalTo(13.0f);
            make.width.height.mas_TIMequalTo(20.0f);
        }];
        
        [self.statusView mas_TIMmakeTIMConstraints:^(TIMMASConstraintMaker *make) {
            make.right.mas_TIMequalTo(-12.0f);
            make.top.mas_TIMequalTo(12.0f);
            make.width.mas_TIMequalTo(60.0f);
            make.height.mas_TIMequalTo(22.0f);
        }];
        
        [self.nameView mas_TIMmakeTIMConstraints:^(TIMMASConstraintMaker *make) {
            make.left.equalTo(self.iconView.mas_TIMright).offset(8.0f);
//            make.right.equalTo(self.statusView.mas_TIMleft);
            make.width.mas_TIMequalTo(100.0f);
            make.height.mas_TIMequalTo(22.0f);
            make.top.equalTo(self.statusView.mas_TIMtop);
        }];
        
        [self.tagView mas_TIMmakeTIMConstraints:^(TIMMASConstraintMaker *make) {
            make.left.equalTo(self.nameView.mas_TIMright).offset(8.0f);
            make.height.mas_TIMequalTo(16.0f);
            make.centerY.equalTo(self.nameView.mas_TIMcenterY);
            make.width.mas_TIMequalTo(30.0f);
        }];
        
        [self.timeView mas_TIMmakeTIMConstraints:^(TIMMASConstraintMaker *make) {
            make.left.equalTo(self.iconView.mas_TIMleft);
            make.top.equalTo(self.iconView.mas_TIMbottom).offset(9.0f);
            make.height.mas_TIMequalTo(18.0f);
            make.width.mas_TIMequalTo(110.0f);
        }];
        
        [self.orderIdView mas_TIMmakeTIMConstraints:^(TIMMASConstraintMaker *make) {
            make.right.equalTo(self.statusView.mas_TIMright);
            make.top.equalTo(self.statusView.mas_TIMbottom).offset(8.0f);
            make.height.equalTo(self.timeView.mas_TIMheight);
            make.left.equalTo(self.timeView.mas_TIMright);
        }];
        
        
        
        
        
    }
    return self;
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



#pragma mark - setter/getter

- (void)setModel:(TOSOrderMessage *)model {
    _model = model;
    
    self.nameView.text = model.title?:@"";
    self.timeView.text = model.time?:@"";
//    self.tagView.text = model.tag;
    if ([model.tag allKeys].count) {
        if ([model.tag objectForKey:@"text"]) {
            self.tagView.text = [NSString stringWithFormat:@" %@ ", model.tag[@"text"]];
        }
        else {
            self.tagView.text = @"";
        }
        if ([model.tag objectForKey:@"style"]) {
            NSDictionary * styleDict = model.tag[@"style"];
            if ([styleDict objectForKey:@"color"] && [self isValidHexColor:styleDict[@"color"]]) {
                self.tagView.textColor = [UIColor colorWithHexString:[NSString stringWithFormat:@"%@", styleDict[@"color"]]];
                self.tagView.layer.borderColor = [UIColor colorWithHexString:[NSString stringWithFormat:@"%@", styleDict[@"color"]]].CGColor;
            }
            else {
                self.tagView.textColor = [UIColor colorWithHexString:@"#4385ff"];
                self.tagView.layer.borderColor = [UIColor colorWithHexString:@"#4385ff"].CGColor;
            }
            
        }
        else {
            self.tagView.textColor = [UIColor colorWithHexString:@"#4385ff"];
            self.tagView.layer.borderColor = [UIColor colorWithHexString:@"#4385ff"].CGColor;
        }
    }
    self.statusView.text = model.status?:@"";
    self.orderIdView.text = model.number?:@"";
//    NSLog(@"店铺的icon图片地址：%@", model.logo);
//    if ([model.logo isNotBlank]) {
//        self.iconView.hidden = NO;
//        [self.nameView mas_TIMupdateTIMConstraints:^(TIMMASConstraintMaker *make) {
//            make.left.equalTo(self.iconView.mas_TIMright).offset(8.0f);
//        }];
//        [self.iconView setImageWithURL:[NSURL URLWithString:model.logo] options:(YYWebImageOptionProgressive)];
//        
//    } else {
//        self.iconView.hidden = YES;
//        [self.nameView mas_TIMupdateTIMConstraints:^(TIMMASConstraintMaker *make) {
//            make.left.equalTo(self.iconView.mas_TIMleft);
//        }];
//    }
    
    /// 店铺名称最小宽度(有值的前提下)
    CGFloat nameMinWidth = 70.0f;
    /// 订单标签最小宽度(有值的前提下)
    CGFloat tagMinWidth = 40.0f;
    /// 剩余的宽度
    CGFloat remainingWidth = self.bubbleWidth - 24.0f;
//    NSLog(@"气泡最开始的剩余宽度：%lf", remainingWidth);
    if ([model.logo isNotBlank]) {
        remainingWidth -= (20.0f+8.0f);
        self.iconView.hidden = NO;
        [self.nameView mas_TIMupdateTIMConstraints:^(TIMMASConstraintMaker *make) {
            make.left.equalTo(self.iconView.mas_TIMright).offset(8.0f);
        }];
        [self.iconView setImageWithURL:[NSURL URLWithString:model.logo] options:(YYWebImageOptionProgressive)];
        
    } else {
        self.iconView.hidden = YES;
        [self.nameView mas_TIMupdateTIMConstraints:^(TIMMASConstraintMaker *make) {
            make.left.equalTo(self.iconView.mas_TIMleft);
        }];
    }
    
    if ([model.status isNotBlank]) {
        self.statusView.hidden = NO;
    }
    else {
        self.statusView.hidden = YES;
    }
    
    if ([self.nameView.text isNotBlank]) {
        remainingWidth -= 8.0f;
        self.nameView.hidden = NO;
        [self.tagView mas_TIMupdateTIMConstraints:^(TIMMASConstraintMaker *make) {
            make.left.equalTo(self.nameView.mas_TIMright).offset(8.0f);
        }];
        
    }
    else {
        nameMinWidth = 0.0f;
        self.nameView.hidden = YES;
        if (model.logo.length) {
            [self.tagView mas_TIMupdateTIMConstraints:^(TIMMASConstraintMaker *make) {
                make.left.equalTo(self.iconView.mas_TIMright).offset(8.0f);
            }];
        }
        else {
            [self.tagView mas_TIMupdateTIMConstraints:^(TIMMASConstraintMaker *make) {
                make.left.equalTo(self.mas_TIMleft).offset(8.0f);
            }];
        }
    }
    
    if ([self.tagView.text isNotBlank]) {
        remainingWidth -= 8.0f;
        self.tagView.hidden = NO;
    }
    else {
        tagMinWidth = 0.0f;
        self.tagView.hidden = YES;
        
    }
    /// 订单状态显示进行宽度计算
    if (!self.statusView.hidden) {
//        NSLog(@"remainingWidth : %lf, nameMinWidth : %lf, tagMinWidth : %lf", remainingWidth, nameMinWidth, tagMinWidth);
        
        CGSize statusTextSize = [self.statusView.text boundingRectWithSize:CGSizeMake(remainingWidth-nameMinWidth-tagMinWidth, MAXFLOAT)
                                             options:(NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading)
                                            attributes:@{NSFontAttributeName: [UIFont fontWithName:@"PingFangSC-Medium" size:15.0]}
                                             context:nil].size;
        
        [self.statusView mas_TIMupdateTIMConstraints:^(TIMMASConstraintMaker *make) {
            make.width.mas_TIMequalTo(ceil(statusTextSize.width));
        }];
        
        remainingWidth -= ceil(statusTextSize.width);
    }
    /// 标签显示进行宽度的计算
    if (!self.tagView.hidden) {
        
        if ([model.title isNotBlank]) {
//            NSLog(@"店铺名称不为空，需要预留出店铺名称的最低宽度");
            remainingWidth -= nameMinWidth;
        }
        CGSize tagTextSize = [self.tagView.text boundingRectWithSize:CGSizeMake(remainingWidth, MAXFLOAT)
                                             options:(NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading)
                                            attributes:@{NSFontAttributeName: [UIFont fontWithName:@"PingFangSC-Regular" size:12.0]}
                                             context:nil].size;
        
//        NSLog(@"tagTextSize.width : %lf，remainingWidth=== %lf, tagMinWidth === %lf", ceil(tagTextSize.width), remainingWidth, tagMinWidth);
        if (ceil(tagTextSize.width) > remainingWidth) {
            [self.tagView mas_TIMupdateTIMConstraints:^(TIMMASConstraintMaker *make) {
                make.width.mas_TIMequalTo(remainingWidth);
            }];
        }
        else if (ceil(tagTextSize.width) <= tagMinWidth) {
            [self.tagView mas_TIMupdateTIMConstraints:^(TIMMASConstraintMaker *make) {
                make.width.mas_TIMequalTo(tagMinWidth);
            }];
        }
        else {
            [self.tagView mas_TIMupdateTIMConstraints:^(TIMMASConstraintMaker *make) {
                make.width.mas_TIMequalTo(ceil(tagTextSize.width));
            }];
        }
        
        remainingWidth -= ceil(tagTextSize.width);
        
        if ([model.title isNotBlank]) {
            remainingWidth += nameMinWidth;
        }
    }
    /// 店铺名称显示进行宽度计算
    if (!self.nameView.hidden) {
        CGSize nameTextSize = [self.nameView.text boundingRectWithSize:CGSizeMake(remainingWidth, MAXFLOAT)
                                             options:(NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading)
                                            attributes:@{NSFontAttributeName: [UIFont fontWithName:@"PingFangSC-Medium" size:15.0]}
                                             context:nil].size;
        /// 店铺名称超过剩余的宽度，就设置店铺名称的宽度
        if (ceil(nameTextSize.width) > remainingWidth) {
            [self.nameView mas_TIMupdateTIMConstraints:^(TIMMASConstraintMaker *make) {
                make.width.mas_TIMequalTo(remainingWidth);
            }];
        }
        else if (ceil(nameTextSize.width) <= nameMinWidth) {
            [self.nameView mas_TIMupdateTIMConstraints:^(TIMMASConstraintMaker *make) {
                make.width.mas_TIMequalTo(nameMinWidth);
            }];
        }
        else {
            [self.nameView mas_TIMupdateTIMConstraints:^(TIMMASConstraintMaker *make) {
                make.width.mas_TIMequalTo(ceil(nameTextSize.width));
            }];
        }
        
    }
    
    /// 开始计算订单号和日期
    remainingWidth = self.bubbleWidth - 24.0f;
    if ([model.number isNotBlank]) {
        CGSize orderIdTextSize = [self.orderIdView.text boundingRectWithSize:CGSizeMake(remainingWidth, MAXFLOAT)
                                             options:(NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading)
                                            attributes:@{NSFontAttributeName: [UIFont fontWithName:@"PingFangSC-Regular" size:13.0]}
                                             context:nil].size;
        [self.orderIdView mas_TIMupdateTIMConstraints:^(TIMMASConstraintMaker *make) {
            make.width.mas_TIMequalTo(ceil(orderIdTextSize.width));
        }];
        
        remainingWidth -= ceil(orderIdTextSize.width);
    }
    if ([model.time isNotBlank]) {
        CGSize timeTextSize = [self.timeView.text boundingRectWithSize:CGSizeMake(remainingWidth, MAXFLOAT)
                                             options:(NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading)
                                            attributes:@{NSFontAttributeName: [UIFont fontWithName:@"PingFangSC-Regular" size:13.0]}
                                             context:nil].size;
        [self.timeView mas_TIMupdateTIMConstraints:^(TIMMASConstraintMaker *make) {
            make.width.mas_TIMequalTo(ceil(timeTextSize.width));
        }];
    }

    
}



#pragma mark - lazy

- (UIImageView *)iconView {
    if (!_iconView) {
        _iconView = [[UIImageView alloc] initWithFrame:(CGRectZero)];
        _iconView.layer.cornerRadius = 10.0f;
        _iconView.layer.masksToBounds = YES;
        
    }
    return _iconView;
}

- (UILabel *)nameView {
    if (!_nameView) {
        _nameView = [[UILabel alloc] initWithFrame:(CGRectZero)];
        _nameView.font = [UIFont fontWithName:@"PingFangSC-Medium" size:14.0f];
        _nameView.textColor = [UIColor colorWithHexString:@"#262626"];
//        _nameView.text = @"北京王府井店";
        
    }
    return _nameView;
}

- (UILabel *)tagView {
    if (!_tagView) {
        _tagView = [[UILabel alloc] initWithFrame:(CGRectZero)];
        _tagView.font = [UIFont fontWithName:@"PingFangSC-Regular" size:11.0f];
        _tagView.textColor = [UIColor colorWithHexString:@"#4385ff"];
        _tagView.layer.borderColor = [UIColor colorWithHexString:@"#4385ff"].CGColor;
        _tagView.layer.borderWidth = 1.0f;
        _tagView.layer.cornerRadius = 3.0f;
        _tagView.layer.masksToBounds = YES;
        _tagView.textAlignment = NSTextAlignmentCenter;
        
    }
    return _tagView;
}

- (UILabel *)statusView {
    if (!_statusView) {
        _statusView = [[UILabel alloc] initWithFrame:(CGRectZero)];
        _statusView.font = [UIFont boldSystemFontOfSize:14.0f];
        _statusView.textColor = [UIColor colorWithHexString:@"#EA5C66"];
        _statusView.textAlignment = NSTextAlignmentRight;
//        _statusView.text = @"待发货";
        
    }
    return _statusView;
}

- (UILabel *)timeView {
    if (!_timeView) {
        _timeView = [[UILabel alloc] initWithFrame:(CGRectZero)];
        _timeView.font = [UIFont fontWithName:@"PingFangSC-Regular" size:12.0f];
        _timeView.textColor = [UIColor colorWithHexString:@"#8C8C8C"];
//        _timeView.text = @"2023-09-09 18:25 ";
        
    }
    return _timeView;
}

- (UILabel *)orderIdView {
    if (!_orderIdView) {
        _orderIdView = [[UILabel alloc] initWithFrame:(CGRectZero)];
        _orderIdView.font = [UIFont fontWithName:@"PingFangSC-Regular" size:12.0f];
        _orderIdView.textColor = [UIColor colorWithHexString:@"#8C8C8C"];
        _orderIdView.textAlignment = NSTextAlignmentRight;
//        _orderIdView.text = @"33744764674676";
        
    }
    return _orderIdView;
}

@end
