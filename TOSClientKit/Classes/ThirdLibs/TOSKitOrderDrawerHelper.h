//
//  TOSKitOrderDrawerHelper.h
//  TOSClientKit
//
//  Created by 李成 on 2024/11/6.
//  Copyright © 2024 YanBo. All rights reserved.
//  订单列表的配置model

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface TOSKitOrderDrawerHelper : NSObject

/// 抽屉页面圆角 默认：20.0f
@property (nonatomic, assign) CGFloat                drawerCorner;

/// 店铺图片的圆角 默认：10.0f
@property (nonatomic, assign) CGFloat                logoCorner;

/// 订单列表的背景颜色 默认：#F5F5F5
@property (nonatomic, strong) UIColor                * listBackGroundColor;

/// 单个订单的背景颜色 默认：#FFFFFF
@property (nonatomic, strong) UIColor                * backGroundColor;

/// 单个订单的父视图圆角 默认：8.0f
@property (nonatomic, assign) CGFloat                orderCorner;

/// 商品图标的圆角值 默认：6.0f
@property (nonatomic, assign) CGFloat                productIconCorner;





@end

NS_ASSUME_NONNULL_END
