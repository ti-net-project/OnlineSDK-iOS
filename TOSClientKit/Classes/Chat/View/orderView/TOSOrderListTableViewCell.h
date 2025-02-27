//
//  TOSOrderListTableViewCell.h
//  TOSClientKit
//
//  Created by 李成 on 2024/10/31.
//  Copyright © 2024 YanBo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TOSOrderListModel.h"

NS_ASSUME_NONNULL_BEGIN


@protocol TOSOrderListTableViewCellDelegate <NSObject>

/// 功能按钮的点击
/// - Parameters:
///   - index: 点击的是第几个功能按钮
///   - model: 对应的订单model
- (void)TOSOrderListTableViewCellFunctionClick:(NSInteger)index withModel:(TOSOrderListModel *)model;

/// 功能按钮的更多点击
/// - Parameters:
///   - index: 需要展示的功能按钮的索引
///   - model: 对应的订单model
- (void)TOSOrderListTableViewCellFunctionMoreClick:(NSInteger)index withModel:(TOSOrderListModel *)model withRect:(CGRect)rect;


/// 功能按钮的点击
/// - Parameters:
///   - index: 底部右下角的按钮点击，这个对于逻辑没有作用
///   - model: 对应的订单model
- (void)TOSOrderListTableViewCellBottomFunctionClick:(NSInteger)index withModel:(TOSOrderListModel *)model;

/// 商品的功能按钮的点击
/// - Parameters:
///   - index: 点击商品的哪个功能按钮
///   - model: 订单model
///   - productModel: 商品model
- (void)TOSOrderListTableViewCellProductFunctionClick:(NSInteger)index withModel:(TOSOrderListModel *)model withProductModel:(TOSOrderListProductModel *)productModel;

/// 自定义参数的更多按钮点击。（展开/收起）
/// - Parameter model: 对应的订单model
- (void)TOSOrderListTableViewCellCustomMoreClick:(TOSOrderListModel *)model withIndex:(NSInteger)index;


/// 订单中商品卡片的整体点击
/// - Parameters:
///   - productModel: 商品的model
///   - model: 商品所在的订单的model
- (void)TOSOrderListTableViewCellProductModel:(TOSOrderListProductModel *)productModel withModel:(TOSOrderListModel *)model;


@end


@interface TOSOrderListTableViewCell : UITableViewCell

/// 代理
@property (nonatomic, weak) id <TOSOrderListTableViewCellDelegate>                delegate;

/// 数据model
@property (nonatomic, strong) TOSOrderListModel                * model;

@end

NS_ASSUME_NONNULL_END
