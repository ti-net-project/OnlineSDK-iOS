//
//  CombinationMessage.h
//  TOSClientLib
//
//  Created by 言 on 2022/8/1.
//  Copyright © 2022 YanBo. All rights reserved.
//

#import <TOSClientLib/TOSClientLib.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, HelpfulAndUnHelpfulSelectType) {
    HelpfulAndUnHelpfulSelectType_Unknown   = 0,
    HelpfulAndUnHelpfulSelectType_Helpful   = 1,
    HelpfulAndUnHelpfulSelectType_UnHelpful = 2,
};

@interface CombinationRobotFormDataIntentsModel : TIMMessageContent

@property (nonatomic, strong) NSNumber *type;
@property (nonatomic, copy) NSString *intent;
@property (nonatomic, copy) NSString *desc;

@end

@interface CombinationRobotFormDataModel : TIMMessageContent

@property (nonatomic, copy) NSArray <CombinationRobotFormDataIntentsModel *>*intents;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *link;
@property (nonatomic, strong) NSNumber *type;

@end

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
/// 1：文本消息，2：图片，3：文件，4：视频，5：富文本消息，6：机器人选项消息，7：语音，8：知识库文件，9：套电（废弃），10：商品卡片，物流卡片，11：订单卡片，12：留言消息，13：小程序卡片，14：机器人组合消息，15：机器人相关问题，16：机器人猜你想问(热门问题)，17：机器人常见问题，18：机器人近似问题，19：机器人选项消息(推荐问)，20：机器人相关问题（常见问），21~25：fold、link、select、flow from、gus card，26 知识库的问答库和文档库，30：机器人快捷回复，31：机器人热门问题（竖版），32：图文消息，36：机器人阶段表单收集
@property (nonatomic, copy) NSString *type;
@property (nonatomic, copy) NSString *text;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *subType;
@property (nonatomic, strong) NSArray <NSString *>*cards;
@property (nonatomic, strong) NSArray <CombinationDataModel *>*data;
@property (nonatomic, strong) CombinationRobotFormDataModel *robotFormData;
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

#pragma mark - 点赞点踩相关数据

@property (nonatomic, copy) NSString *mainUniqueId;

/// 机器人回答id
@property (nonatomic, copy) NSString *botAnswerUniqueId;

/// 机器人id
@property (nonatomic, copy) NSString *sender;

/// 是否处于历史回显状态
@property (nonatomic, assign) BOOL closeClick;

/// 是否有点赞点踩功能
@property (nonatomic, assign) BOOL clickLikeFeature;

/// 是否显示必填提示
@property (nonatomic, assign) BOOL showRequiredWarning;

/// 是否展示来源
@property (nonatomic, assign) BOOL showAnswerSource;

/// 是否选中点赞或点踩
@property (nonatomic, assign) HelpfulAndUnHelpfulSelectType helpfulSelectType;

/// 选中的点踩标签
@property (nonatomic, strong) NSMutableArray <NSString *>*unHelpfulSelectTags;

/// 保存点踩输入的评价
@property (nonatomic, copy) NSString *unHelpfulText;

@property (nonatomic, assign) CGRect requiredWarningF;

/// 参考来源数据
@property (nonatomic, copy) NSString *answerSource;

/// 来源数据 富文本
@property (nonatomic, strong) NSMutableAttributedString *answerSourceAtt;

/// 来源数据 虚线
@property (nonatomic, strong) CAShapeLayer *answerSourceDashedLine;
@property (nonatomic, assign) CGRect answerSourceDashedLineF;

/// 参考来源UI
@property (nonatomic, assign) CGRect answerSourceF;

@property (nonatomic, assign) CGRect helpfulAndUnHelpfulContentF;
@property (nonatomic, assign) CGRect helpfulBtnF;
@property (nonatomic, assign) CGRect helpfulAndUnHelpfulLineF;
@property (nonatomic, assign) CGRect unHelpfulBtnF;

@property (nonatomic, assign) CGRect unHelpfulTagAndTextViewContentF;
@property (nonatomic, strong) NSMutableArray <NSValue *>*unHelpfulTagsF;
@property (nonatomic, assign) CGRect unHelpfulTextViewF;
@property (nonatomic, assign) CGRect unHelpfulSubmitF;

@end


NS_ASSUME_NONNULL_END
