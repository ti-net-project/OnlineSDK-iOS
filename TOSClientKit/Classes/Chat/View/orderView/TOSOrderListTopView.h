//
//  TOSOrderListTopView.h
//  TOSClientKit
//
//  Created by 李成 on 2024/10/31.
//  Copyright © 2024 YanBo. All rights reserved.
//  订单商品店铺信息区域

#import <TOSClientKit/TOSClientKit.h>
#import "TOSOrderListModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface TOSOrderListTopView : TOSBaseView

@property (nonatomic, strong) TOSOrderListModel                * model;

- (void)prepareForReuse;

@end

NS_ASSUME_NONNULL_END
