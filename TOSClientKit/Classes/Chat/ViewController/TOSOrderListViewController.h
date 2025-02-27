//
//  TOSOrderListViewController.h
//  TOSClientKit
//
//  Created by 李成 on 2025/1/6.
//  Copyright © 2025 YanBo. All rights reserved.
//

#import <TOSClientKit/TOSClientKit.h>
#import "TOSOrderListModel.h"
#import "TOSOrderViewController.h"

NS_ASSUME_NONNULL_BEGIN


@protocol TOSOrderListViewControllerDelegate <NSObject>

/// 发送订单卡片
/// - Parameters:
///   - cardModel: 订单model
///   - productModel: 商品model
///   - type: 枚举，是发送订单还是发送商品
- (void)TOSOrderListViewControllerSendCard:(TOSOrderListModel *)cardModel
                          withProductModel:(nullable TOSOrderListProductModel *)productModel
                                  withType:(TOSOrderModelType)type;
/// 发送文本
/// - Parameters:
///   - content: 文本内容
///   - cardModel: 对应的订单model
- (void)TOSOrderListViewControllerSendContent:(NSString *)content withCard:(TOSOrderListModel *)cardModel;

/// 点击链接
/// - Parameters:
///   - link: 链接地址
///   - cardModel: 对应的订单model
- (void)TOSOrderListViewControllerSendLink:(NSString *)link withCard:(TOSOrderListModel *)cardModel;



/// 被动唤起抽屉页面，用户没有进行其他操作，直接关闭当前页面
/// - Parameter failText: 需要发送的失败话术
- (void)TOSOrderListViewControllerSendFailText:(NSString *)failText;



/// 商品卡片的整体点击
/// - Parameters:
///   - cardModel: 商品model
///   - orderModel: 商品对应的订单model
- (void)TOSOrderListViewControllerTouchProductCard:(TOSOrderListProductModel *)cardModel
                              withOrderModel:(TOSOrderListModel *)orderModel;

@end



@interface TOSOrderListViewController : TOSBaseViewController

@property (nonatomic, weak) id <TOSOrderListViewControllerDelegate>                delegate;

/// 抽屉的请求参数
@property (nonatomic, strong) NSDictionary                * param;

/// 是否展示搜索按钮
@property (nonatomic, assign) BOOL                showSearch;

/// 搜索框的暗文
@property (nonatomic, copy) NSString                * searchPlaceholder;

/// 是否是被动唤起的，非用户主动点击
@property (nonatomic, assign) BOOL                passiveEvoke;

/// 分类的值
@property (nonatomic, copy) NSString                * categoryStr;


- (void)loadDataSourceSearch:(NSString *)search;

@end

NS_ASSUME_NONNULL_END
