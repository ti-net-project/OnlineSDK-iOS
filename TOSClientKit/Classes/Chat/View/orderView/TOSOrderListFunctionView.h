//
//  TOSOrderListFunctionView.h
//  TOSClientKit
//
//  Created by 李成 on 2024/10/31.
//  Copyright © 2024 YanBo. All rights reserved.
//  功能按钮区域

#import <TOSClientKit/TOSClientKit.h>
#import "TOSOrderButtonConfigModel.h"

NS_ASSUME_NONNULL_BEGIN

@protocol TOSOrderListFunctionViewDelegate <NSObject>

- (void)TOSOrderListFunctionViewClink:(NSInteger)index;

@end

@interface TOSOrderListFunctionView : TOSBaseView

@property (nonatomic, weak) id <TOSOrderListFunctionViewDelegate>                delegate;



/// 功能按钮数组
@property (nonatomic, strong) NSArray<TOSOrderButtonConfigModel *>                * itemsArray;

/// 功能按钮底部右下角的数据model
@property (nonatomic, strong) TOSOrderBottomButtonConfigModel                * bottomModel;

/// 更多按钮要展示的数据从第几个开始
@property (nonatomic, assign) NSInteger                moreIndex;


@end

NS_ASSUME_NONNULL_END
