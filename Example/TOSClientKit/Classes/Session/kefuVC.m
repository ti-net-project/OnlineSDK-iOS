//
//  kefuVC.m
//  TIMClientKitDemo
//
//  Created by apple on 2021/8/20.
//  Copyright © 2021 YanBo. All rights reserved.
//

#import "kefuVC.h"
#import "ChatInfoViewController.h"
//#import "TIMConstants.h"
#import "MainTabBarController.h"
#import "DomainNameSave.h"
#import "LoginModel.h"
#import "TIMBaseNavigationController.h"
#import "customTableViewCell.h"
#import "CustomFileTableViewCell.h"
//#import "WHToast.h"

@interface kefuVC ()<UIAlertViewDelegate>

@property (nonatomic, strong) UILabel                * unReadInfoLabel;

@property (nonatomic, assign) BOOL                load;

@end

@implementation kefuVC

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
}

- (void)setupIMStyle {
    TOSKitCustomInfo *manager = [TOSKitCustomInfo shareCustomInfo];
    manager.headWidth = 40.0;
    manager.portrait_cornerRadius = 20.0;
    manager.headMargin = 20.0;
    manager.headToBubble = 10.0;
    manager.cellMargin = 14.0;
    manager.bubblePadding = 12.0;
    manager.senderBubble_cornerRadius = 10.f;
    manager.receiveBubble_cornerRadius = 10.f;
    manager.chat_backGround = TOSHexColor(0xFFFFFF);
    manager.Chat_time_textColor = TOSHexColor(0x656277);
    manager.senderBubble_backGround = TOSHexColor(0xE8E1FF);
    manager.receiveBubble_backGround = TOSHexColor(0xF2F2F7);
    manager.receiveText_Color = TOSHexColor(0x141223);
    manager.senderText_Color = TOSHexColor(0x141223);
    manager.Chat_time_textColor = TOSHexColor(0x656277);
    manager.bubbleMaxWidth = [UIScreen mainScreen].bounds.size.width - 140;
    manager.chatBubble_CornerType = BubbleCornerTypeAll;
    
    
    
    manager.chatMessage_tosRobotCombination_titleFont = [UIFont systemFontOfSize:16.f];
    manager.chatMessage_tosRobotCombination_titleColor = TOSHexColor(0x141223);
    manager.chatMessage_tosRobotCombination_segmentUnselectedTextColor = TOSHexColor(0x141223);
    manager.chatMessage_tosRobotCombination_hotSubIssueTitleFont = [UIFont systemFontOfSize:16.f];
    manager.chatMessage_tosRobotCombination_hotSubIssueTitleColor = TOSHexColor(0x824DFC);
    manager.chatMessage_tosRobotCombination_hotSubIssusSpacing = 10.f;
    
    manager.chatMessage_system_edgeInsets = UIEdgeInsetsMake(5, 60, 10, 30);
    manager.chatMessage_system_backgroundColor = [UIColor colorWithHexString:@"#a6ffff"];
    manager.chatMessage_system_labelTextEdgeInsets = UIEdgeInsetsMake(10, 30, 10, 10);
    manager.chatMessage_system_cornerRadius = 16.0;
    manager.chatMessage_system_textColor = TOSHexColor(0x595959);
    manager.chatMessage_system_center = YES;
    
    manager.chatBox_topLineHeight = 0.5f;
    manager.chatBox_Item_Width = 28.0;
    manager.lastMessage_spacing = 16.0f;
    manager.nickNameToBubbleSpacing = 6.0f;
    manager.chatBubble_CornerType = BubbleCornerTypeNoRightTop;
    
    manager.chatBox_Height = 60.0;
    manager.chatBox_textView_cornerRadius = 18.0;
    manager.chatBox_textView_placeholderMargin = 16.0;
    manager.chatBox_textView_textContainerInset = UIEdgeInsetsMake(8, 10, 8, 10);
    manager.chatBox_itemLeftPadding = 20.0;
    manager.chatBox_itemRightPadding = 20.0;
    manager.chatBox_itemSpacing = 16.0;
    manager.chatBox_textView_maxRows = 8;
    manager.ChatBox_textview_placeholder = @"输入您的问题";
    manager.chatBox_itemBottomSpacing = 16.0;
    manager.chatBox_talkText = @"按住说话";
    manager.chatBox_talkHighlightedText = @"松开发送";
    manager.chatBox_talk_borderWidth = 0.5;
    
    /// 表情面板的删除按钮
    manager.chatBox_emotion_deleteButton_cornerRadius = 18.0f;
    manager.chatBox_emotion_deleteButtonSize = CGSizeMake(68, 36);
    manager.chatBox_emotion_deleteButtonOffset = CGPointMake(30, 0);
    
    /// 创建按钮的阴影Layer
    CALayer *shadowLayer = [CALayer layer];
    shadowLayer.shadowColor = [UIColor blackColor].CGColor;
    shadowLayer.shadowOpacity = 0.1;
    shadowLayer.shadowOffset = CGSizeMake(0, 4);
    shadowLayer.shadowRadius = 4.0;
    manager.chatBox_emotion_deleteCALayer = shadowLayer;
    
    /// 表情面板的发送按钮 chatbox
    manager.chatBox_emotion_sendButton_text = @"发送";
    manager.chatBox_emotion_sendButtonSize = CGSizeMake(68, 36);
    manager.chatBox_emotion_sendButton_cornerRadius = 18.0f;
    manager.chatBox_emotion_sendButtonMargins = UIEdgeInsetsMake(0, 0, 8, 20);
    manager.chatBox_emotion_sendCALayer = shadowLayer;
    
    manager.chat_send_voiceImageToBubbleTop = 10.f;
    manager.chat_send_voiceLabelToBubbleTop = 10.f;
    manager.chatBox_more_topLineHeight = 0.5f;
    manager.chatBox_emotion_topLineHeight = 0.5f;
    manager.chatBox_more_itemCornerRadius = 28.0f;
    
    TOSKitExtendBoardItemModel *photosModel = [[TOSKitExtendBoardItemModel alloc] init];
    photosModel.type = TOSChatBoxExtendBoardTypePhotos;    //除自定义类型外，其他类型不填即为默认UI
    TOSKitExtendBoardItemModel *pictureModel = [[TOSKitExtendBoardItemModel alloc] init];
    pictureModel.type = TOSChatBoxExtendBoardTypeTakePicture;
    pictureModel.title = @"拍照";
    [TOSKitChatBoxExtendBoard shareChatBoxExtendBoard].allItems = @[pictureModel, photosModel];
    
    manager.resendButtonSize = CGSizeMake(20, 20);
    manager.resendToBubblePadding = 10.0;
    manager.satisfactionViewShowModel = SatisfactionShowModelFirstTimePopup;
    manager.ChatBox_voiceButton_enable = YES;
    manager.robotHiddenVoice = NO;
}

- (void)configTOSUI {
    [TOSKitCustomInfo shareCustomInfo].senderBubble_backGround = [UIColor whiteColor];// HQBaseConfig.shareInstance.themeColor;
    [TOSKitCustomInfo shareCustomInfo].senderBubble_cornerRadius = 8;
    [TOSKitCustomInfo shareCustomInfo].receiveText_Color = TOSHexColor(0x010B16);
    [TOSKitCustomInfo shareCustomInfo].senderText_Color = TOSHexColor(0x010B16);//[UIColor whiteColor];
    [TOSKitCustomInfo shareCustomInfo].CommodityCardDetails_title_sender_textColor = TOSHexColor(0x010B16);
    [TOSKitCustomInfo shareCustomInfo].CommodityCardDetails_title_receive_textColor = TOSHexColor(0x010B16);
    [TOSKitCustomInfo shareCustomInfo].CommodityCardDetails_price_sender_textColor = TOSHexColor(0xFF1414);
    [TOSKitCustomInfo shareCustomInfo].CommodityCardDetails_price_receive_textColor = TOSHexColor(0xFF1414);
//    [TOSKitCustomInfo shareCustomInfo].ChatBox_voiceButton_enable = YES;
    [TOSKitCustomInfo shareCustomInfo].ChatBox_textview_placeholder = @"输入消息…";
    [TOSKitCustomInfo shareCustomInfo].Chat_tosRobotName_show = YES;
    [TOSKitCustomInfo shareCustomInfo].Chat_tosRobotName_enable = YES;
    [TOSKitCustomInfo shareCustomInfo].Chat_visitorName_enable = NO;
    [TOSKitCustomInfo shareCustomInfo].Chat_visitorName_show = NO;
    [TOSKitCustomInfo shareCustomInfo].portrait_cornerRadius = 20;
    [TOSKitCustomInfo shareCustomInfo].chatBox_talk_backgroundColor = [UIColor blueColor];
    
    
    [TOSKitCustomInfo shareCustomInfo].titleName = @"客服";
    [TOSKitCustomInfo shareCustomInfo].appName = @"客服SDK";
    //
    TOSClientKitCommodityCardOption *option = [[TOSClientKitCommodityCardOption alloc] init];
    option.subTitle = @"华为P40麒麟990 5G SoC芯片";
    option.title = @"";
    option.descriptions = @"这是商品描述，啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦";
    option.price = @"￥100.99";
    option.time = @"";
    
    option.img = @"https://img1.baidu.com/it/u=1963848283,2056721126&fm=253&fmt=auto&app=120&f=JPEG?w=500&h=500";
    option.status = @"已到货";
    option.extraInfo = @[@{@"name": @"订单号", @"value": @"1234567890"},
                         @{@"name": @"产品类型", @"value": @"电子产品"},
                         @{@"name": @"师傅"   , @"value": @"金师傅"},
                         @{@"name": @"服务地区", @"value": @"北京市"},
                         @{@"name": @"服务"   , @"value": @"满意"},
                         @{@"name": @"师傅电话", @"value": @"12345678900"},
                         @{@"name": @"订单状态", @"value": @"已完成"},
    ];
    option.url = @"https://hellojoy.jd.com/";
    option.title = @"华为P40";
    option.subUrl = @"https://p4psearch.1688.com/";
    option.buttonText = @"发送";
    option.extraData = @[@{@"name": @"订单状态", @"value": @"1234324"},];
    
    [TOSKitCustomInfo shareCustomInfo].commodityCardOption = option;
}

- (void)satisfactionModelSwitchValueChanged:(UISwitch *)sender {
    if (sender.on) {
        [TOSKitCustomInfo shareCustomInfo].satisfactionViewShowModel = SatisfactionShowModelEveryTimePopup;
    } else {
        [TOSKitCustomInfo shareCustomInfo].satisfactionViewShowModel = SatisfactionShowModelFirstTimePopup;
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.edgesForExtendedLayout = UIRectEdgeBottom;
    self.extendedLayoutIncludesOpaqueBars = YES;
    
    [self configTOSUI];
    [self setupIMStyle];
    
    if (@available(iOS 13.0, *)) {
        self.overrideUserInterfaceStyle = UIUserInterfaceStyleLight;    //关闭暗黑模式
    }
    self.modalPresentationStyle = UIModalPresentationFullScreen;
    //              👇
    /* 1. 在baseVC设置如下代码，更改导航栏属性
     * 2. 当前页面隐藏 或者 显示导航栏 都是在viewWillAppear方法里面
     *    调用 [self.navigationController setNavigationBarHidden: YesOrNo animated: animated];
     * 3. 不要在viewWillDisappear方法里面更改导航栏隐藏属性
     */
    self.navigationController.navigationBar.translucent = NO;
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self.view.subviews enumerateObjectsWithOptions:NSEnumerationReverse usingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj isKindOfClass:[UITableView class]]) {
            UITableView * tab = (UITableView*)obj;
            tab.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }
    }];
    /// 获取实时的未读消息数和最后一条消息
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(unreadMessage:) name:KTOSClientLibLastMessageReceivedNotification object:nil];
    
    NSString * mainUniqueId = [[OnlineDataSave shareOnlineDataSave] getMainUniqueId];
    NSLog(@"当前客服的mainUniqueId：%@   [[OnlineDataSave shareOnlineDataSave] getVisitorId]: %@", mainUniqueId, [[OnlineDataSave shareOnlineDataSave] getVisitorId]);
    /// 获取未读数(离线期间的)
    [[TOSClientKit sharedTOSKit] getUnreadMessage:^(NSString * _Nonnull lastMessage, NSInteger unreadCount) {
        NSLog(@"+++++未读数：%ld, 最后一条消息：%@", unreadCount, lastMessage);
        self.unReadInfoLabel.text = [NSString stringWithFormat:@"未读数：%ld %@", unreadCount, lastMessage];
    } withError:^(NSString * _Nonnull errorStr) {
        
    }];
    
    [self setupView];
}

- (void)unreadMessage:(NSNotification *)notification {
    NSDictionary * dict = [notification object];
    NSNumber * unreadCount = [NSNumber numberWithInt:[dict[@"unReadCount"] intValue]];
    NSLog(@"未读消息：%@ ,       最后一条消息：%@", unreadCount.stringValue, dict[@"lastMessage"]);
    self.unReadInfoLabel.text = [NSString stringWithFormat:@"未读数：%@ %@", unreadCount.stringValue, dict[@"lastMessage"]];
}



-(void)setupView{
    
    self.title = [NSString stringWithFormat:@"客户界面(SDK版本号：v%@)",[TOSClientKit getSDKVersion]];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:self.unReadInfoLabel];
    
    
    UIButton*kefuBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    kefuBtn.backgroundColor = TOSHexColor(0xFF7C65);
    kefuBtn.frame = CGRectMake(kWindowWidth-kWindowWidth/3, 50, kWindowWidth/3, 40.f);
    kefuBtn.titleLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:15.f];
    [kefuBtn setTitle:@"咨询客服1" forState:UIControlStateNormal];
    [kefuBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [kefuBtn addTarget:self action:@selector(kefuAction) forControlEvents:UIControlEventTouchDown];
    kefuBtn.layer.masksToBounds = YES;
    kefuBtn.layer.cornerRadius = 5.f;
    [self.view addSubview:kefuBtn];
    
    // 无快捷入口
    UIButton*kefuBtn1 = [UIButton buttonWithType:UIButtonTypeCustom];
    kefuBtn1.backgroundColor = TOSHexColor(0xFF7C65);
    kefuBtn1.frame = CGRectMake(kWindowWidth-kWindowWidth/3, kefuBtn.bottom_sd+10.f, kWindowWidth/3, 40.f);
    kefuBtn1.titleLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:15.f];
    [kefuBtn1 setTitle:@"咨询客服2" forState:UIControlStateNormal];
    [kefuBtn1 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [kefuBtn1 addTarget:self action:@selector(kefuAction1) forControlEvents:UIControlEventTouchDown];
    kefuBtn1.layer.masksToBounds = YES;
    kefuBtn1.layer.cornerRadius = 5.f;
    [self.view addSubview:kefuBtn1];
}

- (void)rightAction:(UIBarButtonItem *)sender {
    kefuVC *vc = [[kefuVC alloc] init];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
    vc.hidesBottomBarWhenPushed = NO;
}

-(void)kefuAction{
    [TOSKitCustomInfo shareCustomInfo].quickEntryBottom_backgroundColor = TOSHexColor(0xEFF0F3);
    [TOSKitCustomInfo shareCustomInfo].quickEntryItem_backgroundColor = TOSHexColor(0xFFFFFF);
    
    NSLog(@"[TOSKitCustomInfo shareCustomInfo].commodityCardOption.extraData : %@", [TOSKitCustomInfo shareCustomInfo].commodityCardOption.extraData);
    LoginModel *model = [LoginModel loginModel];
    TOSConnectOption * connectOption = [[TOSConnectOption alloc] initWithOption:model.userId?:@""
                                                                       nickname:model.nickname?:@""
                                                                        headUrl:model.headerUrl?:@""
                                                                         mobile:model.phoneNumber?:@""
                                                                  advanceParams:model.advanceParams?:@{}];
    connectOption.externalId = model.externalId;
    connectOption.customerFields = @{
        @"autoUpdate" : @(1),
        @"电话" : @"010-12345678",
        @"性别" : @(1),
    };
    
    [[TOSClientKit sharedTOSKit] connect:connectOption success:^{
        
        self.load = YES;
        
        [TOSKitCustomInfo shareCustomInfo].receiveBubble_backGround = [UIColor whiteColor];
        [TOSKitCustomInfo shareCustomInfo].chat_backGround = TOSHexColor(0xEFF0F3);
        [TOSKitCustomInfo shareCustomInfo].isRequiredUnHelpfulContent = YES;
        [TOSKitCustomInfo shareCustomInfo].isShowUnHelpfulContent = YES;
        [TOSKitCustomInfo shareCustomInfo].setUnHelpfulTagList = @[@"da", @"dsad"];
        [TOSKitCustomInfo shareCustomInfo].isOpenHelpfulFeature = YES;
        
        //创建会话成功，进入聊天页面
        ChatInfoViewController *chatVC = [[ChatInfoViewController alloc] init];
        chatVC.titleName = @"客服";
        chatVC.appName = @"客服SDK";
        chatVC.setUpQuickEntryBool = self.setUpQuickEntryBool;
        self.hidesBottomBarWhenPushed  = YES;
        [self.navigationController pushViewController:chatVC animated:YES];
    } error:^(TIMConnectErrorCode errCode, NSString * _Nonnull errorDes) {
        NSLog(@"errorDes === %@",errorDes);
    } tokenIncorrect:^{
        NSLog(@"tokenIncorrect");
    }];
}

-(void)kefuAction1{
//    /// 文本框的内边距
    [TOSKitCustomInfo shareCustomInfo].chatBox_textView_textContainerInset = UIEdgeInsetsMake(10, 10, 10, 10);
    [TOSKitCustomInfo shareCustomInfo].chatBox_textView_backgroundColor = UIColor.whiteColor;

    /// 文本框的默认提示内容距离输入框左边的距离
    [TOSKitCustomInfo shareCustomInfo].chatBox_textView_placeholderMargin = 16.0f;
    [TOSKitCustomInfo shareCustomInfo].chatBox_textView_cornerRadius = 8.0f;
//    [TOSKitCustomInfo shareCustomInfo].chatBox_itemBottomSpacing = 4.0;
    [TOSKitCustomInfo shareCustomInfo].chatBox_talkText = @"按住 说话";
    [TOSKitCustomInfo shareCustomInfo].chatBox_talkHighlightedText = @"松开 结束";
    [TOSKitCustomInfo shareCustomInfo].chatBox_talkFont = [UIFont boldSystemFontOfSize:16.0f];
    /**  发送按钮的自定义     **/
    /// 关闭表情按钮和更多按钮
    [TOSKitCustomInfo shareCustomInfo].chatBox_emotionButton_enable = YES;
    [TOSKitCustomInfo shareCustomInfo].chatBox_moreButton_enable = YES;
    [TOSKitCustomInfo shareCustomInfo].resendButtonSize = CGSizeMake(20.0f, 20.0f);
    [TOSKitCustomInfo shareCustomInfo].bubbleMaxWidth = kWindowWidth - 150;
    [TOSKitCustomInfo shareCustomInfo].resendToBubblePadding = 4.0f;
    [TOSKitCustomInfo shareCustomInfo].bubblePadding = 10.0;
    // ChatLocationMessage
    [[TOSKitCustomInfo shareCustomInfo].customCellRegister removeAllObjects];
    [TOSKitCustomInfo shareCustomInfo].chatBox_textView_maxRows = 5;
    [TOSKitCustomInfo shareCustomInfo].chatBox_talk_borderWidth = 0.5f;
    [TOSKitCustomInfo shareCustomInfo].chatBox_talk_borderColor = [UIColor colorWithHexString:@"E8E8E8"];
    [TOSKitCustomInfo shareCustomInfo].chat_send_voiceImageToBubbleRightX = 22.0;
    [TOSKitCustomInfo shareCustomInfo].chat_send_voiceImageToBubbleTop = 10.0f;
    [TOSKitCustomInfo shareCustomInfo].chat_send_voiceLabelToBubbleTop = 10.0f;
    [TOSKitCustomInfo shareCustomInfo].chatBox_talk_backgroundColor = UIColor.clearColor;
    [TOSKitCustomInfo shareCustomInfo].chatBox_talk_backgroundHighlightedColor = [UIColor colorWithHexString:@"#B2B2B2"];
    [TOSKitCustomInfo shareCustomInfo].chatBox_talk_fontHighlightedColor = [UIColor colorWithHexString:@"#434343"];
    /// 语音录制HUD
    [TOSKitCustomInfo shareCustomInfo].chatBox_voiceRecordView = nil;
    /// 语音取消录制HUD
    [TOSKitCustomInfo shareCustomInfo].chatBox_voiceCancelRecordView = nil;
    /// 语音录制时间太短HUD
    [TOSKitCustomInfo shareCustomInfo].chatBox_voiceRecordSoShortView = nil;

    [TOSKitCustomInfo shareCustomInfo].chatBox_emotion_deleteButton_cornerRadius = 4.0f;
    [TOSKitCustomInfo shareCustomInfo].chatBox_emotion_deleteButtonSize = CGSizeMake(49, 38);
    [TOSKitCustomInfo shareCustomInfo].chatBox_emotion_deleteButtonOffset = CGPointZero;
    [TOSKitCustomInfo shareCustomInfo].chatBox_emotion_deleteButtonBackGroundColor = UIColor.whiteColor;
    /// 创建按钮的阴影Layer
    CALayer *shadowLayer = [CALayer layer];
    shadowLayer.shadowColor = [UIColor blackColor].CGColor;
    shadowLayer.shadowOpacity = 0.1;
    shadowLayer.shadowOffset = CGSizeMake(0, 4);
    shadowLayer.shadowRadius = 4.0;
    [TOSKitCustomInfo shareCustomInfo].chatBox_emotion_deleteCALayer = shadowLayer;
    /// 创建按钮的阴影Layer
    CALayer *sendshadowLayer = [CALayer layer];
    sendshadowLayer.shadowColor = [UIColor clearColor].CGColor;
    sendshadowLayer.shadowOffset = CGSizeMake(2, 5);
    sendshadowLayer.shadowOpacity = 0.5;
    sendshadowLayer.shadowRadius = 19.0;
    [TOSKitCustomInfo shareCustomInfo].chatBox_emotion_sendCALayer = shadowLayer;
    [TOSKitCustomInfo shareCustomInfo].chatBox_emotion_sendButton_text = @"发送";
    [TOSKitCustomInfo shareCustomInfo].chatBox_emotion_sendButtonSize = CGSizeMake(49, 38);
    [TOSKitCustomInfo shareCustomInfo].chatBox_emotion_sendButton_textColor = UIColor.whiteColor;
    [TOSKitCustomInfo shareCustomInfo].chatBox_emotion_sendButton_cornerRadius = 4.0f;
    [TOSKitCustomInfo shareCustomInfo].chatBox_emotion_sendButtonBackGroundColor = [UIColor colorWithHexString:@"#4385FF"];
    [TOSKitCustomInfo shareCustomInfo].chatBox_emotion_sendButtonMargins = UIEdgeInsetsMake(0, 0, 16, 16);

    [TOSKitCustomInfo shareCustomInfo].chatBox_topLineHeight = 1.0f;
    [TOSKitCustomInfo shareCustomInfo].ChatBox_lineColor = [UIColor colorWithHexString:@"E8E8E8"];
    [TOSKitCustomInfo shareCustomInfo].chatBox_textView_borderWidth = 0.5f;
    [TOSKitCustomInfo shareCustomInfo].chatBox_textView_borderColor = UIColor.clearColor;
    [TOSKitCustomInfo shareCustomInfo].chatBox_Item_Width = 28;
    [TOSKitCustomInfo shareCustomInfo].lastMessage_spacing = 0.0f;
    [TOSKitCustomInfo shareCustomInfo].cellMargin = 10.0f;
    [TOSKitCustomInfo shareCustomInfo].nickNameToBubbleSpacing = 0.0f;
    [TOSKitCustomInfo shareCustomInfo].chatBubble_CornerType = BubbleCornerTypeAll;

    [TOSKitCustomInfo shareCustomInfo].chatMessage_system_edgeInsets =  UIEdgeInsetsMake(5, 20, 5, 20);
    [TOSKitCustomInfo shareCustomInfo].chatMessage_system_backgroundColor = [[UIColor colorWithHexString:@"#FFFFFF"] colorWithAlphaComponent:0.65];

    [TOSKitCustomInfo shareCustomInfo].ChatBox_backGroundColor = [UIColor colorWithHexString:@"#F1F1F8"];
    [TOSKitCustomInfo shareCustomInfo].senderBubble_cornerRadius = 8.0f;
    [TOSKitCustomInfo shareCustomInfo].receiveBubble_cornerRadius = 8.0f;
    [TOSKitCustomInfo shareCustomInfo].chatBox_more_topLineColor = [UIColor colorWithHexString:@"E8E8E8"];
    [TOSKitCustomInfo shareCustomInfo].chatBox_more_topLineHeight = 1.0f;
    [TOSKitCustomInfo shareCustomInfo].chatBox_more_itemCornerRadius = 12.0f;
//    [TOSKitCustomInfo shareCustomInfo].chatBox_more_itemBackgroundColor = UIColor.redColor;
    [TOSKitCustomInfo shareCustomInfo].chatBox_emotion_backgroundColor = [UIColor colorWithHexString:@"#F3F6F9"];
    [TOSKitCustomInfo shareCustomInfo].chatBox_more_backgroundColor = TOSColor(237, 237, 246);
    [TOSKitCustomInfo shareCustomInfo].chatBox_more_itemTextColor = [UIColor colorWithHexString:@"595959"];
    [TOSKitCustomInfo shareCustomInfo].chatBox_emotion_topLineColor = [UIColor colorWithHexString:@"E8E8E8"];
    [TOSKitCustomInfo shareCustomInfo].chatBox_emotion_topLineHeight = 1.0f;

    [TOSKitCustomInfo shareCustomInfo].chatBox_Height = 56.0f;
    [TOSKitCustomInfo shareCustomInfo].chatBox_emotion_functionItemDisplayed = NO;
    
    [TOSKitCustomInfo shareCustomInfo].Chat_tosRobotName_show = YES;
    [TOSKitCustomInfo shareCustomInfo].Chat_tosRobotName_enable = YES;
    [TOSKitCustomInfo shareCustomInfo].Chat_visitorName_enable = NO;
    [TOSKitCustomInfo shareCustomInfo].Chat_visitorName_show = NO;
    
    [TOSKitCustomInfo shareCustomInfo].chatMessage_visitorName_font = [UIFont boldSystemFontOfSize:12.0];
    [TOSKitCustomInfo shareCustomInfo].chatMessage_visitorName_textColor = [UIColor colorWithHexString:@"#595959"];
    [TOSKitCustomInfo shareCustomInfo].chatMessage_tosRobotName_font = [UIFont systemFontOfSize:12.0];
    [TOSKitCustomInfo shareCustomInfo].chatMessage_tosRobotName_textColor = [UIColor colorWithHexString:@"#595959"];
    
    TOSKitCustomInfo.shareCustomInfo.chatMessage_tosRobotCombination_titleFont = [UIFont fontWithName:@"PingFangSC-Regular" size:16.0];
    TOSKitCustomInfo.shareCustomInfo.chatMessage_tosRobotCombination_subTitleFont = [UIFont fontWithName:@"PingFangSC-Regular" size:16.0];
    TOSKitCustomInfo.shareCustomInfo.chatMessage_tosRobotCombination_hotSubIssueTitleFont = [UIFont fontWithName:@"PingFangSC-Regular" size:14.f];
    TOSKitCustomInfo.shareCustomInfo.chatMessage_tosRobotCombination_hotSubIssueTitleColor = [UIColor colorWithHexString:@"#262626"];
    TOSKitCustomInfo.shareCustomInfo.chatMessage_tosRobotCombination_segmentTextColor = [UIColor colorWithHexString:@"#4385FF"];
    TOSKitCustomInfo.shareCustomInfo.chatMessage_tosRobotCombination_segmentLineColor = [[UIColor colorWithHexString:@"#000000"] colorWithAlphaComponent:0.04f];
    TOSKitCustomInfo.shareCustomInfo.chatMessage_tosRobotCombination_showRefreshTitleColor = [UIColor colorWithHexString:@"#4385FF"];
    TOSKitCustomInfo.shareCustomInfo.chatMessage_tosRobotCombination_showRefreshTitle = @"换一换";
    TOSKitCustomInfo.shareCustomInfo.chatMessage_tosRobotCombination_showRefreshNumber = 5;
    TOSKitCustomInfo.shareCustomInfo.chatMessage_tosRobotCombination_showRefreshTitleFont = [UIFont fontWithName:@"PingFangSC-Regular" size:12.f];
    TOSKitCustomInfo.shareCustomInfo.chatMessage_tosRobotCombination_segmentFont = [UIFont fontWithName:@"PingFangSC-Regular" size:14.0f];
    
    [TOSKitCustomInfo shareCustomInfo].commodityCardOption = nil;
    //创建会话成功，进入聊天页面
    ChatInfoViewController *chatVC = [[ChatInfoViewController alloc] init];
    chatVC.titleName = @"客服";
    chatVC.appName = @"客服SDK";
    chatVC.rewriteBack = YES;
    self.hidesBottomBarWhenPushed  = YES;
    [self.navigationController pushViewController:chatVC animated:YES];
    
    LoginModel *model = [LoginModel loginModel];
    NSLog(@"model.userId =========== %@",model.userId);
    TOSConnectOption * connectOption = [[TOSConnectOption alloc] initWithOption:model.userId?:@""
                                                                       nickname:model.nickname?:@""
                                                                        headUrl:model.headerUrl?:@""
                                                                         mobile:model.phoneNumber?:@""
                                                                  advanceParams:model.advanceParams?:@{}];
    connectOption.externalId = model.externalId;
    [[TOSClientKit sharedTOSKit] connect:connectOption success:^{
        
    } error:^(TIMConnectErrorCode errCode, NSString * _Nonnull errorDes) {
        NSLog(@"errorDes === %@",errorDes);
    } tokenIncorrect:^{
        NSLog(@"tokenIncorrect");
    }];
}

- (UILabel *)unReadInfoLabel {
    if (!_unReadInfoLabel) {
        _unReadInfoLabel = [[UILabel alloc] initWithFrame:(CGRectMake(0, self.view.centerY_sd - 25.f, self.view.bounds.size.width, 50))];
        _unReadInfoLabel.textAlignment = 1;
        _unReadInfoLabel.backgroundColor = UIColor.orangeColor;
        
    }
    return _unReadInfoLabel;
}
@end
