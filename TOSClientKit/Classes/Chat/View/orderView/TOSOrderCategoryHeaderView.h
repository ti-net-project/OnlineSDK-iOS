//
//  TOSOrderCategoryHeaderView.h
//  TOSClientKit
//
//  Created by 李成 on 2025/1/6.
//  Copyright © 2025 YanBo. All rights reserved.
//

#import <TOSClientKit/TOSClientKit.h>

NS_ASSUME_NONNULL_BEGIN


@protocol TOSOrderCategoryHeaderViewDelegate <NSObject>

- (void)TOSOrderCategoryHeaderViewSelected:(NSInteger)index;

@end

@interface TOSOrderCategoryHeaderView : TOSBaseView

@property (nonatomic, weak) id <TOSOrderCategoryHeaderViewDelegate>                delegate;

/**
 根据角标，选中对应的控制器
 */
@property (nonatomic, assign) NSInteger selectIndex;

/// 子元素数组
@property (nonatomic, strong) NSArray                * itemsArray;

/// 选中文字颜色
@property (nonatomic, strong) UIColor                  * selectTextColor;

/// 默认字体颜色
@property (nonatomic, strong) UIColor                  * defaultTextColor;

/// 选中字体大小
@property (nonatomic, assign) CGFloat                       selectFontSize;

/// 默认字体大小
@property (nonatomic, assign) CGFloat                       defaultFontSize;

@property (nonatomic, assign) BOOL isShowUnderLine;

@property (nonatomic, assign) CGFloat labelTopMargin;

@property (nonatomic, assign) CGFloat underLineYOffset;


- (instancetype)initWithFrame:(CGRect)frame items:(NSArray *)items;

@end

NS_ASSUME_NONNULL_END
