//
//  ICChatMessageOrdersCell.h
//  TOSClientKit
//
//  Created by 李成 on 2024/10/30.
//  Copyright © 2024 YanBo. All rights reserved.
//

#import "ICChatMessageBaseCell.h"
#import <TOSClientKit/TOSClientKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ICChatMessageOrdersCell : ICChatMessageBaseCell


@end


@interface TOSOrderMessageTopView : TOSBaseView

@property (nonatomic, strong) TOSOrderMessage                * model;

/// 气泡的宽度
@property (nonatomic, assign) CGFloat                bubbleWidth;


@end

NS_ASSUME_NONNULL_END
