//
//  TOSMessage.h
//  TIMClient
//
//  Created by YanBo on 2020/3/30.
//  Copyright © 2020 YanBo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TIMMessageContent.h"
#import "TIMStatusDefine.h"

NS_ASSUME_NONNULL_BEGIN

@interface TOSMessage : NSObject

/**
 本地生成的消息唯一ID
 */
@property (nonatomic, copy, readonly) NSString* messageUUID;

/**
 服务器生成的消息id 消息唯一ID 按照时间顺序生成
 */
@property (nonatomic, copy, readonly) NSString* msg_id;

/**
 消息类型
 */
@property (nonatomic, copy, readonly) NSString* type;

/**
 发送者Id
 */
@property (nonatomic, copy, readonly) NSString* senderId;


/**
 接收者Id
 */
@property (nonatomic, copy, readonly) NSString* receiverId;


/**
 消息内容
 */
@property (nonatomic, strong, readonly) TIMMessageContent* content;

/**
 消息归属 1.个人消息   2.群消息
 */
@property (nonatomic, assign, readonly) TIMSessionType msg_from;

/**
 消息状态  1.已发送 2.未读 3.已读 4.已撤回 5.已删除
 */
@property (nonatomic, assign, readonly) TIMMessageStatus status;

/**
 消息子类型
 
 6、15~20：热点问题   21~25：京东智能系列
 1：文本消息，2：图片，3：文件，4：视频，5：富文本消息，6：机器人选项消息，7：语音，8：知识库文件，9：套电（废弃），10：商品卡片，物流卡片，11：订单卡片，12：留言消息，13：小程序卡片，14：机器人组合消息，15：机器人相关问题，16：机器人猜你想问(热门问题)，17：机器人常见问题，18：机器人近似问题，19：机器人选项消息(推荐问)，20：机器人相关问题（常见问），21~25：fold、link、select、flow from、gus card，26 知识库的问答库和文档库，30：机器人快捷回复，31：机器人热门问题（竖版），32：图文消息
 */
@property (nonatomic, assign, readonly) int messageType;

/*
 消息发送者类型
 0:  消息事件(忽略)
 1:  座席
 2:  访客
 3:  系统
 4:  机器人
 5:  系统通知
*/
@property (nonatomic, copy) NSString        *senderType;

@property (nonatomic, copy) NSString  *cno;

/**
 创建时间
 */
@property (nonatomic, assign, readonly) NSTimeInterval timestamp;

///**
// 参数对象初始化方法
//
// @param content                   消息内容
// @param msg_from                消息归属 1.个人消息   2.群消息
// @return               参数对象
// */
//- (instancetype)initWithOption:(TIMMessageContent *)content msgUUID:(NSString *)msgUUID msg_from:(TIMSessionType)msg_from;

/**
 参数对象初始化方法
 
 @param messageUUID                   本地消息唯一ID
 @param msg_id                     服务器生成的消息唯一ID  可以为空以本地消息ID为主
 @param type                         消息类型
 @param senderId                 发送方Id
 @param receiverId             接收方Id
 @param content                   消息内容
 @return               参数对象
 */
- (instancetype)initWithOption:(NSString *)messageUUID msg_id:(NSString *)msg_id type:(NSString *)type senderId:(NSString *)senderId receiverId:(NSString *)receiverId content:(TIMMessageContent *)content msg_from:(TIMSessionType)msg_from status:(TIMMessageStatus)status timestamp:(NSTimeInterval)timestamp;

@end

NS_ASSUME_NONNULL_END
