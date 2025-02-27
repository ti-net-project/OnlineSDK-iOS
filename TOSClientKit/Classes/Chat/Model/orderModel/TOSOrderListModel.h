//
//  TOSOrderListModel.h
//  TOSClientKit
//
//  Created by 李成 on 2024/11/4.
//  Copyright © 2024 YanBo. All rights reserved.
//  订单详情model

#import <TOSClientLib/TOSClientLib.h>
#import <TOSClientLib/TIMLibBaseModel.h>
#import "TOSOrderListProductModel.h"
#import "TOSOrderButtonConfigModel.h"

NS_ASSUME_NONNULL_BEGIN


/// 订单model
@interface TOSOrderListModel : TIMLibBaseModel

/// 店铺名称（示例: XX专营店）
@property (nonatomic, copy) NSString                * title;

/// 店铺头像
@property (nonatomic, copy) NSString                * logo;

/// 订单时间，具体时间（示例: xx年xx月xx日 00:00:00）
@property (nonatomic, copy) NSString                * time;

/// 订单编号（示例: 1234**2457000）
@property (nonatomic, copy) NSString                * number;

/// 订单标签
@property (nonatomic, strong) NSDictionary                * tag;

/// 订单状态（示例: 待收货）
@property (nonatomic, copy) NSString                * status;

/// 底部订单按钮
@property (nonatomic, strong) NSArray<TOSOrderButtonConfigModel *>                * buttonConfigList;

/// 订单底部按钮配置
@property (nonatomic, strong) TOSOrderBottomButtonConfigModel                * bottomButtonConfig;

/// 商品列表数组
@property (nonatomic, strong) NSArray<TOSOrderListProductModel *>                * productList;

/// 您的自定字段，一般来说是个数组或null，会携带给机器人，不展示在页面上，我们不做处理
@property (nonatomic, strong) NSArray                * extraData;

/// 自定义参数，只在订单列表显示，且显示在该订单底部，发送出去的消息不显示
@property (nonatomic, strong) NSArray                * extraInfoArr;

/// 是否展开（本地使用，是否显示更多的自定义参数）
@property (nonatomic, assign) BOOL                showMore;

/// 功能按钮的高度（本地使用，本地根据 bottomButtonConfig 和 buttonConfigList 的值计算得来）
@property (nonatomic, assign) CGFloat                functionHeight;

/// 自定义数据的高度 (本地使用，根据 showMore 的变化，走不同的数据逻辑，是否展开都需要根据 extraInfoArr 字段的内容进行计算)
@property (nonatomic, assign) CGFloat                bottomCustomHeight;



@end

NS_ASSUME_NONNULL_END
