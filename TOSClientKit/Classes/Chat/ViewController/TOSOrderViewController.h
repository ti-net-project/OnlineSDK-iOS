//
//  TOSOrderViewController.h
//  TOSClientKit
//
//  Created by 李成 on 2024/10/30.
//  Copyright © 2024 YanBo. All rights reserved.
//  订单抽屉

#import <TOSClientKit/TOSClientKit.h>
#import "TOSOrderListModel.h"

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, TOSOrderModelType) {
    /// 订单
    TOSOrderModelTypeOrder      =   0,
    /// 商品
    TOSOrderModelTypeProduct    =   1,
};

@protocol TOSOrderViewControllerDelegate <NSObject>


/// 发送订单卡片
/// - Parameters:
///   - cardModel: 订单model
///   - productModel: 商品model
///   - type: 枚举，是发送订单还是发送商品
- (void)TOSOrderViewControllerSendCard:(TOSOrderListModel *)cardModel
                      withProductModel:(nullable TOSOrderListProductModel *)productModel
                    withType:(TOSOrderModelType)type;

/// 发送文本
/// - Parameters:
///   - content: 文本内容
///   - cardModel: 对应的订单model
- (void)TOSOrderViewControllerSendContent:(NSString *)content withCard:(TOSOrderListModel *)cardModel;

/// 点击链接
/// - Parameters:
///   - link: 链接地址
///   - cardModel: 对应的订单model
- (void)TOSOrderViewControllerSendLink:(NSString *)link withCard:(TOSOrderListModel *)cardModel;



/// 被动唤起抽屉页面，用户没有进行其他操作，直接关闭当前页面
/// - Parameter failText: 需要发送的失败话术
- (void)TOSOrderViewControllerSendFailText:(NSString *)failText;


/// 商品卡片的整体点击
/// - Parameters:
///   - cardModel: 商品model
///   - orderModel: 商品对应的订单model
- (void)TOSOrderViewControllerTouchProductCard:(TOSOrderListProductModel *)cardModel
                              withOrderModel:(TOSOrderListModel *)orderModel;


@end


@interface TOSOrderViewController : TOSBaseViewController

@property (nonatomic, weak) id <TOSOrderViewControllerDelegate>                delegate;

/// 标题
@property (nonatomic, copy) NSString                * titleStr;

/// 抽屉的请求参数
@property (nonatomic, strong) NSDictionary                * param;

/// 是否展示搜索按钮
@property (nonatomic, assign) BOOL                showSearch;

/// 搜索框的暗文
@property (nonatomic, copy) NSString                * searchPlaceholder;

/// 是否是被动唤起的，非用户主动点击
@property (nonatomic, assign) BOOL                passiveEvoke;

@end

NS_ASSUME_NONNULL_END
