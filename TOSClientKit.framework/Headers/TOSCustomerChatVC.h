//
//  TOSCustomerChatVC.h
//  TIMClientKit
//
//  Created by apple on 2021/8/23.
//  Copyright © 2021 YanBo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <TOSClientKit/TOSBaseViewController.h>
#import <TOSClientLib/TOSClientKitCommodityCardOption.h>
#import <TOSClientKit/TOSKitExtendBoardItemModel.h>

//#import <TOSClientKit/TIMMessageModel.h>

@class TIMMessageModel;
NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, TinetClickTextMessageEventType) {
    TinetClickEventTypeUrl,
    TinetClickEventTypeOrderNumber,
    TinetClickEventTypePhone,
    TinetClickCommodityCard,
    TinetClickMiniProgramCard,
    TinetClickLogisticsCard,
};

//typedef NS_ENUM(NSUInteger, TinetChatStatusType) {
//    TinetChatStatusTypeOutline,   // 不在线或结束会话
//    TinetChatStatusTypeRobot,     // 机器人在线
//    TinetChatStatusTypeOnline,    // 客服在线
//};

@interface TOSCustomerChatVC : TOSBaseViewController

/// 标题名字
@property(nonatomic, copy) NSString *titleName;

/// 接入号名称
@property(nonatomic, copy) NSString *appName;

/// 快捷入口的数据
@property (nonatomic, strong) NSArray *quickEntryAllItems;

/// 商品卡片配置数据
@property (nonatomic, strong) TOSClientKitCommodityCardOption *commodityCardOption;

/// 自定义欢迎语
@property(nonatomic, copy) NSString *welcomsString;

/// 文本类型消息中关于链接、单号和手机号的相关点击回调
/// @param eventType 事件类型
/// @param userInfo 信息
- (void)tinet_textMessageClickAction:(TinetClickTextMessageEventType)eventType userInfo:(NSDictionary *)userInfo;

//此方法获取文件保存得到的文件路径
-(NSString*)saveFileMethed;


/// 快捷入口的点击事件    index    点击索引从0开始 （需要在子类实现这个方法）
- (void)quickEntryItemDidTouchIndex:(NSInteger)index;

/// 当前会话状态监听
- (void)chatStatusChanged:(TinetChatStatusType)status;

/// 扩展面板，自定义按钮事件 （需要在子类实现这个方法）
- (void)didClinkCustomExtendBoardItemAction:(TOSKitExtendBoardItemModel *)item;

/// 结束会话事件
- (void)closeViewEvent;

/// 自定义cell要实现这个方法，要在实现该方法前，配置 [TOSKitCustomInfo shareCustomInfo].customCellRegister
- (UITableViewCell *)customTableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath withModel:(TIMMessageModel *)model;


@end

NS_ASSUME_NONNULL_END
