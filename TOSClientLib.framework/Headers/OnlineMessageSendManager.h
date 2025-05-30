//
//  OnlineMessageSendManager.h
//  TIMClientLib
//
//  Created by apple on 2021/10/30.
//  Copyright © 2021 YanBo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TIMStatusDefine.h"
#import <TOSClientLib/TOSClientLib.h>

NS_ASSUME_NONNULL_BEGIN

@interface OnlineMessageSendManager : NSObject

+ (instancetype)sharedOnlineMessageSendManager;

#pragma mark  发送商品卡片消息
- (void)sendCommodityCardMessageWithMessageStr:(NSDictionary *)messageStr
                                       success:(void (^)(TOSMessage * timMessage))successBlock
                                         error:(void (^)(TIMConnectErrorCode errCode,NSString *errorDes))errorBlock;

#pragma mark - 发送订单卡片消息
/// 发送订单卡片
/// - Parameters:
///   - messageStr: 订单的参数
///   - successBlock: 成功回调
///   - errorBlock: 失败回调
- (void)sendOrderCardMessageWithMessageStr:(NSDictionary *)messageStr
                              success:(void (^)(TOSMessage * timMessage))successBlock
                                     error:(void (^)(TIMConnectErrorCode errCode,NSString *errorDes))errorBlock;
#pragma mark  发送文字消息
/// 发送文字消息
/// @param messageStr 文本
/// @param knowledge 知识库字段
/// @param sysTransfer 转人工事件
/// @param intent 机器人表单意图
/// @param messageUUID messageUUID
/// @param successBlock successBlock
/// @param errorBlock errorBlock
- (void)sendTextMessageWithMessageStr:(NSString *)messageStr
                            knowledge:(NSString *)knowledge
                          sysTransfer:(BOOL)sysTransfer
                               intent:(NSString *)intent
                          messageUUID:(NSString *)messageUUID
                              success:(void (^)(TOSMessage * timMessage))successBlock
                                error:(void (^)(TIMConnectErrorCode errCode,NSString *errorDes))errorBlock;

/// 发送事件消息
/// @param event 事件名称
/// @param messageUUID messageUUID
/// @param successBlock successBlock
/// @param errorBlock errorBlock
- (void)sendEventMessageWithEvent:(NSString*)event
                      messageUUID:(NSString *)messageUUID
                          success:(void (^)(TOSMessage * timMessage))successBlock
                            error:(void (^)(TIMConnectErrorCode errCode,NSString *errorDes))errorBlock;

#pragma mark  发送图片消息
- (void)sendImageMessageWithImageData:(NSData *)imageData
                              success:(void (^)(NSString * messageId,NSString * fileKey))successBlock
                                error:(void (^)(TIMConnectErrorCode errCode,NSString *errorDes))errorBlock;

#pragma mark  发送语音消息
- (void)sendVoiceMessageWithVoiceData:(NSData *)voiceData
                              success:(void (^)(NSString * messageId))successBlock
                                error:(void (^)(TIMConnectErrorCode errCode,NSString *errorDes))errorBlock;

#pragma mark  发送视频消息
- (void)sendVideoMessageWithVideoData:(NSData *)videoData
                              success:(void (^)(NSString * messageId))successBlock
                                error:(void (^)(TIMConnectErrorCode errCode,NSString *errorDes))errorBlock;

#pragma mark  发送文件消息
- (void)sendFileMessageWithFileData:(NSData *)fileData
                           fileType:(NSString *)fileType
                           fileName:(NSString *)fileName
                            success:(void (^)(NSString * messageId))successBlock
                              error:(void (^)(TIMConnectErrorCode errCode,NSString *errorDes))errorBlock;

@end

NS_ASSUME_NONNULL_END
