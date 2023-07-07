//
//  TOSMessageKnowledgeBaseModel.h
//  TOSClientLib
//
//  Created by 言 on 2023/1/9.
//  Copyright © 2023 YanBo. All rights reserved.
//

#import <TOSClientLib/TOSClientLib.h>

NS_ASSUME_NONNULL_BEGIN

@interface TOSMessageKnowledgeBaseFileModel : TIMMessageContent

@property (nonatomic, copy) NSString *fileName;
@property (nonatomic, copy) NSString *fileKey;
@property (nonatomic, copy) NSString *kbFileUrl;

@end

@interface TOSMessageKnowledgeBaseListClickModel : TIMMessageContent

@property (nonatomic, copy) NSString *rename_id;
@property (nonatomic, copy) NSString *content;
@property (nonatomic, copy) NSString *subType;

@end

@interface TOSMessageKnowledgeBaseListModel : TIMMessageContent

@property (nonatomic, copy) NSString *type;
@property (nonatomic, strong) TOSMessageKnowledgeBaseListClickModel *click;

@end

@interface TOSMessageKnowledgeBaseModel : TIMMessageContent

@property (nonatomic, copy) NSString *head;
@property (nonatomic, strong) NSArray <TOSMessageKnowledgeBaseListModel *>*list;

@end

NS_ASSUME_NONNULL_END
