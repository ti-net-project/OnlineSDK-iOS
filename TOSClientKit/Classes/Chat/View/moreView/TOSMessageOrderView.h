//
//  TOSMessageOrderView.h
//  TOSClientKit
//
//  Created by 李成 on 2024/10/30.
//  Copyright © 2024 YanBo. All rights reserved.
//  订单消息item

#import <TOSClientKit/TOSClientKit.h>
#import <TOSClientLib/TOSOrderMessage.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^OrderClickTouch)(TOSOrderProductModel * model);

@interface TOSMessageOrderView : TOSBaseView

/// 商品model
@property (nonatomic, strong) TOSOrderProductModel                * productModel;

/// 商品的点击事件
@property (nonatomic, copy) OrderClickTouch                clickTouch;


@end

NS_ASSUME_NONNULL_END
