//
//  CombinationMessage.h
//  TOSClientLib
//
//  Created by 言 on 2022/8/1.
//  Copyright © 2022 YanBo. All rights reserved.
//

#import <TOSClientLib/TOSClientLib.h>

NS_ASSUME_NONNULL_BEGIN

@interface KnowledgeDataModel : TIMMessageContent

@property (nonatomic, copy) NSString *content;

@property (nonatomic, strong) NSNumber *rename_id;

@property (nonatomic, copy) NSString *type;

@end


@interface CombinationDataModel : TIMMessageContent 

@property (nonatomic, copy) NSString *name;
@property (nonatomic, strong) NSArray <NSString *>*topics;

@property (nonatomic, assign) CGRect contentF;

@property (nonatomic, assign) CGFloat tableViewH;

/// 当前展示在哪页
@property (nonatomic, assign) NSInteger selectPageData;

@property (nonatomic, strong) NSArray <KnowledgeDataModel *>*knowledge;

@end

@interface CombinationMessage : TIMMessageContent

/// 6、15~20：热点问题   21~25：京东智能系列
/// 1：文本消息，2：图片，3：文件，4：视频，5：富文本消息，6：机器人选项消息，7：语音，8：知识库文件，9：套电（废弃），10：商品卡片，物流卡片，11：订单卡片，12：留言消息，13：小程序卡片，14：机器人组合消息，15：机器人相关问题，16：机器人猜你想问(热门问题)，17：机器人常见问题，18：机器人近似问题，19：机器人选项消息(推荐问)，20：机器人相关问题（常见问），21~25：fold、link、select、flow from、gus card，26 知识库的问答库和文档库，30：机器人快捷回复，31：机器人热门问题（竖版），32：图文消息
@property (nonatomic, copy) NSString *type;
@property (nonatomic, copy) NSString *text;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *subType;
@property (nonatomic, strong) NSArray <NSString *>*cards;
@property (nonatomic, strong) NSArray <CombinationDataModel *>*data;
@property (nonatomic, strong) NSArray <KnowledgeDataModel *>*knowledge;

@property (nonatomic, strong) RichTextMessage *richTextMessage;

/// 文件沙盒存储地址
@property (nonatomic, copy) NSString *mediaPath;
/**
 robotProvider
 */
@property (nonatomic, strong) NSString *robotProvider;

/// 选择的问题类型
@property (nonatomic, assign) NSInteger selectData;

/// 当前展示在哪页
@property (nonatomic, assign) NSInteger selectPageData;

@property (nonatomic, assign) CGRect contentF;

/// 横版热点问题的子问题布局
@property (nonatomic, strong) NSArray <NSNumber *>*hotSubIssueH;

/// 竖版热点问题的标题布局
@property (nonatomic, strong) NSArray <NSNumber *>*hotListTypeTitleH;

/// 竖版热点问题的标题布局
@property (nonatomic, strong) NSArray <NSNumber *>*hotListTypeTitleY;

/// 竖版热点问题的子问题布局
@property (nonatomic, strong) NSArray <NSNumber *>*hotListTypeSubIssueH;

/// 竖版热点问题的子问题布局
@property (nonatomic, strong) NSArray <NSNumber *>*hotListTypeSubIssueY;

@property (nonatomic, assign) CGFloat tableViewH;

@property (nonatomic, assign) CGSize refreshBtnSize;

@property (nonatomic, assign) CGFloat segmentHeight;

@end


NS_ASSUME_NONNULL_END
