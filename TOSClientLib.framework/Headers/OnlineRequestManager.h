//
//  OnlineRequestManager.h
//  TIMClientLib
//
//  Created by apple on 2021/10/29.
//  Copyright © 2021 YanBo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TIMStatusDefine.h"

#import "OnlineTokenModel.h"
#import "OnlineChatRecordModel.h"
#import "OnlineClientInfoModel.h"
#import "TOSSessionInfoModel.h"

typedef void (^RequestClientInfoComplete)(OnlineClientInfoModel *model, TIMConnectErrorCode errCode, NSString *errorDes);

NS_ASSUME_NONNULL_BEGIN
@class ChatInvestigationMessage;

@interface OnlineRequestManager : NSObject

+ (instancetype)sharedCustomerManager;

/// 用户信息存储
@property (atomic, strong) NSMutableDictionary <NSString *, OnlineClientInfoModel *>*clientInfoDic;

/// 更新客户资料数据
@property (nonatomic, strong, nullable) NSDictionary                * customerFields;


#pragma mark 获取token
-(void)getUserInfoWithUserId:(NSString*)userId
                  externalId:(NSString *)externalId
                    nickname:(NSString*)nickname
                    phoneNum:(NSString*)phoneNum
                   headerUrl:(NSString*)headerUrl
              connectSuccess:(void (^)(void))connectSuccessBlock
                       error:(void (^)(TIMConnectErrorCode errCode,NSString *errorDes))errorBlock
              tokenIncorrect:(void (^)(void))tokenIncorrectBlock;

#pragma mark  建立会话访客初始化
-(void)visitorReadyWithDict:(NSDictionary*)moreDict
                    success:(void (^)(TOSSessionInfoModel * sessModel))successBlock
                      error:(void (^)(TIMConnectErrorCode errCode,NSString *errorDes))errorBlock;

#pragma mark  获取全局配置信息
-(void)getAppSettings:(void (^)(void))successBlock
                      error:(void (^)(TIMConnectErrorCode errCode,NSString *errorDes))errorBlock;


/// 获取icon的资源图标
/// - Parameters:
///   - iconUrl: icon的地址。（用来获取真实的资源地址）
///   - success: 成功回调
///   - failure: 失败回调
- (void)getIconUrl:(NSString *)iconUrl
       withSuccess:(void (^)(NSString * url))success
       withFailure:(void (^)(TIMConnectErrorCode errCode, NSString *errorDes))failure;

#pragma mark  获取历史消息
-(void)getChatRecordListLastTime:(NSString *)lastTime
                           limit:(NSString *)limit
                         success:(void (^)(NSArray * chatList))successBlock
                           error:(void (^)(TIMConnectErrorCode errCode,NSString *errorDes))errorBlock;

#pragma mark  发送图片消息
-(void)sendImgMessageWithImageData:(NSData *)imageData
                           success:(void (^)(NSDictionary * result))successBlock
                             error:(void (^)(TIMConnectErrorCode errCode,NSString *errorDes))errorBlock;

#pragma mark  发送语音消息
-(void)sendVoiceMessageWithVoiceData:(NSData *)voiceData
                             success:(void (^)(void))successBlock
                               error:(void (^)(TIMConnectErrorCode errCode,NSString *errorDes))errorBlock;

#pragma mark  发送视频消息
-(void)sendVideoMessageWithVideoData:(NSData *)videoData
                             success:(void (^)(void))successBlock
                               error:(void (^)(TIMConnectErrorCode errCode,NSString *errorDes))errorBlock;

#pragma mark  发送文件消息
-(void)sendFileMessageWithFileData:(NSData *)fileData
                          fileType:(NSString *)fileType
                          fileName:(NSString *)fileName
                             success:(void (^)(void))successBlock
                               error:(void (^)(TIMConnectErrorCode errCode,NSString *errorDes))errorBlock;

#pragma mark  获取客服信息
- (void)getClientInfoWithSender:(NSString *)sender
                     senderType:(NSString *)senderType
                       complete:(RequestClientInfoComplete)completeBlock;

#pragma mark - 链接外跳
/// 获取订单抽屉的列表数据
/// - Parameters:
///   - mainUniqueId: 会话ID
///   - params: 请求携带的参数
///   - success: 成功回调
///   - failure: 错误回调
- (void)getQuickEntryLinkWithMainUniqueId:(NSString *)mainUniqueId
                                      url:(NSString *)url
                               withParams:(NSDictionary *)params
                              withSuccess:(void (^)(NSString * result))success
                              withFailure:(void (^)(TIMConnectErrorCode errCode, NSString *errorDes))failure;

/// 获取订单抽屉的列表数据
/// - Parameters:
///   - mainUniqueId: 会话ID
///   - params: 请求携带的参数
///   - pageIndex: 列表页码，默认从1开始
///   - pageSize: 每页获取数量，默认每页获取数量为10。
///   - success: 成功回调
///   - failure: 错误回调
- (void)getOrderDrawerListWithMainUniqueId:(NSString *)mainUniqueId
                                withParams:(NSDictionary *)params
                             withPageIndex:(NSInteger)pageIndex
                              withPageSize:(NSInteger)pageSize
                               withSuccess:(void (^)(NSArray * orderList))success
                               withFailure:(void (^)(TIMConnectErrorCode errCode, NSString *errorDes))failure;

#pragma mark - 提交机器人回答点赞点踩
-(void)submitBotAnswerFeedbackWithAnswerUniqueId:(NSString *)answerUniqueId
                                    mainUniqueId:(NSString *)mainUniqueId
                                           botId:(NSString *)botId
                                         content:(NSString *)content
                               botAnswerFeedback:(NSString *)botAnswerFeedback
                            robotNotHelpfulItems:(NSMutableSet <NSString *>*)robotNotHelpfulItems
                                         success:(void (^)(NSString *result))successBlock
                                           error:(void (^)(TIMConnectErrorCode errCode,NSString *errorDes))errorBlock;

#pragma mark  获取已提交满意度信息
-(void)getInvestigationInfoSuccess:(void (^)(void))successBlock
                            error:(void (^)(TIMConnectErrorCode errCode,NSString *errorDes))errorBlock;

#pragma mark  提交满意度
//options: @[@{@"name": @"", @"star": @"", @"label": @[@"", @"",]}]
//solve: 1满意，2不满意
-(void)submitInvestigationUniqueId:(NSString *)uniqueId
                      mainUniqueId:(NSString *)mainUniqueId
                           options:(NSArray *)options
                             solve:(NSString *)solve
                            remark:(NSString *)remark
                           Success:(void (^)(void))successBlock
                            error:(void (^)(TIMConnectErrorCode errCode,NSString *errorDes))errorBlock;

#pragma mark 获取满意度弹窗的uniqueid
// 获取满意度弹窗的uniqueid
-(void)getInvestigationUniqueIdSuccess:(void (^)(NSString *messageUniqueId))successBlock
                                 error:(void (^)(TIMConnectErrorCode errCode,NSString *errorDes))errorBlock;

-(void)getInvestigationUniqueIdWithType:(BOOL)investigationInviteType
                                success:(void (^)(NSString *messageUniqueId))successBlock
                                 error:(void (^)(TIMConnectErrorCode errCode,NSString *errorDes))errorBlock;

/**
 未读消息获取
@param visitorId          当前用户ID
@param mainUniqueId    会话ID （如果为空字符串就是获取总的未读消息数）
*/
- (void)sessionInfoUnreadCountCurrentVisitorId:(NSString *)visitorId WithMainUniqueId:(NSString *)mainUniqueId withSuccess:(void (^)(NSString *lastMessage , NSInteger unreadCount))successBlock withError:(void (^)(NSString *errorStr))errorBlock;

/*
 进入会话发送已读
@param mainUniqueId    会话ID     (内部 OnlineRequestManager 类调用)
 **/
- (void)sessionInfoReadWithMainUniqueId:(NSString *)mainUniqueId;

/*
 获取会话状态
 **/
- (void)sessionInfoGet:(void (^)(TOSSessionInfoModel * sessModel))successBlock
                              error:(void (^)(TIMConnectErrorCode errCode,NSString *errorDes))errorBlock;

/*
 获取留言数据接口请求
 **/
- (void)getTicketCommentStatistics:(NSNumber *)commentCountEnable
              visitorCreatedTicket:(NSNumber *)visitorCreatedTicket
                   ticketPluginUrl:(NSString *)ticketPluginUrl
                    ticketPluginId:(NSNumber *)ticketPluginId
                pluginTicketEnable:(NSNumber *)pluginTicketEnable
                           success:(void (^)(NSNumber *staffCommentTotalCount,
                                             NSString *ticketPluginUrl,
                                             NSNumber *ticketPluginId))successBlock
                             error:(void (^)(TIMConnectErrorCode errCode,NSString *errorDes))errorBlock;

/*
 拼接链接参数
 **/
- (void)jointUrlParam:(NSString *)url
                 type:(NSString *)type
   commentCountEnable:(NSNumber *)commentCountEnable
 visitorCreatedTicket:(NSNumber *)visitorCreatedTicket
              success:(void (^)(NSString *url))successBlock
                error:(void (^)(TIMConnectErrorCode errCode,NSString *errorDes))errorBlock;

@end

NS_ASSUME_NONNULL_END
