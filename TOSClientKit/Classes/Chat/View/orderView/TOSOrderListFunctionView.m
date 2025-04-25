//
//  TOSOrderListFunctionView.m
//  TOSClientKit
//
//  Created by 李成 on 2024/10/31.
//  Copyright © 2024 YanBo. All rights reserved.
//  功能按钮区域

#import "TOSOrderListFunctionView.h"
#import "TIMMasonry.h"
#import "TIMConstants.h"
#import "TIMYYKit.h"
#import "SLButton.h"

@interface TOSOrderListFunctionView ()

/// 更多按钮
@property (nonatomic, strong) UIButton                * moreView;

/// 底部的功能按钮
@property (nonatomic, strong) SLButton                * bottomBtnView;

@end


@implementation TOSOrderListFunctionView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
        
        
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

#pragma mark - action

/// 更多按钮的点击事件
- (void)moreTouch {
    
    if ([self.delegate respondsToSelector:@selector(TOSOrderListFunctionViewClink:)]) {
        [self.delegate TOSOrderListFunctionViewClink:-1];
    }
    
}

/// 非更多按钮的点击事件
- (void)itemTouch:(UIButton *)sender {
    
//    TOSOrderButtonConfigModel * model = self.itemsArray[sender.tag];
    
    if ([self.delegate respondsToSelector:@selector(TOSOrderListFunctionViewClink:)]) {
        [self.delegate TOSOrderListFunctionViewClink:sender.tag];
    }
}

/// 底部右下角的点击事件
- (void)bottomTouch {
    
    if ([self.delegate respondsToSelector:@selector(TOSOrderListFunctionViewClink:)]) {
        [self.delegate TOSOrderListFunctionViewClink:-2];
    }
    
}

#pragma mark - setter/getter
- (void)setItemsArray:(NSArray<TOSOrderButtonConfigModel *> *)itemsArray {
    _itemsArray = itemsArray;
    
    
    NSInteger count = itemsArray.count;
    CGFloat totalWidth = App_Frame_Width-32.0f;
    
    for (UIView * item in self.subviews) {
        [item removeFromSuperview];
    }
    
    [self addSubview:self.moreView];
    if (itemsArray.count >= 4) {
        count = 3;
        self.moreView.hidden = NO;
    }
    else {
        self.moreView.hidden = YES;
    }
    self.moreIndex = count;
    NSMutableArray<NSNumber *> * widthArray = [NSMutableArray array];
    CGFloat countWidth = 0.0f;
    for (NSInteger i = 0; i < count; i++) {
        TOSOrderButtonConfigModel * buttonConfig = itemsArray[i];
        NSString * string = buttonConfig.text;
        CGSize textSize = [string boundingRectWithSize:CGSizeMake(124.0, MAXFLOAT)
                                             options:(NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading)
                                            attributes:@{NSFontAttributeName: [UIFont fontWithName:@"PingFangSC-Regular" size:13.0]}
                                             context:nil].size;
//        NSLog(@"string的值：%@     textSize: %@", string, NSStringFromCGSize(textSize));
        if (ceil(textSize.width) >= 96.0f) {
            textSize = CGSizeMake(124.0f, textSize.height);
        }
        else {
            textSize = CGSizeMake(textSize.width+28.0f, textSize.height);
        }
        
        countWidth += ceil(textSize.width)+8.0f;
        if (countWidth < totalWidth - 60.0f - 12.0f) {
//            NSLog(@"每个item的宽度：%lf", countWidth);
            [widthArray addObject:[NSNumber numberWithFloat:ceil(textSize.width)]];
        }
        
        
    }
    CGFloat space = 8.0f;
    CGFloat x = totalWidth-12.0;
    for (NSInteger i = 0; i < count; i++) {
        NSNumber * width = widthArray[i];
        TOSOrderButtonConfigModel * buttonConfig = itemsArray[i];
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
//        [btn setTitleColor:[UIColor colorWithHexString:@"#595959"] forState:(UIControlStateNormal)];
//        btn.backgroundColor = [UIColor colorWithHexString:@"#F9F9F9"];
        
        btn.titleLabel.lineBreakMode = NSLineBreakByTruncatingTail;
        btn.titleLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:12.0f];
        btn.titleEdgeInsets = UIEdgeInsetsMake(0.0, 14.0, 0.0, 14.0);
        btn.tag = i;
        btn.layer.cornerRadius = 13.0f;
        btn.layer.masksToBounds = YES;
        [btn addTarget:self action:@selector(itemTouch:) forControlEvents:(UIControlEventTouchUpInside)];
        
        [self addSubview:btn];
        
        [btn mas_TIMmakeTIMConstraints:^(TIMMASConstraintMaker *make) {
            make.left.mas_TIMequalTo(x-width.floatValue);
            make.top.mas_TIMequalTo(8.0f);
            make.width.mas_TIMequalTo(width.floatValue);
            make.height.mas_TIMequalTo(26.0f);
        }];
        
        x -= (width.floatValue+space);
        
    }
}

- (void)setBottomModel:(TOSOrderBottomButtonConfigModel *)bottomModel {
    _bottomModel = bottomModel;
    
    [self addSubview:self.bottomBtnView];
    
    self.bottomBtnView.hidden = NO;
    self.bottomBtnView.titleLabel.text = bottomModel.text;
    
    /// 样式不为null
    if (bottomModel.style != nil) {
        if ([[bottomModel.style allKeys] containsObject:@"color"] && [self isValidHexColor:bottomModel.style[@"color"]]) {
            self.bottomBtnView.titleLabel.textColor = [UIColor colorWithHexString:[NSString stringWithFormat:@"%@", bottomModel.style[@"color"]]];
            
        } else {
            self.bottomBtnView.titleLabel.textColor = [UIColor colorWithHexString:@"#8C8C8C"];
        }
    }
    else {
        self.bottomBtnView.titleLabel.textColor = [UIColor colorWithHexString:@"#8C8C8C"];
    }
    CGSize textSize = [bottomModel.text boundingRectWithSize:CGSizeMake(App_Frame_Width, MAXFLOAT)
                                         options:(NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading)
                                        attributes:@{NSFontAttributeName: [UIFont fontWithName:@"PingFangSC-Regular" size:13.0]}
                                         context:nil].size;
//    NSLog(@"string的值：%@     textSize: %@", bottomModel.text, NSStringFromCGSize(textSize));
    [self.bottomBtnView mas_TIMmakeTIMConstraints:^(TIMMASConstraintMaker *make) {
        make.bottom.mas_TIMequalTo(-12.0f);
        make.right.mas_TIMequalTo(-12.0f);
        make.width.mas_TIMequalTo(ceil(textSize.width) + 32.0f);
        make.height.mas_TIMequalTo(18.0f);
    }];
    [self.bottomBtnView setTitleImageLayoutStyle:(SLButtonStyleImageRight) space:4.0f];
}

#pragma mark - lazy

- (UIButton *)moreView {
    if (!_moreView) {
        _moreView = [[UIButton alloc] initWithFrame:(CGRectMake(4.0, 8.0, 40.0, 26.0))];
        [_moreView setTitle:@"更多" forState:(UIControlStateNormal)];
        [_moreView setTitleColor:[UIColor colorWithHexString:@"#8C8C8C"] forState:(UIControlStateNormal)];
        _moreView.titleLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:12.0f];
        [_moreView addTarget:self action:@selector(moreTouch) forControlEvents:(UIControlEventTouchUpInside)];
        _moreView.hidden = YES;
        
    }
    return _moreView;
}

- (SLButton *)bottomBtnView {
    if (!_bottomBtnView) {
        _bottomBtnView = [[SLButton alloc] initWithFrame:(CGRectZero)];
//        [_bottomBtnView setTitleColor:[UIColor colorWithHexString:@"#8C8C8C"] forState:(UIControlStateNormal)];
        _bottomBtnView.titleLabel.textColor = [UIColor colorWithHexString:@"#8C8C8C"];
        _bottomBtnView.titleLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:12.0f];
//        [_bottomBtnView setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@/%@", FRAMEWORKS_BUNDLE_PATH, @"orderDrawer_rightArrow"]] forState:(UIControlStateNormal)];
        _bottomBtnView.imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@/%@", FRAMEWORKS_BUNDLE_PATH, @"orderDrawer_rightArrow"]];
        [_bottomBtnView addTarget:self action:@selector(bottomTouch) forControlEvents:(UIControlEventTouchUpInside)];
        _bottomBtnView.hidden = YES;
        
    }
    return _bottomBtnView;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
