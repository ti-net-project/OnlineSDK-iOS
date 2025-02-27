//
//  TOSMenuPopAlert.h
//  TOSClientKit
//
//  Created by 李成 on 2024/11/7.
//  Copyright © 2024 YanBo. All rights reserved.
//  菜单弹窗

#import <TOSClientKit/TOSClientKit.h>

/// 弹出气泡的尖角方向枚举
typedef NS_ENUM(NSUInteger, TOSMenuBubbleArrowDirection) {
    /// 向下
    TOSMenuBubbleArrowDirectionUp,
    /// 向上
    TOSMenuBubbleArrowDirectionDown,
    /// 向左
    TOSMenuBubbleArrowDirectionLeft,
    /// 向右
    TOSMenuBubbleArrowDirectionRight
};

NS_ASSUME_NONNULL_BEGIN

/// 配置model
@interface TOSMenuConfiguration : NSObject

/// 最大一屏展示多少行
@property (nonatomic, assign) NSInteger                showMaxRow;

/// 每行的高度
@property (nonatomic, assign) CGFloat                rowHeight;

/// 弹窗的背景颜色
@property (nonatomic, strong) UIColor                * backGroudColor;

/// 弹窗列表的背景颜色
@property (nonatomic, strong) UIColor                * tableViewBackGroudColor;

/// 列表的边框颜色
@property (nonatomic, strong) UIColor                * tableViewBorderColor;

/// 列表的边框宽度
@property (nonatomic, assign) CGFloat                tableViewBorderWidth;

/// item最低宽度
@property (nonatomic, assign) CGFloat                tableViewItemMinWidth;

/// 列表的圆角
@property (nonatomic, assign) CGFloat                tableViewCornerRadius;

@end


/// 数据model
@interface TOSCustomMenuItem : NSObject

@property (nonatomic, copy) NSString                * title;

@property (nonatomic, strong) NSString                * ident;

@end


@protocol TOSMenuPopAlertDelegate <NSObject>

/// 弹窗的点击事件
/// - Parameters:
///   - index: 点击的是第几个
///   - sourceIndex: 那个cell选择弹出的
- (void)TOSMenuPopAlertDidSelect:(NSInteger)index withSourceIndex:(NSInteger)sourceIndex withStartIndex:(NSInteger)startIndex;

@end


/// 自定义弹窗
@interface TOSMenuPopAlert : TOSBaseView

@property (nonatomic, weak) id <TOSMenuPopAlertDelegate>                delegate;

/// 初始化实例
/// - Parameters:
///   - rect: 锚点位置
///   - array: 数据源
///   - config: 弹窗的配置项
///   - index: 数据源的下标
///   - startIndex: 数据源的下标起始位置
- (instancetype)initWithRect:(CGRect)rect withData:(NSArray<TOSCustomMenuItem*> *)array withConfig:(TOSMenuConfiguration *)config withIndex:(NSInteger)index withRangeStartIndex:(NSInteger)startIndex;

/// 添加到视图上
- (void)showView:(UIView *)superView;

/// 添加到window上面
- (void)showWindow;


@end

/// 气泡尖角
@interface TOSMenuCustomBubbleView : UIView

/// 尖角方向
@property (nonatomic, assign) TOSMenuBubbleArrowDirection                arrowDirection;

/// 气泡颜色
@property (nonatomic, strong) UIColor                * bubbleBackGroundColor;

@end

NS_ASSUME_NONNULL_END
