//
//  ChatQueueMessage.h
//  OSClientLib
//
//  Created by apple on 2021/10/19.
//  Copyright © 2021 YanBo. All rights reserved.
//
#import "TIMMessageContent.h"
#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ChatQueueMessage : TIMMessageContent

@property (nonatomic, copy,readonly) NSString *content;
@property (nonatomic, copy,readonly) NSString *locationstr;

/// 放弃是否启用
@property (nonatomic, assign) BOOL                abandonEnabled;


- (instancetype)initMessageWithContent:(NSString *)content;

@end

NS_ASSUME_NONNULL_END
