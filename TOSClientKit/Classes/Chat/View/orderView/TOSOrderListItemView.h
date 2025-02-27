//
//  TOSOrderListItemView.h
//  TOSClientKit
//
//  Created by 李成 on 2024/10/31.
//  Copyright © 2024 YanBo. All rights reserved.
//  订单信息item

#import <TOSClientKit/TOSClientKit.h>
#import "TOSOrderListProductModel.h"

NS_ASSUME_NONNULL_BEGIN

@protocol TOSOrderListItemViewDelegate <NSObject>

- (void)TOSOrderListItemViewFunctionClick:(NSInteger)index withModel:(TOSOrderListProductModel *)model;

/// 卡片的整体点击
- (void)TOSOrderListItemViewCradTouchClick:(NSInteger)index withModel:(TOSOrderListProductModel *)productModel;


@end


@interface TOSOrderListItemView : TOSBaseView

@property (nonatomic, weak) id <TOSOrderListItemViewDelegate>                delegate;

@property (nonatomic, strong) TOSOrderListProductModel                * model;

@end

NS_ASSUME_NONNULL_END
