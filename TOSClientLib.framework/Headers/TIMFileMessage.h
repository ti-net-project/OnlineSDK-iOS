//
//  TIMFileMessage.h
//  TIMClientLib
//
//  Created by YanBo on 2020/5/6.
//  Copyright © 2020 YanBo. All rights reserved.
//

#import "TIMMessageContent.h"

NS_ASSUME_NONNULL_BEGIN

@interface TIMFileMessage : TIMMessageContent

/**
 文件的URL
 */
@property (nonatomic, copy,readonly) NSString *fileUrl;

/**
 文件大小 单位bytes
 */
@property (nonatomic,assign,readonly) long fileSize;

/**
 文件类型 如txt ,doc等
 */
@property (nonatomic,assign,readonly) NSString *type;

/**
 文件名称
 */
@property (nonatomic,assign,readonly) NSString *name;

/**
 语音消息的附加信息 扩展信息，可以放置任意的数据内容 加密
 */
@property (nonatomic, copy,readonly) NSString *extra;

/**
 初始化视频消息

 @param fileUrl           文件消息的URL
 @param fileSize         文件大小
 @param type                  文件类型
 @param name                  文件名称
 @return            文件消息对象
 */
- (instancetype)initMessageWithContent:(NSString *)fileUrl fileSize:(long)fileSize type:(NSString *)type name:(NSString *)name;

/**
初始化视频消息

@param fileUrl           文件消息的URL
@param fileSize         文件大小
@param type                  文件类型
@param name                  文件名称
@param extra                附加消息
@return            文件消息对象
*/

- (instancetype)initMessageWithContent:(NSString *)fileUrl fileSize:(long)fileSize type:(NSString *)type name:(NSString *)name extra:(nullable NSString *)extra;

@end

NS_ASSUME_NONNULL_END
