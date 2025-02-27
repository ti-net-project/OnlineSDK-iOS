//
//  OnlineEventSendManager.h
//  TIMClientLib
//
//  Created by apple on 2021/10/30.
//  Copyright © 2021 YanBo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TIMStatusDefine.h"

NS_ASSUME_NONNULL_BEGIN

@interface OnlineEventSendManager : NSObject

+ (instancetype)sharedOnlineEventSendManager;

#pragma mark 访客上线
- (void)chatOnlineEventWithSuccess:(void (^)(void))successBlock
                             error:(void (^)(TIMConnectErrorCode errCode,NSString *errorDes))errorBlock;

#pragma mark 访客离线
- (void)chatOfflineEventWithSuccess:(void (^)(void))successBlock
                              error:(void (^)(TIMConnectErrorCode errCode,NSString *errorDes))errorBlock;

#pragma mark 访客关闭会话事件
- (void)chatCloseEventWithSuccess:(void (^)(void))successBlock
                            error:(void (^)(TIMConnectErrorCode errCode,NSString *errorDes))errorBlock;

/// 关闭上一个会话
- (void)closeLastSessionWithVisitorId:(NSString *)visitorId
                              success:(void (^)(void))successBlock
                                error:(void (^)(TIMConnectErrorCode errCode,NSString *errorDes))errorBlock;

/// http接口关闭会话
- (void)chatCloseSessionEventWithMainUniqueId:(NSString *)mainUniqueId
                                withVisitorId:(NSString *)visitorId
                                      success:(void (^)(void))successBlock
                                        error:(void (^)(TIMConnectErrorCode errCode,NSString *errorDes))errorBlock;


#pragma mark 退出排队
- (void)leaveQueueEventWithSuccess:(void (^)(void))successBlock
                             error:(void (^)(TIMConnectErrorCode errCode,NSString *errorDes))errorBlock;

#pragma mark 访客消息预知事件
- (void)inputHintEventWithText:(NSString*)text
                       success:(void (^)(void))successBlock
                         error:(void (^)(TIMConnectErrorCode errCode,NSString *errorDes))errorBlock;

#pragma mark 访客提交留言
- (void)upLoadChatLeaveMessageEventWithPayloads:(NSDictionary*)payloads
                                        success:(void (^)(void))successBlock
                                          error:(void (^)(TIMConnectErrorCode errCode,NSString *errorDes))errorBlock;



@end

NS_ASSUME_NONNULL_END
