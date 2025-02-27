//
//  TOSOrderSearchView.h
//  TOSClientKit
//
//  Created by 李成 on 2024/10/30.
//  Copyright © 2024 YanBo. All rights reserved.
//  订单抽屉的顶部搜索区域

#import <TOSClientKit/TOSClientKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol TOSOrderSearchViewDelegate <NSObject>

- (void)TOSOrderSearchViewClickSearch:(NSString *)text;

@end


@interface TOSOrderSearchView : TOSBaseView

@property (nonatomic, weak) id <TOSOrderSearchViewDelegate>                delegate;

/// 暗文
@property (nonatomic, copy) NSString                * placeholder;

@end

NS_ASSUME_NONNULL_END
