//
//  TIMOrderEventMessage.h
//  TOSClientLib
//
//  Created by 李成 on 2024/11/11.
//  Copyright © 2024 YanBo. All rights reserved.
//  机器人订单事件

#import <TOSClientLib/TOSClientLib.h>

NS_ASSUME_NONNULL_BEGIN

@interface TIMOrderEventMessage : TIMMessageContent


/// 名称
@property (nonatomic, copy) NSString                * name;

/// 失败文案
@property (nonatomic, copy) NSString                * failContent;

/// 事件类型
@property (nonatomic, copy) NSString                * event;


- (instancetype)initMessageWithContent:(NSString *)content;

@end

NS_ASSUME_NONNULL_END
