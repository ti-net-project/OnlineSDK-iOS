//
//  TOSKitCustomInfo.h
//  TOSClientKit
//
//  Created by 言 on 2022/7/1.
//  Copyright © 2022 YanBo. All rights reserved.
//

#import <TOSClientLib/TOSClientLib.h>

NS_ASSUME_NONNULL_BEGIN

@interface TOSKitCustomInfo : TIMLibBaseModel

+ (TOSKitCustomInfo *)shareCustomInfo;

/// 快速入口Item的圆角弧度
@property (nonatomic, assign) CGFloat quickEntryItem_cornerRadius;

/// 发送方气泡的颜色
@property (nonatomic, strong) UIColor *senderBubble_backGround;
/// 发送方气泡的圆角弧度
@property (nonatomic, assign) CGFloat senderBubble_cornerRadius;

/// 头像的圆角弧度
@property (nonatomic, assign) CGFloat portrait_cornerRadius;

/// 聊天背景颜色
@property (nonatomic, strong) UIColor *chat_backGround;

/// 快速入口Item的背景颜色
@property (nonatomic, strong) UIColor *quickEntryItem_backgroundColor;

/// 接收方气泡的颜色
@property (nonatomic, strong) UIColor *receiveBubble_backGround;
/// 接收方气泡的圆角弧度
@property (nonatomic, assign) CGFloat receiveBubble_cornerRadius;

/// 快速入口底部的背景颜色
@property (nonatomic, strong) UIColor *quickEntryBottom_backgroundColor;

/// 接收方字体颜色
@property (nonatomic, strong) UIColor *receiveText_Color;

/// 发送方字体颜色
@property (nonatomic, strong) UIColor *senderText_Color;

/// 聊天底部输入中的语音按钮控制
@property (nonatomic, assign) BOOL ChatBox_voiceButton_enable;

/// 聊天底部输入中文本输入框的暗文设置
@property (nonatomic, strong) NSString *ChatBox_textview_placeholder;

/// 聊天底部背景颜色
@property (nonatomic, strong) UIColor *ChatBox_backGroundColor;

/// 聊天底部中线条颜色
@property (nonatomic, strong) UIColor *ChatBox_lineColor;

/// 聊天中显示的时间字体颜色
@property (nonatomic, strong) UIColor *Chat_time_textColor;

/// 启用或关闭客服或机器人昵称的显示
@property (nonatomic, assign) BOOL Chat_tosRobotName_show;

/// 启用或关闭访客昵称的显示
@property (nonatomic, assign) BOOL Chat_visitorName_show;

/// 启用或关闭客服昵称(机器人昵称)UI区域的显示
@property (nonatomic, assign) BOOL Chat_tosRobotName_enable;

/// 启用或关闭访客昵称UI区域的显示
@property (nonatomic, assign) BOOL Chat_visitorName_enable;

/// 启用或关闭客服和机器人头像UI区域的显示
@property (nonatomic, assign) BOOL Chat_tosRobot_portrait_enable;

/// 启用或关闭访客头像UI区域的显示
@property (nonatomic, assign) BOOL Chat_visitor_portrait_enable;

/// 相册展示导航栏中的文字颜色
@property (nonatomic, strong) UIColor *imagePicker_barItemTextColor;

/// 相册展示导航栏中的背景颜色
@property (nonatomic, strong) UIColor *imagePicker_naviBgColor;

/// 吐司提示气泡背景颜色
@property (nonatomic, strong) UIColor *Toast_backGroundColor;

/// 吐司提示中文字颜色
@property (nonatomic, strong) UIColor *Toast_textColor;

/// 语音按钮中文字颜色
@property (nonatomic, strong) UIColor *VoiceButton_textColor;

/// 语音按钮中文字高亮颜色
@property (nonatomic, strong) UIColor *VoiceButton_highlight_textColor;

/// 商品卡片-待发送  发送按钮背景颜色
@property (nonatomic, strong) UIColor *CommodityCard_sendBtn_backgroundColor;

/// 商品卡片-待发送  发送按钮文字颜色
@property (nonatomic, strong) UIColor *CommodityCard_sendBtn_textColor;

/// 商品卡片-待发送  标题文字颜色
@property (nonatomic, strong) UIColor *CommodityCard_title_textColor;

/// 商品卡片-待发送  商品价格文字颜色
@property (nonatomic, strong) UIColor *CommodityCard_price_textColor;

/// 商品卡片-详情  订单号: xxx 文字颜色
@property (nonatomic, strong) UIColor *CommodityCardDetails_orderId_sender_textColor;
@property (nonatomic, strong) UIColor *CommodityCardDetails_orderId_receive_textColor;

/// 商品卡片-详情  时间文字颜色
@property (nonatomic, strong) UIColor *CommodityCardDetails_time_sender_textColor;
@property (nonatomic, strong) UIColor *CommodityCardDetails_time_receive_textColor;

/// 商品卡片-详情  标题文字颜色
@property (nonatomic, strong) UIColor *CommodityCardDetails_title_sender_textColor;
@property (nonatomic, strong) UIColor *CommodityCardDetails_title_receive_textColor;

/// 商品卡片-详情  商品描述文字颜色
@property (nonatomic, strong) UIColor *CommodityCardDetails_description_sender_textColor;
@property (nonatomic, strong) UIColor *CommodityCardDetails_description_receive_textColor;

/// 商品卡片-详情  商品价格文字颜色
@property (nonatomic, strong) UIColor *CommodityCardDetails_price_sender_textColor;
@property (nonatomic, strong) UIColor *CommodityCardDetails_price_receive_textColor;

/// 商品卡片-详情  到货状态:xxx 文字颜色
@property (nonatomic, strong) UIColor *CommodityCardDetails_transportStatus_sender_textColor;
@property (nonatomic, strong) UIColor *CommodityCardDetails_transportStatus_receive_textColor;

/// 设置聊天页面的标题名字
@property(nonatomic, copy) NSString *titleName;

/// 接入号名称
@property(nonatomic, copy) NSString *appName;

/// 快捷入口的数据
@property (nonatomic, strong) NSArray *quickEntryAllItems;

/// 商品卡片配置数据
@property (nonatomic, strong) TOSClientKitCommodityCardOption *commodityCardOption;



/// 头像的大小，图像是正方形只需要设置宽度就可以了  default：40
@property (nonatomic, assign) CGFloat                headWidth;

/// 头像距屏幕边缘的距离 default：10
@property (nonatomic, assign) CGFloat                headMargin;
/// 头像距离气泡的距离 default：8.0
@property (nonatomic, assign) CGFloat                headToBubble;

/// 每条消息的间距 default：10.0
@property (nonatomic, assign) CGFloat                cellMargin;

/// 气泡的内间距 default：10.0
@property (nonatomic, assign) CGFloat                bubblePadding;

/// 聊天底部输入中的表情按钮控制 default：YES
@property (nonatomic, assign) BOOL chatBox_emotionButton_enable;

/// 聊天底部输入中的更多按钮控制 default：YES
@property (nonatomic, assign) BOOL chatBox_moreButton_enable;

/// 聊天底部的整体高度 default：56.0
@property (nonatomic, assign) CGFloat                chatBox_Height;

/// 聊天底部文本框距上下方的间距 default: 8.0
@property (nonatomic, assign) CGFloat                chatBox_textView_topAndBottomMargin;

/// 聊天底部文本框的初始高度，只读属性，想要改变该值需要配合另外两个属性 （⚠️该值的计算公式是：chatBox_Height - chatBox_textView_topAndBottomMargin*2 得出）
@property (nonatomic, assign, readonly) CGFloat                chatBox_textView_height;

/// 聊天底部最左侧的item距左侧间距 default: 10.0
@property (nonatomic, assign) CGFloat                chatBox_itemLeftPadding;

/// 聊天底部最右侧的item距右侧间距 default: 10.0
@property (nonatomic, assign) CGFloat                chatBox_itemRightPadding;

/// 聊天底部每个item之间的间距 default: 10.0
@property (nonatomic, assign) CGFloat                chatBox_itemSpacing;

/// 聊天底部的输入框字体 default: [UIFont fontWithName:@"PingFangSC-Regular" size:16.0]
@property (nonatomic, strong) UIFont                * chatBox_textView_font;

/// 聊天底部的输入框内边距 default: UIEdgeInsetsMake(10, 10, 10, 10)
@property (nonatomic, assign) UIEdgeInsets                chatBox_textView_textContainerInset;
/// 聊天底部的输入框字体颜色 default：262626
@property (nonatomic, strong) UIColor                * chatBox_textView_textColor;

/// 聊天底部的输入框背景颜色 default：whiteColor
@property (nonatomic, strong) UIColor                * chatBox_textView_backgroundColor;

/// 聊天底部文本框的圆角值 default：8.0
@property (nonatomic, assign) CGFloat                chatBox_textView_cornerRadius;

/// 聊天底部文本框的最多显示行数 default：5
@property (nonatomic, assign) NSInteger                chatBox_textView_maxRows;

/// 默认提示文字距离输入框左边的距离 default: 10.0
@property (nonatomic, assign) CGFloat                chatBox_textView_placeholderMargin;
///// 聊天底部文本框的暗文文字 default: [UIFont fontWithName:@"PingFangSC-Regular" size:16.0]
//@property (nonatomic, strong) UIFont                * chatBox_textview_placeholderFont;

/// 聊天底部文本框的暗文的字体颜色 default: grayColor
@property (nonatomic, strong) UIColor                * chatBox_textview_placeholderTextColor;

/// 输入框右侧的发送按钮开关 default: NO (发送按钮设置为YES时，chatBox_emotionButton_enable和chatBox_moreButton_enable 值需要为NO，且chatBox_sendButton_enable为YES，才会显示发送按钮)
@property (nonatomic, assign) BOOL                chatBox_sendButton_enable;

/// 输入框右侧的发送按钮大小 defatult: 60 : chatBox_textView_height
@property (nonatomic, assign) CGSize                chatBox_sendButtonSize;

/// 输入框右侧的发送按钮 只需要设置按钮的内容，样式需要设置其他属性(chatBox_sendButtonSize/chatBox_sendButton_cornerRadius/chatBox_sendButton_borderColor/chatBox_sendButton_HighlightedColor)
@property (nonatomic, strong) UIButton                * chatBox_sendButton;

/// 输入框右侧的发送按钮的圆角 default: 10.0
@property (nonatomic, assign) CGFloat                chatBox_sendButton_cornerRadius;

/// 输入框右侧的发送按钮边框默认颜色，即输入框没有值时发送按钮的边框颜色 default: UIColor.grayColor
@property (nonatomic, strong) UIColor                * chatBox_sendButton_borderColor;

/// 输入框右侧的发送按钮高亮的颜色，即输入框有值时发送按钮的边框颜色 default: UIColor.blackColor
@property (nonatomic, strong) UIColor                * chatBox_sendButton_HighlightedColor;

/// 输入框右侧的发送按钮边框宽度 default: 1
@property (nonatomic, assign) CGFloat                chatBox_sendButton_borderWidth;

/// 重新发送按钮的大小 default: 20:20
@property (nonatomic, assign) CGSize                resendButtonSize;

/// 重新发送按钮，设置后会显示这个按钮，不需要设置大小，大小由 resendButtonSize 控制。default: 红色感叹号的图片样式
@property (nonatomic, strong) UIButton                * resendButton;

/// 重新发送按钮距离气泡的间距 default: 4.0
@property (nonatomic, assign) CGFloat                resendToBubblePadding;


/**
 自定义cell的注册事件
 要在页面加载前进行赋值，key：事件名，value：对应的cell。
 示例
 @{
    @"TypeEventQueue" :  [CustomTableViewCell class]
 }
 然后在页面实现- (UITableViewCell *)customTableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath withModel:(nonnull TIMMessageModel *)model;方法
 自定义的cell需要继承于 TOSChatCustomBaseTableViewCell 
 */
@property (nonatomic, strong) NSMutableDictionary                * customCellRegister;


@end

NS_ASSUME_NONNULL_END
