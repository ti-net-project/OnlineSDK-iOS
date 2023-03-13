//
//  RichTextMessage.h
//  TIMClientLib
//
//  Created by apple on 2021/10/28.
//  Copyright © 2021 YanBo. All rights reserved.
//

#import <TOSClientLib/TOSClientLib.h>
#import <TOSClientLib/TIMMessageContent.h>
#import <TOSClientLib/OnlineChatRecordModel.h>

NS_ASSUME_NONNULL_BEGIN

@interface RichTextMessage : TIMMessageContent

/// 引用消息数据
@property (nonatomic, strong) RepliedMessageModel *repliedMessage;

@property (nonatomic, copy,readonly) NSString *content;
@property (nonatomic, copy,readonly) NSString *textContent;

/// text、a、img、video、tr、knowledge、knowledgeBase
@property (nonatomic, copy,readonly) NSString *type;
@property (nonatomic, copy) NSString *fileKey;
@property (nonatomic, copy) NSString *urlPath;

/// underline Or line-through
@property (nonatomic, copy) NSString *style;
@property (nonatomic, copy) NSString *knowledge;

@property (nonatomic, assign) CGRect contentF;

@property (nonatomic, strong) NSMutableArray <RichTextMessage *>*elements;

/// 文本类型标签存在子标签嵌套数据
@property (nonatomic, strong) NSMutableArray <RichTextMessage *>*subElements;


- (instancetype)initMessageWithContent:(NSString *)content;

@end

NS_ASSUME_NONNULL_END
