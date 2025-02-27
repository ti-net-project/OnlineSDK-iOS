//
//  TOSOrderListBottomView.h
//  TOSClientKit
//
//  Created by 李成 on 2024/10/31.
//  Copyright © 2024 YanBo. All rights reserved.
//  底部自定义参数区域

#import <TOSClientKit/TOSClientKit.h>
#import "TOSOrderListModel.h"

NS_ASSUME_NONNULL_BEGIN

@protocol TOSOrderListBottomViewDelegate <NSObject>

- (void)TOSOrderListBottomViewMoreClink;

@end

@interface TOSOrderListBottomView : TOSBaseView

/// 代理
@property (nonatomic, weak) id <TOSOrderListBottomViewDelegate>                delegate;

/// 数据model
@property (nonatomic, strong) TOSOrderListModel                * model;

@end

NS_ASSUME_NONNULL_END
