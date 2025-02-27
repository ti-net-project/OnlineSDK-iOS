//
//  TOSOrderListTopView.m
//  TOSClientKit
//
//  Created by 李成 on 2024/10/31.
//  Copyright © 2024 YanBo. All rights reserved.
//  订单商品店铺信息区域

#import "TOSOrderListTopView.h"
#import "TIMMasonry.h"
#import "TIMConstants.h"
#import "YYKit.h"

static const CGFloat kHorizontalMargin = 12.0f;
static const CGFloat kElementSpacing = 8.0f;
static const CGFloat kNameMinWidth = 70.0f;
static const CGFloat kTagMinWidth = 40.0f;

@interface TOSOrderListTopView ()

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



@implementation TOSOrderListTopView

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
            make.left.mas_TIMequalTo(kHorizontalMargin);
            make.top.mas_TIMequalTo(13.0f);
            make.width.height.mas_TIMequalTo(20.0f);
        }];
        
        [self.statusView mas_TIMmakeTIMConstraints:^(TIMMASConstraintMaker *make) {
            make.right.mas_TIMequalTo(-kHorizontalMargin);
            make.top.mas_TIMequalTo(12.0f);
            make.height.mas_TIMequalTo(22.0f);
            make.width.mas_TIMequalTo(0.0f);
        }];
        
        [self.nameView mas_TIMmakeTIMConstraints:^(TIMMASConstraintMaker *make) {
            make.left.equalTo(self.iconView.mas_TIMright).offset(kElementSpacing);
            make.height.mas_TIMequalTo(22.0f);
            make.top.equalTo(self.statusView.mas_TIMtop);
            make.width.mas_TIMequalTo(0.0f);
        }];
        
        [self.tagView mas_TIMmakeTIMConstraints:^(TIMMASConstraintMaker *make) {
            make.left.equalTo(self.nameView.mas_TIMright).offset(kElementSpacing);
            make.height.mas_TIMequalTo(16.0f);
            make.centerY.equalTo(self.nameView.mas_TIMcenterY);
            make.width.mas_TIMequalTo(0.0f);
        }];
        
        [self.timeView mas_TIMmakeTIMConstraints:^(TIMMASConstraintMaker *make) {
            make.left.equalTo(self.iconView.mas_TIMleft);
            make.top.equalTo(self.iconView.mas_TIMbottom).offset(9.0f);
            make.height.mas_TIMequalTo(18.0f);
            make.width.mas_TIMequalTo(0.0f);
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

- (CGFloat)calculateTextWidth:(NSString *)text font:(UIFont *)font maxWidth:(CGFloat)maxWidth {
    if (![text isNotBlank]) return 0;
    
    CGSize textSize = [text boundingRectWithSize:CGSizeMake(maxWidth, MAXFLOAT)
                                       options:(NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading)
                                    attributes:@{NSFontAttributeName: font}
                                       context:nil].size;
    return ceil(textSize.width);
}

#pragma mark - setter/getter

- (void)setModel:(TOSOrderListModel *)model {
    _model = model;
    
    // 基础文本设置
    self.nameView.text = model.title ?: @"";
    self.timeView.text = model.time ?: @"";
    self.statusView.text = model.status ?: @"";
    self.orderIdView.text = model.number ?: @"";
    NSLog(@"时间数据：%@, self.timeView.text:%@", model.time, self.timeView.text);
    // 处理logo显示
    if ([model.logo isNotBlank]) {
        self.iconView.hidden = NO;
        [self.iconView setImageWithURL:[NSURL URLWithString:model.logo] options:(YYWebImageOptionProgressive)];
        [self.nameView mas_TIMupdateTIMConstraints:^(TIMMASConstraintMaker *make) {
            make.left.equalTo(self.iconView.mas_TIMright).offset(kElementSpacing);
        }];
    } else {
        self.iconView.hidden = YES;
        [self.nameView mas_TIMupdateTIMConstraints:^(TIMMASConstraintMaker *make) {
            make.left.equalTo(self.iconView.mas_TIMleft);
        }];
    }
    CGFloat nameMinWidth = kNameMinWidth;
    CGFloat tagMinWidth = kTagMinWidth;
    
    // 设置tagView的文本和样式
    if ([model.tag allKeys].count) {
        self.tagView.hidden = NO;
        self.tagView.text = model.tag[@"text"] ?: @"";
        
        // 设置标签样式
        if ([model.tag objectForKey:@"style"]) {
            NSDictionary *styleDict = model.tag[@"style"];
            NSString *colorString = styleDict[@"color"];
            if ([styleDict objectForKey:@"color"] && [self isValidHexColor:colorString]) {
                UIColor *tagColor = [UIColor colorWithHexString:colorString];
                self.tagView.textColor = tagColor;
                self.tagView.layer.borderColor = tagColor.CGColor;
            } else {
                [self resetTagViewDefaultStyle];
            }
        } else {
            [self resetTagViewDefaultStyle];
        }
    } else {
        tagMinWidth = 0.0f;
        self.tagView.hidden = YES;
        self.tagView.text = @"";
        [self resetTagViewDefaultStyle];
    }
    
    /// 计算布局
    CGFloat totalWidth = App_Frame_Width - 2 * kHorizontalMargin - 32.0f;
    
    CGFloat usedWidth = 0;
    
    /// 1. 先计算固定宽度的元素
    if ([model.logo isNotBlank]) {
        usedWidth += (20.0f + kElementSpacing);
    }
    if (![self.tagView.text isNotBlank]) {
        tagMinWidth = 0.0f;
    }
    else {
        totalWidth -= kHorizontalMargin;
    }
    if (![self.nameView.text isNotBlank]) {
        nameMinWidth = 0.0f;
    }
    else {
        totalWidth -= kElementSpacing;
    }
    
    
    /// 2. 计算status宽度（最高优先级）
    UIFont *statusFont = [UIFont fontWithName:@"PingFangSC-Medium" size:14.0];
    CGFloat statusWidth = [self calculateTextWidth:self.statusView.text
                                           font:statusFont 
                                       maxWidth:totalWidth - usedWidth - nameMinWidth - tagMinWidth];
    if (statusWidth > 0) {
        self.statusView.hidden = NO;
        [self.statusView mas_TIMupdateTIMConstraints:^(TIMMASConstraintMaker *make) {
            make.width.mas_TIMequalTo(statusWidth);
        }];
        usedWidth += statusWidth;
    } else {
        self.statusView.hidden = YES;
    }
    
    /// 3. 剩余空间在name和tag之间分配
    CGFloat remainingWidth = totalWidth - usedWidth;
    
    if (!self.tagView.hidden) {
        UIFont *tagFont = [UIFont fontWithName:@"PingFangSC-Regular" size:12.0];
        CGFloat tagWidth = [self calculateTextWidth:self.tagView.text 
                                            font:tagFont 
                                        maxWidth:remainingWidth];
        tagWidth = MAX(kTagMinWidth, MIN(tagWidth, remainingWidth - nameMinWidth));
        
        [self.tagView mas_TIMupdateTIMConstraints:^(TIMMASConstraintMaker *make) {
            make.width.mas_TIMequalTo(tagWidth);
        }];
//        remainingWidth -= (tagWidth + kHorizontalMargin);
        remainingWidth -= tagWidth;
    }
    
    
    // 剩余全部给nameView
    if ([self.nameView.text isNotBlank]) {
        self.nameView.hidden = NO;
        UIFont *nameFont = [UIFont fontWithName:@"PingFangSC-Medium" size:14.0];
        CGFloat nameWidth = [self calculateTextWidth:self.nameView.text
                                               font:nameFont
                                           maxWidth:remainingWidth];
        [self.nameView mas_TIMupdateTIMConstraints:^(TIMMASConstraintMaker *make) {
            make.width.mas_TIMequalTo(MAX(kNameMinWidth, MIN(remainingWidth, nameWidth)));
        }];
    } else {
        self.nameView.hidden = YES;
    }
    
    remainingWidth = App_Frame_Width - 2 * kHorizontalMargin - 32.0f;
    
    if ([self.timeView.text isNotBlank]) {
        UIFont *timeFont = [UIFont fontWithName:@"PingFangSC-Regular" size:12.0];
        CGFloat timeWidth = [self calculateTextWidth:self.timeView.text
                                               font:timeFont
                                            maxWidth:remainingWidth - kNameMinWidth];
        [self.timeView mas_TIMupdateTIMConstraints:^(TIMMASConstraintMaker *make) {
            make.width.mas_TIMequalTo(timeWidth);
        }];
    }
    
}

/// 添加一个辅助方法来重置tagView的默认样式
- (void)resetTagViewDefaultStyle {
    UIColor *defaultColor = [UIColor colorWithHexString:@"#4385ff"];
    self.tagView.textColor = defaultColor;
    self.tagView.layer.borderColor = defaultColor.CGColor;
}

#pragma mark - lazy

- (UIImageView *)iconView {
    if (!_iconView) {
        _iconView = [[UIImageView alloc] initWithFrame:(CGRectZero)];
        _iconView.layer.cornerRadius = TOSKitCustomInfo.shareCustomInfo.orderDrawer.logoCorner;
        _iconView.layer.masksToBounds = YES;
        
    }
    return _iconView;
}

- (UILabel *)nameView {
    if (!_nameView) {
        _nameView = [[UILabel alloc] initWithFrame:(CGRectZero)];
        _nameView.font = [UIFont fontWithName:@"PingFangSC-Medium" size:14.0f];
        _nameView.textColor = [UIColor colorWithHexString:@"#262626"];
        
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
        _statusView.font = [UIFont fontWithName:@"PingFangSC-Medium" size:14.0f];
        _statusView.textColor = [UIColor colorWithHexString:@"#EA5C66"];
        _statusView.textAlignment = NSTextAlignmentRight;
        
    }
    return _statusView;
}

- (UILabel *)timeView {
    if (!_timeView) {
        _timeView = [[UILabel alloc] initWithFrame:(CGRectZero)];
        _timeView.font = [UIFont fontWithName:@"PingFangSC-Regular" size:12.0f];
        _timeView.textColor = [UIColor colorWithHexString:@"#8C8C8C"];
        
    }
    return _timeView;
}

- (UILabel *)orderIdView {
    if (!_orderIdView) {
        _orderIdView = [[UILabel alloc] initWithFrame:(CGRectZero)];
        _orderIdView.font = [UIFont fontWithName:@"PingFangSC-Regular" size:12.0f];
        _orderIdView.textColor = [UIColor colorWithHexString:@"#8C8C8C"];
        _orderIdView.textAlignment = NSTextAlignmentRight;
        
    }
    return _orderIdView;
}

#pragma mark - 复用机制

- (void)prepareForReuse {
    self.iconView.image = nil;
    self.nameView.text = nil;
    self.tagView.text = nil;
    self.statusView.text = nil;
    self.timeView.text = nil;
    self.orderIdView.text = nil;
}

#pragma mark - 字体缓存

+ (UIFont *)cachedFontWithName:(NSString *)name size:(CGFloat)size {
    static NSMutableDictionary *fontCache;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        fontCache = [NSMutableDictionary dictionary];
    });
    
    NSString *key = [NSString stringWithFormat:@"%@-%.1f", name, size];
    UIFont *font = fontCache[key];
    if (!font) {
        font = [UIFont fontWithName:name size:size];
        fontCache[key] = font;
    }
    return font;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
