//
//  TOSSDKConfigModel.h
//  TOSClientKit
//
//  Created by 李成 on 2024/11/20.
//  Copyright © 2024 YanBo. All rights reserved.
//

#import <TOSClientLib/TOSClientLib.h>

NS_ASSUME_NONNULL_BEGIN

@class TOSAppWindowSetting;

@interface TOSSDKConfigModel : TIMLibBaseModel

@property (nonatomic, strong) NSDictionary                * appSettings;

@property (nonatomic, strong) NSDictionary                * clientTimeout;

@property (nonatomic, copy) NSString                * closeMessage;

@property (nonatomic, strong) NSDictionary                * inquiryForm;

@property (nonatomic, strong) NSDictionary                * investigation;

@property (nonatomic, copy) NSString                * leaveMessage;

@property (nonatomic, strong) NSNumber                * noStatusTransfer;

@property (nonatomic, copy) NSString                * visitorTimeout;

@property (nonatomic, strong) TOSAppWindowSetting                * appWindowSetting;


@end


@class TOSQuickEntrieModel;
@class TOSToolbarItemModel;

@interface TOSAppWindowSetting : TIMLibBaseModel

/// 快捷回复配置
@property (nonatomic, strong) NSArray<TOSQuickEntrieModel *>                * quickEntries;

/// 工具栏配置,type不存在的可不处理
@property (nonatomic, strong) NSArray<TOSToolbarItemModel *>                * toolbarList;

/// 开关，此开关生效优先用后台配置开关
@property (nonatomic, assign) BOOL                enable;


@end


/// 快捷入口的类型枚举
typedef NS_ENUM(NSInteger, TOSQuickEntrieType) {
    /// 链接外跳
    TOSQuickEntrieTypeLink          =   1,
    /// 满意度评价
    TOSQuickEntrieTypeSatisfaction  =   2,
    /// 结束会话
    TOSQuickEntrieTypeCloseChat     =   3,
    /// 消息发送
    TOSQuickEntrieTypeSendText      =   4,
    /// 订单卡片
    TOSQuickEntrieTypeOrderCard     =   8,
    /// 工单插件
    TOSQuickEntrieTypeTicketPlugin  =   9,
    /// 转人工事件
    TOSQuickEntrieTypeArtificial    =   10,
    /// 自定义事件
    TOSQuickEntrieTypeCustom        =   11,
    
};


/// 获取的快捷入口配置
@interface TOSQuickEntrieModel : TIMLibBaseModel

/// 名称
@property (nonatomic, copy) NSString                * name;

/// 内容
@property (nonatomic, copy) NSString                * content;

/// 快捷入口类型，1：链接外跳，2：满意度评价，3：结束会话，4：消息发送  8、订单卡片 9 工单插件 10 转人工事件 11 自定义事件
@property (nonatomic, assign) TOSQuickEntrieType                type;

/// 链接 type=1 外部链接
@property (nonatomic, copy) NSString                * url;

/// 请求参数
@property (nonatomic, copy) NSString                * param;

/// 请求方式
@property (nonatomic, copy) NSString                * requestMethod;

/// token鉴权信息
@property (nonatomic, copy) NSString                * token;

/// 快捷入口人工阶段启用
@property (nonatomic, assign) BOOL                quickEntryAgentEnable;

/// 快捷入口机器人阶段启用
@property (nonatomic, assign) BOOL                quickEntryRobotEnable;

/// 快捷入口机器人配置
@property (nonatomic, strong) NSArray                * botIds;

/// 参数类型
@property (nonatomic, copy) NSString                * contentType;

/// 是否支持搜索
@property (nonatomic, assign) BOOL                searchable;

/// 搜索框引导文案
@property (nonatomic, copy) NSString                * searchPlaceholder;

/// 工单插件配置
@property (nonatomic, strong) NSDictionary                * quickEntryTicketPlugin;

/// 是否开启分类
@property (nonatomic, strong) NSNumber               * categoryDisplay;

/// 分类列表
@property (nonatomic, strong) NSArray                * categoryList;

@end


/// 更多item的事件类型枚举
typedef NS_ENUM(NSInteger, TOSToolbarItemEventType) {
    /// 相册
    TOSToolbarItemEventTypePhoto            =   1,
    /// 拍摄
    TOSToolbarItemEventTypeTakePicture      =   2,
    /// 文件
    TOSToolbarItemEventTypeFile             =   3,
    /// 满意度
    TOSToolbarItemEventTypeSatisfaction     =   4,
    /// 关闭会话
    TOSToolbarItemEventTypeCloseChat        =   5,
    /// 链接外跳
    TOSToolbarItemEventTypeLink             =   6,
    /// 订单卡片
    TOSToolbarItemEventTypeOrderCard        =   10,
    /// 转人工
    TOSToolbarItemEventTypeArtificial       =   11,
    /// 消息发送
    TOSToolbarItemEventTypeSendText         =   12,
    /// 自定义
    TOSToolbarItemEventTypeCustom           =   13,
    
};

/// 获取的更多面板的配置
@interface TOSToolbarItemModel : TIMLibBaseModel

/// 名称
@property (nonatomic, copy) NSString                * name;

/// 事件类型：1：拍照/图片，2：拍摄，3：文件，4：满意度评价，5：结束会话，6：链接外跳  10:订单卡片 11 转人工 12 消息发送 13 自定义
@property (nonatomic, assign) TOSToolbarItemEventType                type;

/// 链接 type=1 外部链接
@property (nonatomic, copy) NSString                * url;

/// 图标url
@property (nonatomic, copy) NSString                * iconUrl;

/// 区分人工/机器人阶段启用  全关闭为：0 人工关、机器人开 ：1，人工开、机器人关 ：2。人工、机器人全开：3
@property (nonatomic, assign) NSInteger                stageEnable;

/// 请求参数
@property (nonatomic, copy) NSString                * param;

/// 请求方式
@property (nonatomic, copy) NSString                * requestMethod;

/// token鉴权
@property (nonatomic, copy) NSString                * token;

/// 是否支持搜索
@property (nonatomic, assign) BOOL                searchable;

/// 搜索框引导文案
@property (nonatomic, copy) NSString                * searchPlaceholder;

/// 参数类型
@property (nonatomic, copy) NSString                * contentType;

/// iOS文件来源 1、当前app 2、Apple"文件”app
@property (nonatomic, assign) NSInteger                fileSource;

/// 分类开关
@property (nonatomic, strong) NSNumber                * categoryDisplay;

/// 分类列表数据
@property (nonatomic, strong) NSArray                * categoryList;

@end


NS_ASSUME_NONNULL_END
