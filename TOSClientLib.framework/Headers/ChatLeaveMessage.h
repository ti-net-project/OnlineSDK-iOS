//
//  ChatLeaveMessage.h
//  TIMClientLib
//
//  Created by apple on 2021/12/20.
//  Copyright © 2021 YanBo. All rights reserved.
//

#import <TOSClientLib/TOSClientLib.h>

NS_ASSUME_NONNULL_BEGIN

@interface ChatLeaveMessage : TIMMessageContent

@property (nonatomic, copy,readonly) NSString *content;
@property (nonatomic, copy,readonly) NSString *welcomContent;//留言引导语
@property (nonatomic, copy,readonly) NSString *leaveTip;//留言成功提示语

/// 工单留言插件地址
@property (nonatomic, copy, readonly) NSString *ticketPluginUrl;

/// 欢迎语/引导语 内容
@property (nonatomic, copy, readonly) NSString *guideLanguageContent;

/// 1：表单留言     2：对话留言，SDK不做处理     3：工单留言
@property (nonatomic, copy, readonly) NSNumber *webLeaveMessageType;
@property (nonatomic, strong,readonly) NSMutableArray *leaveMessageFields;


- (instancetype)initMessageWithContent:(NSString *)content;

@end

NS_ASSUME_NONNULL_END
