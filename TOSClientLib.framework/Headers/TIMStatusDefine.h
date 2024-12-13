//
//  TIMStatusDefine.h
//  TIMClientDemo
//
//  Created by YanBo on 2020/3/30.
//  Copyright © 2020 YanBo. All rights reserved.
//

#ifndef TIMErrorDefine_h
#define TIMErrorDefine_h

#pragma mark - lib层发送消息成功的UI刷新事件
static NSString * kTIMMessageUpdateChatUIFromLibNotification=@"TIMMessageUpdateChatUIFromLibNotification";

/// 发送消息事件通知
static NSString * kTIMMessageSendChatUIFromLibNotification = @"TIMMessageSendChatUIFromLibNotification";

/// 发送消息事件通知(非UI层面的，例如：快捷入口的)
static NSString * kTIMMessageSendChatMessageUIFromLibNotification = @"kTIMMessageSendChatMessageUIFromLibNotification";

/// 获取配置信息成功的通知(用来配置输入区域的快捷入口和更多面板的数据)
static NSString * kTIMGetAppSettingNotification = @"kTIMGetAppSettingNotification";

//更新群聊已读/未读 刷新
//static NSString * const kTIMUpdateUnreadMessageNotification = @"kTIMUpdateUnreadMessageNotification";

//数据同步完成
static NSString * const kTIMIOnDataSynced = @"kTIMIOnDataSynced";

#pragma mark - 离线推送消息扩展标识
static NSString * kSendPushExtra_CUSTOMER_TINET = @"customer_tinet";

#pragma mark - 消息事件字串定义
static NSString * kMQTTMessage_EVENT_MESSAGE_ARRIVED = @"[MESSAGE ARRIVED]";
static NSString * kMQTTMessage_EVENT_MESSAGE_ACK = @"[MESSAGE ACK]";     // 消息发送确认事件
static NSString * kMQTTMessage_EVENT_KICK_OUT = @"[KICK OUT]";          // 剔除事件
static NSString * kMQTTMessage_EVENT_REVOKE_ACK = @"[REVOKE ACK]";         // 撤回确认事件
static NSString * kMQTTMessage_EVENT_REVOKE = @"[REVOKE]";         // 撤回事件
static NSString * kMQTTMessage_EVENT_ENDPOINT_ARRIVED = @"[ENDPOINT ARRIVED]";// 客服消息事件

static NSString * kMQTTMessage_EVENT_SYNC_DATA = @"[SYNC DATA]";  //会话未读数同步数据

static NSString * kMQTTMessage_EVENT_MESSAGE_RECEIVE_ACK = @"[MESSAGE RECEIVE ACK]"; //消息确认已读，服务器回给发送者消息已读，多个msgIds之间用逗号分隔

//static NSString * kMQTTMessage_EVENT_GROUP_MESSAGE_RECEIVE_ACK = @"[GROUP MESSAGE RECEIVE ACK]"; //群组消息确认已读，服务器会给发送者消息已读

#pragma mark - 消息状态

#pragma mark TIMMessageLocalStatus - 本地消息状态枚举
/*
 本地消息状态枚举
 
 */
typedef NS_ENUM(NSInteger, TIMMessageLocalStatus) {
    /*
     本地显示

     */
    TIMMessageLocalStatus_Show = 1,
    /*
     本地删除

     */
    TIMMessageLocalStatus_Remove = 2,
};

TIMMessageLocalStatus TIMMessageLocalStatusWithString(NSString *commandString);
NSString *TIMMessageLocalStatusString(TIMMessageLocalStatus timSessionType);

#pragma mark TIMMessageSenderType - 消息发送人类型
/*
 消息发送人类型
 
 */
typedef NS_ENUM(NSInteger, TIMMessageSenderType) {
    /*
    未知
     */
    TIMMessageSenderType_Unkwon = 0,
    /*
    坐席
     */
    TIMMessageSenderType_Online = 1,
    /*
     访客

     */
    TIMMessageSenderType_Visitor = 2,
    /*
    系统

    */
    TIMMessageSenderType_System = 3,
    /*
    机器人

    */
    TIMMessageSenderType_Robot = 4,
    /*
    系统通知

    */
    TIMMessageSenderType_Notify = 5,
};

#pragma mark TIMMessageStatus - 消息状态枚举
/*
 消息状态枚举
 
 */
typedef NS_ENUM(NSInteger, TIMMessageStatus) {
    /*
     发送失败

     */
    TIMMessageStatus_Send_Failed = -1,
    /*
     发送中

     */
    TIMMessageStatus_Sending = 0,
    /*
    已发送

    */
    TIMMessageStatus_Sended = 1,
    /*
    对方未读

    */
    TIMMessageStatus_Peer_Unread = 2,
    /*
    对方已读

    */
    TIMMessageStatus_Peer_Read = 3,
    /*
    已撤回

    */
    TIMMessageStatus_ReCall = 4,
    /*
    已删除

    */
    TIMMessageStatus_Remove = 5,
    /*
    保持

    */
    TIMMessageStatus_Keep = 8,
};

TIMMessageStatus TIMMessageStatusWithString(NSString *commandString);
NSString *TIMMessageStatusString(TIMMessageStatus timSessionType);

#pragma mark - 会话类型

#pragma mark TIMSessionType - 会话类型枚举
/*
 会话类型枚举

 @discussion 包含单聊和群聊
 */
typedef NS_ENUM(NSInteger, TIMSessionType) {
    /*
     单聊 废弃

     */
    TIMSessionType_SINGLE_CHAT = 1,
    /*
     群聊 废弃

     */
    TIMSessionType_GROUP_CHAT = 2,
    /*
     客服

     */
    TIMSessionType_OnLINESERVICE_CHAT = 3,
};

TIMSessionType TIMSessionTypeWithString(NSString *commandString);
NSString *TIMSessionTypeString(TIMSessionType timSessionType);

#pragma mark - 用户类型

#pragma mark TIMUserType - 用户类型枚举
/*
 用户类型枚举

 @discussion 目前仅包含长期有效客户和临时客户
 */
typedef NS_ENUM(NSInteger, TIMUserType) {
    /*
     长期有效客户类型

     */
    TIMUserType_LONGTERM_AVAILABLE = 1,
    /*
     临时有效客户类型

     */
    TIMUserType_TEMPORARY_AVAILABLE = 2,
};

TIMUserType TIMUserTypeWithString(NSString *commandString);
NSString *TIMUserTypeString(TIMUserType timUserType);

#pragma mark - 错误码相关

#pragma mark TIMConnectErrorCode - 建立连接返回的错误码

typedef NS_ENUM(NSInteger, TIMConnectErrorCode) {
    /**
     api请求HTTP发送失败

     @discussion 如果是偶尔出现此错误，SDK会做好自动重连，开发者无须处理。如果一直是这个错误，应该是您没有设置好ATS。
     */
    TIM_API_REQUEST_SUCCESSFUL = 2000,
    /**
     api请求HTTP发送失败

     @discussion 如果是偶尔出现此错误，SDK会做好自动重连，开发者无须处理。如果一直是这个错误，应该是您没有设置好ATS。
     */
    TIM_API_REQUEST_FAIL = 4003,

    /**
     api请求HTTP请求失败

     @discussion 连接相关的错误码，SDK会做好自动重连，开发者无须处理。
     */
    TIM_API_RESPONSE_ERROR = 4004,
    
    /**
     信令发送失败

     @discussion 连接相关的错误码，SDK会做好自动重连，开发者无须处理。
     */
    TIM_MSG_SEND_FAIL = 4005,

    /**
     获取设备UDID失败

     @discussion 连接相关的错误码，需要主动再次调用。
     */
    TIM_CONN_GETUDID_FAILED = 4006,
};


#endif /* TIMErrorDefine_h */
