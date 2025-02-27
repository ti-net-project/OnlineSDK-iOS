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

@property (nonatomic, strong) UISwitch *satisfactionModelSwitch;

@property (nonatomic, strong) UITextField *textField1;
@property (nonatomic, strong) UITextField *textField2;
@property (nonatomic, strong) UITextField *textField3;

@property (nonatomic, strong) UISwitch *setUpQuickEntry;

@property (nonatomic, strong) UISwitch *commentCountEnable;
@property (nonatomic, strong) UISwitch *visitorCreatedTicket;
@property (nonatomic, strong) UISwitch *noCommentCountHideQuickEntry;

/// 输入1/2/3/4，分别代表关闭、机器人、人工、机器人和人工，四种状态下的留言显示
@property (nonatomic, strong) UITextField *applicationStage;

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
    
//    manager.chatMessage_visitorText_font = [UIFont systemFontOfSize:18.f];
//    manager.chatMessage_tosRobotText_font = [UIFont systemFontOfSize:16.f];
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
//    manager.chatMessage_system_textFont = [UIFont systemFontOfSize:15.0];
//    manager.chatMessage_system_textAlignment = NSTextAlignmentLeft;
    
//    manager.chatMessage_system_textFont = [UIFont systemFontOfSize:20];
    
    manager.chatBox_topLineHeight = 0.5f;
//    manager.ChatBox_lineColor = [UIColor jdColorOptions:JDColor_Line100];
    manager.chatBox_Item_Width = 28.0;
    manager.lastMessage_spacing = 16.0f;
    manager.nickNameToBubbleSpacing = 6.0f;
    manager.chatBubble_CornerType = BubbleCornerTypeNoRightTop;
    
    manager.chatBox_Height = 60.0;
    manager.chatBox_textView_topAndBottomMargin = 12.0;
    manager.chatBox_textView_cornerRadius = 18.0;
    manager.chatBox_textView_placeholderMargin = 16.0;
//    manager.chatBox_textView_font = [UIFont jdSystemFontOfSize:14.0];
//    manager.chatBox_textView_textColor = [UIColor jdColorWithHexString:@"#141223"];
    manager.chatBox_textView_textContainerInset = UIEdgeInsetsMake(8, 10, 8, 10);
//    manager.chatBox_textView_backgroundColor = [UIColor jdColorOptions:JDColor_Text50];
    manager.chatBox_itemLeftPadding = 20.0;
    manager.chatBox_itemRightPadding = 20.0;
    manager.chatBox_itemSpacing = 16.0;
    manager.chatBox_textView_maxRows = 8;
//    manager.ChatBox_backGroundColor = [UIColor jdColorOptions:JDColor_Fill80];
    manager.ChatBox_textview_placeholder = @"输入您的问题";
//    manager.chatBox_textview_placeholderTextColor = [UIColor jdColorWithHexString:@"#B4B1C1"];
    manager.chatBox_itemBottomSpacing = 16.0;
    manager.chatBox_talkText = @"按住说话";
    manager.chatBox_talkHighlightedText = @"松开发送";
//    manager.chatBox_talkFont = [UIFont jdPingFangSCMediumOfSize:14.0];
//    manager.VoiceButton_textColor = [UIColor jdColorOptions:JDColor_Text900];
//    manager.chatBox_talk_fontHighlightedColor = [UIColor jdColorOptions:JDColor_Text900];
    manager.chatBox_talk_borderWidth = 0.5;
//    manager.chatBox_talk_backgroundColor = [UIColor jdColorOptions:JDColor_Fill50];
//    manager.chatBox_talk_backgroundHighlightedColor = [UIColor jdColorWithHexString:@"#D0CFD9"];
    
    /// 表情面板的删除按钮
    manager.chatBox_emotion_deleteButton_cornerRadius = 18.0f;
//    manager.chatBox_emotion_deleteButton_image = [UIImage imageFromBundleName:@"JDComIMChatAsset.bundle" imageName:@"jd_emoji_delete_normal"];
//    manager.chatBox_emotion_deleteButton_highlightedImage = [UIImage imageFromBundleName:@"JDComIMChatAsset.bundle" imageName:@"jd_emoji_delete_highlight"];
    manager.chatBox_emotion_deleteButtonSize = CGSizeMake(68, 36);
    manager.chatBox_emotion_deleteButtonOffset = CGPointMake(30, 0);
//    manager.chatBox_emotion_deleteButtonBackGroundColor = [UIColor jdColorOptions:JDColor_Fill50];
        
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
//    manager.chatBox_emotion_sendButton_textColor = [UIColor jdColorAlphaOptions:JDColorAlpha_White50];
//    manager.chatBox_emotion_sendButton_textHighlightedColor = [UIColor jdColorOptions:JDColor_Text50];
    manager.chatBox_emotion_sendButton_cornerRadius = 18.0f;
//    manager.chatBox_emotion_sendButtonBackGroundColor = [UIColor jdColorOptions:JDColor_Purple400];
    manager.chatBox_emotion_sendButtonMargins = UIEdgeInsetsMake(0, 0, 8, 20);
    manager.chatBox_emotion_sendCALayer = shadowLayer;
    
    manager.chat_send_voiceImageToBubbleTop = 10.f;
    manager.chat_send_voiceLabelToBubbleTop = 10.f;
//    manager.chatBox_more_topLineColor = [UIColor jdColorOptions:JDColor_Line100];
    manager.chatBox_more_topLineHeight = 0.5f;
//    manager.chatBox_emotion_topLineColor = [UIColor jdColorOptions:JDColor_Line100];
    manager.chatBox_emotion_topLineHeight = 0.5f;
    manager.chatBox_more_itemCornerRadius = 28.0f;
//    manager.chatBox_more_itemTextColor = [UIColor jdColorOptions:JDColor_Text700];
    
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
    
//    manager.telRegular = nil;
    
//    /// 列表消息中的满意度评价按钮颜色-未选中 default: 0x4385FF
//    manager.satisfaction_evaluate_normal = [UIColor redColor];
//
//    /// 列表消息中的满意度评价按钮颜色-选中 default: 0xF0F0F0
//    manager.satisfaction_evaluate_selected = [UIColor blueColor];
//
//    /// 列表消息中的满意度评价按钮标题颜色-未选中 default: 0xFFFFFF
//    manager.satisfaction_evaluate_titleColor_normal = [UIColor yellowColor];
//
//    /// 列表消息中的满意度评价按钮标题颜色-选中 default: 0xBFBFBF
//    manager.satisfaction_evaluate_titleColor_selected = [UIColor greenColor];
//
//
//    /// 满意度弹窗的评价提交按钮颜色-未选中 default: 0x4385FF
//    manager.satisfaction_evaluate_submit = [UIColor redColor];
//
//    /// 满意度弹窗的评价提交按钮标题颜色-未选中 default: 0xFFFFFF
//    manager.satisfaction_evaluate_submit_titleColor = [UIColor yellowColor];
//    UIButton *resendButton = [[UIButton alloc] init];
//    [resendButton setImage:[UIImage imageFromBundleName:@"JDComIMChatAsset.bundle" imageName:@"jd_resend_button"] forState:UIControlStateNormal];
//    manager.resendButton = resendButton;
    //测试满意度弹出模式
//    manager.satisfactionViewPopupMode = NO;
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
    option.time = @"";//@"2022/05/24 18:32:55";
    
    //[@"https://oss-hqwx-edu24ol.hqwx.com/PPT训练营_01-1648707892011.png" stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]]
    
//    @"!$&'()*+,-./:;=?@_~%#[]^{}\"|\\<>"
//    @"!$&'()*+,-./:;=?@_~%#[]"
    //stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]
    
//    NSString *ss = [@"https://oss-hqwx-edu24ol.hqwx.com/PPT训练营_01-1648707892011.png" stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    option.img = @"https://img1.baidu.com/it/u=1963848283,2056721126&fm=253&fmt=auto&app=120&f=JPEG?w=500&h=500";//[@"https://oss-hqwx-edu24ol.hqwx.com/PPT训练营_01-1648707892011.png" stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];//@"https://img2.baidu.com/it/u=3019548648,4204913203&fm=253&fmt=auto&app=138&f=JPEG?w=500&h=500";
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
    
//    [TOSKitCustomInfo shareCustomInfo].quickEntryAllItems = @[@"快捷入口1",@"快捷入口2",@"快捷入口3",@"快捷入口3",@"快捷入口3",@"快捷入口3",@"快捷入口3",@"快捷入口3",@"快捷入口3",@"快捷入口3",@"快捷入口3",@"快捷入口3",@"快捷入口3"];
}

- (void)satisfactionModelSwitchValueChanged:(UISwitch *)sender {
    if (sender.on) {
        [TOSKitCustomInfo shareCustomInfo].satisfactionViewShowModel = SatisfactionShowModelEveryTimePopup;
    } else {
        [TOSKitCustomInfo shareCustomInfo].satisfactionViewShowModel = SatisfactionShowModelFirstTimePopup;
    }
}

- (void)addChildView {
    UILabel *satisfactionModelLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 300, 50)];
    satisfactionModelLabel.text = @"打开为每次都弹出满意度，关闭为只在第一次弹出满意度";
    satisfactionModelLabel.numberOfLines = 0;
    [self.view addSubview:satisfactionModelLabel];
    
    // 将开关添加到视图
    [self.view addSubview:self.satisfactionModelSwitch];
    
    [self.view addSubview:self.setUpQuickEntry];
    
    [self.view addSubview:self.commentCountEnable];
    [self.view addSubview:self.visitorCreatedTicket];
    [self.view addSubview:self.noCommentCountHideQuickEntry];
    
    
    [self.view addSubview:self.textField1];
    [self.view addSubview:self.textField2];
    [self.view addSubview:self.textField3];
    [self.view addSubview:self.applicationStage];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.edgesForExtendedLayout = UIRectEdgeBottom;
    self.extendedLayoutIncludesOpaqueBars = YES;
    
    [self addChildView];
    
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
    
    // 集度UI无快捷入口
    UIButton * jidukefuBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    jidukefuBtn.backgroundColor = TOSHexColor(0xFF7C65);
    jidukefuBtn.frame = CGRectMake(kWindowWidth-kWindowWidth/3, kefuBtn1.bottom_sd+10.f, kWindowWidth/3, 40.f);
    jidukefuBtn.titleLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:15.f];
    [jidukefuBtn setTitle:@"集度客服" forState:UIControlStateNormal];
    [jidukefuBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [jidukefuBtn addTarget:self action:@selector(jidukefuAction) forControlEvents:UIControlEventTouchDown];
    jidukefuBtn.layer.masksToBounds = YES;
    jidukefuBtn.layer.cornerRadius = 5.f;
    [self.view addSubview:jidukefuBtn];
    
    // 集度UI无快捷入口
    UIButton * defaultBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    defaultBtn.backgroundColor = TOSHexColor(0xFF7C65);
    defaultBtn.frame = CGRectMake(kWindowWidth-kWindowWidth/3, jidukefuBtn.bottom_sd+10.f, kWindowWidth/3, 40.f);
    defaultBtn.titleLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:15.f];
    [defaultBtn setTitle:@"默认客服" forState:UIControlStateNormal];
    [defaultBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [defaultBtn addTarget:self action:@selector(defaultAction) forControlEvents:UIControlEventTouchDown];
    defaultBtn.layer.masksToBounds = YES;
    defaultBtn.layer.cornerRadius = 5.f;
    [self.view addSubview:defaultBtn];
    
    // 集度UI无快捷入口
    UIButton * closeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    closeBtn.backgroundColor = TOSHexColor(0xFF7C65);
    closeBtn.frame = CGRectMake(kWindowWidth-kWindowWidth/3, defaultBtn.bottom_sd+10.f, kWindowWidth/3, 40.f);
    closeBtn.titleLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:15.f];
    [closeBtn setTitle:@"关闭会话" forState:UIControlStateNormal];
    [closeBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [closeBtn addTarget:self action:@selector(closeAction) forControlEvents:UIControlEventTouchDown];
    closeBtn.layer.masksToBounds = YES;
    closeBtn.layer.cornerRadius = 5.f;
    [self.view addSubview:closeBtn];
    
    
    UIButton * updataBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    updataBtn.backgroundColor = TOSHexColor(0xFF7C65);
    updataBtn.frame = CGRectMake(kWindowWidth-kWindowWidth/3, closeBtn.bottom_sd+10.f, kWindowWidth/3, 40.f);
    updataBtn.titleLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:15.f];
    [updataBtn setTitle:@"刷新" forState:UIControlStateNormal];
    [updataBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [updataBtn addTarget:self action:@selector(updataAction) forControlEvents:UIControlEventTouchDown];
    updataBtn.layer.masksToBounds = YES;
    updataBtn.layer.cornerRadius = 5.f;
    [self.view addSubview:updataBtn];

    
//    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"跳转" style:(UIBarButtonItemStylePlain) target:self action:@selector(rightAction:)];
    
    
//    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
//    NSString *app_Name = [infoDictionary objectForKey:@"CFBundleDisplayName"];
//    NSString *str = [NSString stringWithFormat:@"无法录制声音 请在iPhone的“设置>%@”中打开麦克风权限",app_Name];
//    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:str message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"前往设置", nil];
//    [alert show];
}

//- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
//    if (buttonIndex == 1) { // 去设置界面，开启相机访问权限
//        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]];
//    }
//}

- (void)rightAction:(UIBarButtonItem *)sender {
//    TOSSessionInfoModel * model = [[TOSClientKit sharedTOSKit] getCurrentSessionInfo];
//    NSLog(@"viewload sessModel status:%d startTime:%lld mainUniqueId:%@ enterpriseId:%@ visitorId:%@",
//          [model.status intValue],
//          [model.startTime longLongValue],
//          model.mainUniqueId,
//          model.enterpriseId,
//          model.visitorId);
//    
//    NSLog(@"SDKVersion = %@",[TOSClientKit getSDKVersion]);
    kefuVC *vc = [[kefuVC alloc] init];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
    vc.hidesBottomBarWhenPushed = NO;
}

- (TOSQuickEntryModel *)setupQuickEntryModel {
    
    NSString *url;
    if (self.textField1.text.length <= 0) {
        url = @"https://ticket-test.clink.cn/ticket.html?accessId=2e4c05c16ee5468da624c19c07413501";
    } else {
        url = self.textField1.text;
    }
    
    TOSQuickEntryModel *entryModel = [[TOSQuickEntryModel alloc] init];
    entryModel.dynamicConfigParameters[TOS_APPLICATION_STAGE] = TOSAppLicationStageType_Both;
    entryModel.dynamicConfigParameters[TOS_STAFF_COMMENT_TOTAL_COUNT] = @"0";
    entryModel.dynamicConfigParameters[TOS_TICKET_PLUGIN_URL] = url;
    entryModel.dynamicConfigParameters[TOS_COMMENT_COUNT_ENABLE] = [NSNumber numberWithBool:self.commentCountEnable.on];
    
    if (self.commentCountEnable.on) {
        entryModel.dynamicConfigParameters[TOS_VISITOR_CREATED_TICKET] = [NSNumber numberWithBool:self.visitorCreatedTicket.on];
        entryModel.dynamicConfigParameters[TOS_NO_COMMENT_COUNT_HIDE_QUICK_ENTRY] = [NSNumber numberWithBool:self.noCommentCountHideQuickEntry.on];
    } else {
        entryModel.dynamicConfigParameters[TOS_VISITOR_CREATED_TICKET] = [NSNumber numberWithBool:false];
        entryModel.dynamicConfigParameters[TOS_NO_COMMENT_COUNT_HIDE_QUICK_ENTRY] = [NSNumber numberWithBool:false];
    }
    
    if ([self.applicationStage.text isEqualToString:@"1"]) {
        entryModel.dynamicConfigParameters[TOS_APPLICATION_STAGE] = TOSAppLicationStageType_OFF;
    } else if ([self.applicationStage.text isEqualToString:@"2"]) {
        entryModel.dynamicConfigParameters[TOS_APPLICATION_STAGE] = TOSAppLicationStageType_Robot;
    } else if ([self.applicationStage.text isEqualToString:@"3"]) {
        entryModel.dynamicConfigParameters[TOS_APPLICATION_STAGE] = TOSAppLicationStageType_Human;
    } else if ([self.applicationStage.text isEqualToString:@"4"]) {
        entryModel.dynamicConfigParameters[TOS_APPLICATION_STAGE] = TOSAppLicationStageType_Both;
    } else {
        entryModel.dynamicConfigParameters[TOS_APPLICATION_STAGE] = TOSAppLicationStageType_Both;
    }
    return entryModel;
}

-(void)kefuAction{
    /*访客初始化回调
     当APP端IM mqtt 连接就绪，主动通知服务端，APP端调用该接口后服务端
     就开始会话流程逻辑创建会话*/
//    DomainNameSave *domainName = [DomainNameSave shareDomainNameSave];
    /// 配置快捷区域的数据
    
//    [TOSKitCustomInfo shareCustomInfo].satisfactionViewPopupMode = YES;
    
//    NSMutableArray <TOSQuickEntryModel *>*quickEntryAllItems = [NSMutableArray array];
//    [quickEntryAllItems addObject:[self setupQuickEntryModel]];
    
//    if (self.textField1.text.length > 0) {
//        
//        [[self.textField1.text componentsSeparatedByString:@"-"] enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
//            
//            TOSQuickEntryModel *model = [[TOSQuickEntryModel alloc] init];
//            model.name = obj;
//            model.value = obj;
//            model.eventName = obj;
//            model.dynamicConfigParameters = [NSMutableDictionary dictionary];
//            
//            [quickEntryAllItems addObject:model];
//        }];
//    }
    
//    NSMutableArray <TOSQuickEntryModel *>*quickEntryRobotItems = [NSMutableArray array];
//    [quickEntryRobotItems addObject:[self setupQuickEntryModel]];
//    [[@"转人工-测试1-测试2-测试3" componentsSeparatedByString:@"-"] enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
//        
//        TOSQuickEntryModel *model = [[TOSQuickEntryModel alloc] init];
//        model.name = obj;
//        model.value = obj;
//        model.eventName = obj;
//        model.dynamicConfigParameters = [NSMutableDictionary dictionary];
//        [quickEntryRobotItems addObject:model];
//    }];
//    [TOSKitCustomInfo shareCustomInfo].quickEntryAllItems = quickEntryRobotItems;
    
    [TOSKitCustomInfo shareCustomInfo].quickEntryBottom_backgroundColor = TOSHexColor(0xEFF0F3);
    [TOSKitCustomInfo shareCustomInfo].quickEntryItem_backgroundColor = TOSHexColor(0xFFFFFF);
    
    if ([TOSKitCustomInfo shareCustomInfo].commodityCardOption && self.textField1.text.length) {
        [TOSKitCustomInfo shareCustomInfo].commodityCardOption.extraData = @[@{@"name": @"订单状态", @"value": self.textField1.text},];
    }
    NSLog(@"[TOSKitCustomInfo shareCustomInfo].commodityCardOption.extraData : %@", [TOSKitCustomInfo shareCustomInfo].commodityCardOption.extraData);
//    TOSKitCustomInfo.shareCustomInfo.orderDrawer.listBackGroundColor = UIColor.orangeColor;
//    TOSKitCustomInfo.shareCustomInfo.orderDrawer.orderCorner = 0.0f;
    
    LoginModel *model = [LoginModel loginModel];
//    TOSConnectOption * connectOption = [[TOSConnectOption alloc] initWithOption:@"7Jn3xT_YvwU"
//                                                                       nickname:@"极越用户y95511"
//                                                                        headUrl:@"https://avatar.jiduapp.cn/default/3.png"
//                                                                         mobile:@""
//                                                                  advanceParams:@{}];
    
//    NSMutableDictionary * dict = [NSMutableDictionary dictionaryWithDictionary:model.advanceParams];
//    [dict setObject:@"测试一下" forKey:@"channel_id"];
//    model.advanceParams = dict;
    
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
    
//    TOSConnectOption * connectOption = [[TOSConnectOption alloc] initWithOption:@"tinet_ios" nickname:@"昵称" headUrl:@"" mobile:@"1234" advanceParams:@{@"快捷入口":@"哈哈哈"}];
    
//    if (self.load) {
//        [TOSKitCustomInfo shareCustomInfo].commodityCardOption = nil;
//        NSLog(@"商品卡片置空了");
//    }
    
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
    //        TOSClientKitCommodityCardOption *option = [[TOSClientKitCommodityCardOption alloc] init];
    //        option.subTitle = @"华为P40麒麟990 ";
    //        option.descriptions = @"这是商品描述，啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦";
    //        option.price = @"100.99";
    //        option.time = @"2022/05/24 18:32";
    //        option.img = @"https://img2.baidu.com/it/u=3019548648,4204913203&fm=253&fmt=auto&app=138&f=JPEG?w=500&h=500";
    //        option.status = @"已到货";
    //        option.extraInfo = @[@{@"name": @"订单号", @"value": @"1234567890"},
    //                             @{@"name": @"产品类型", @"value": @"电子产品"},
    //                             @{@"name": @"师傅"   , @"value": @"金师傅"},
    //                             @{@"name": @"服务地区", @"value": @"北京市"},
    //                             @{@"name": @"服务"   , @"value": @"满意"},
    //                             @{@"name": @"师傅电话", @"value": @"12345678900"},
    //                             @{@"name": @"订单状态", @"value": @"已完成"}];
    //        option.url = @"https://www.baidu.com";
        
    //        chatVC.commodityCardOption = option;
    //        chatVC.quickEntryAllItems = @[@"快捷入口1",@"快捷入口2",@"快捷入口3",@"快捷入口3",@"快捷入口3",@"快捷入口3",@"快捷入口3",@"快捷入口3",@"快捷入口3",@"快捷入口3",@"快捷入口3",@"快捷入口3",@"快捷入口3"];
        
//        if (self.textField1.text.length > 0) {
//            NSMutableArray <TOSQuickEntryModel *>*quickEntryAllItems = [NSMutableArray array];
//            [[self.textField1.text componentsSeparatedByString:@"-"] enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
//
//                TOSQuickEntryModel *model = [[TOSQuickEntryModel alloc] init];
//                model.name = obj;
//                model.value = obj;
//                model.eventName = obj;
//                model.dynamicConfigParameters = [NSMutableDictionary dictionary];
//
//                [quickEntryAllItems addObject:model];
//            }];
//            chatVC.quickEntryAcquiesceItems = quickEntryAllItems;
//        }
//        if (self.textField2.text.length > 0) {
//            NSMutableArray <TOSQuickEntryModel *>*quickEntryAllItems = [NSMutableArray array];
            NSMutableArray <TOSQuickEntryModel *>*quickEntryRobotItems = [NSMutableArray array];
//            [quickEntryRobotItems addObject:[self setupQuickEntryModel]];
            [[@"转人工-测试1-测试2-测试3" componentsSeparatedByString:@"-"] enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                
                TOSQuickEntryModel *model = [[TOSQuickEntryModel alloc] init];
                model.name = obj;
                model.value = obj;
                model.eventName = obj;
                model.dynamicConfigParameters = [NSMutableDictionary dictionary];
                [quickEntryRobotItems addObject:model];
            }];
            chatVC.quickEntryRobotItems = quickEntryRobotItems;
//        [TOSKitCustomInfo shareCustomInfo].quickEntryAllItems = quickEntryRobotItems;
//        }
//        if (self.textField3.text.length > 0) {
//            NSMutableArray <TOSQuickEntryModel *>*quickEntryAllItems = [NSMutableArray array];
            NSMutableArray <TOSQuickEntryModel *>*quickEntryOnlineItems = [NSMutableArray array];
//            [quickEntryOnlineItems addObject:[self setupQuickEntryModel]];
            [[@"测试4-测试5-测试6" componentsSeparatedByString:@"-"] enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                
                TOSQuickEntryModel *model = [[TOSQuickEntryModel alloc] init];
                model.name = obj;
                model.value = obj;
                model.eventName = obj;
                model.dynamicConfigParameters = [NSMutableDictionary dictionary];
                [quickEntryOnlineItems addObject:model];
            }];
            chatVC.quickEntryOnlineItems = quickEntryOnlineItems;
//        }
        chatVC.setUpQuickEntryBool = self.setUpQuickEntryBool;
        self.hidesBottomBarWhenPushed  = YES;
        [self.navigationController pushViewController:chatVC animated:YES];
    } error:^(TIMConnectErrorCode errCode, NSString * _Nonnull errorDes) {
        NSLog(@"errorDes === %@",errorDes);
//        [WHToast showMessage:errorDes duration:2 finishHandler:^{
//        }];
    } tokenIncorrect:^{
        NSLog(@"tokenIncorrect");
    }];
}

-(void)kefuAction1{
    /*访客初始化回调
     当APP端IM mqtt 连接就绪，主动通知服务端，APP端调用该接口后服务端
     就开始会话流程逻辑创建会话*/
//    DomainNameSave *domainName = [DomainNameSave shareDomainNameSave];
//    NSDictionary * params = @{};
//    if ([domainName.domainName isEqualToString:@"天润北京测试KT"]) {
//        params = @{
//            @"configENVString": @"KTTestEnv"
//        };
//    }
//    [[OnlineRequestManager sharedCustomerManager]visitorReadyWithDict:params
//                                                              success:^(NSString * _Nonnull mainUniqueId) {
//        NSLog(@"kefuAction mainUniqueId === %@",mainUniqueId);
//
//
//        } error:^(TIMConnectErrorCode errCode, NSString * _Nonnull errorDes) {
//    }];
    ///
//    /// 文本框的内边距
    [TOSKitCustomInfo shareCustomInfo].chatBox_textView_textContainerInset = UIEdgeInsetsMake(10, 10, 10, 10);
    [TOSKitCustomInfo shareCustomInfo].chatBox_textView_backgroundColor = UIColor.whiteColor;

    /// 第二个不开启快捷区域
//    [TOSKitCustomInfo shareCustomInfo].quickEntryAllItems = @[];
    /// 头像距离屏幕边缘的边距
//    [TOSKitCustomInfo shareCustomInfo].headMargin = 30.0f;

//    [TOSKitCustomInfo shareCustomInfo].ChatBox_textview_placeholder = @"请输入问题";
//    [TOSKitCustomInfo shareCustomInfo].chatBox_Height = 90.0f;
    /// 文本框的默认提示内容距离输入框左边的距离
    [TOSKitCustomInfo shareCustomInfo].chatBox_textView_placeholderMargin = 10.0f;
    [TOSKitCustomInfo shareCustomInfo].chatBox_textView_cornerRadius = 8.0f;
//    [TOSKitCustomInfo shareCustomInfo].chatBox_itemBottomSpacing = 4.0;
    [TOSKitCustomInfo shareCustomInfo].chatBox_talkText = @"按住 说话";
    [TOSKitCustomInfo shareCustomInfo].chatBox_talkHighlightedText = @"松开 结束";
    [TOSKitCustomInfo shareCustomInfo].chatBox_talkFont = [UIFont boldSystemFontOfSize:16.0f];
    /**  发送按钮的自定义     **/
    /// 关闭表情按钮和更多按钮
    [TOSKitCustomInfo shareCustomInfo].chatBox_emotionButton_enable = YES;
    [TOSKitCustomInfo shareCustomInfo].chatBox_moreButton_enable = YES;
//    /// 打开发送按钮
//    [TOSKitCustomInfo shareCustomInfo].chatBox_sendButton_enable = YES;
//    /// 设置自定义发送按钮的相关属性
//    [TOSKitCustomInfo shareCustomInfo].chatBox_sendButton_cornerRadius = 40/2;
//    [TOSKitCustomInfo shareCustomInfo].chatBox_sendButtonSize = CGSizeMake(80, 40);
//    [TOSKitCustomInfo shareCustomInfo].chatBox_sendButton_borderColor = UIColor.redColor;
//    [TOSKitCustomInfo shareCustomInfo].chatBox_sendButton_HighlightedColor = UIColor.orangeColor;
//    [TOSKitCustomInfo shareCustomInfo].chatBox_sendButton_borderWidth = 2.0f;
//
//    /// 设置自定义的发送按钮
//    UIButton * btn = [[UIButton alloc] init];
//    [btn setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@/%@",FRAMEWORKS_BUNDLE_PATH,@"resendMessage"]] forState:UIControlStateNormal];
//    [TOSKitCustomInfo shareCustomInfo].resendButton = btn;
    [TOSKitCustomInfo shareCustomInfo].resendButtonSize = CGSizeMake(20.0f, 20.0f);
    [TOSKitCustomInfo shareCustomInfo].bubbleMaxWidth = kWindowWidth - 150;
    [TOSKitCustomInfo shareCustomInfo].resendToBubblePadding = 4.0f;
    [TOSKitCustomInfo shareCustomInfo].bubblePadding = 10.0;
    // ChatLocationMessage
    [[TOSKitCustomInfo shareCustomInfo].customCellRegister removeAllObjects];
    [TOSKitCustomInfo shareCustomInfo].chatBox_textView_maxRows = 5;
    [TOSKitCustomInfo shareCustomInfo].chatBox_talk_borderWidth = 0.5f;
    [TOSKitCustomInfo shareCustomInfo].chatBox_talk_borderColor = [UIColor colorWithHexString:@"E8E8E8"];
//    [TOSKitCustomInfo shareCustomInfo].chat_send_voiceLabelToBubbleLeftX = 10.0f;
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
    /// 语音录制时间太短HUD的显示时间
//    [TOSKitCustomInfo shareCustomInfo].chatBox_voiceRecordSoShortTime = 3.0f;

    [TOSKitCustomInfo shareCustomInfo].chatBox_emotion_deleteButton_cornerRadius = 4.0f;
//    [TOSKitCustomInfo shareCustomInfo].chatBox_emotion_deleteButton_image = [UIImage imageNamed:[NSString stringWithFormat:@"%@/%@",FRAMEWORKS_BUNDLE_PATH,@"chatBox_delete"]];
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
//    [TOSKitCustomInfo shareCustomInfo].Chat_visitorName_enable = YES;
//    [TOSKitCustomInfo shareCustomInfo].Chat_tosRobotName_enable = YES;
    [TOSKitCustomInfo shareCustomInfo].lastMessage_spacing = 0.0f;
    [TOSKitCustomInfo shareCustomInfo].cellMargin = 10.0f;
    [TOSKitCustomInfo shareCustomInfo].nickNameToBubbleSpacing = 0.0f;
    [TOSKitCustomInfo shareCustomInfo].chatBubble_CornerType = BubbleCornerTypeAll;

    [TOSKitCustomInfo shareCustomInfo].chatMessage_system_edgeInsets =  UIEdgeInsetsMake(5, 20, 5, 20);
    [TOSKitCustomInfo shareCustomInfo].chatMessage_system_backgroundColor = [[UIColor colorWithHexString:@"#FFFFFF"] colorWithAlphaComponent:0.65];
//    [TOSKitCustomInfo shareCustomInfo].chatMessage_system_textFont = [UIFont systemFontOfSize:20];
//    [TOSKitCustomInfo shareCustomInfo].chatMessage_system_labelTextEdgeInsets = UIEdgeInsetsMake(10, 10, 10, 10);
//    [TOSKitCustomInfo shareCustomInfo].chatMessage_system_center = NO;

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
    
//    [TOSKitCustomInfo shareCustomInfo].chatMessage_visitorText_font = [UIFont systemFontOfSize:18.0];
//    [TOSKitCustomInfo shareCustomInfo].chatMessage_tosRobotText_font = [UIFont systemFontOfSize:16.0];
    
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
//        [WHToast showMessage:errorDes duration:2 finishHandler:^{
//        }];
    } tokenIncorrect:^{
        NSLog(@"tokenIncorrect");
    }];
    
    //关闭
//    [[TOSClientKit sharedTOSKit] closeSession:^{
//
//        [[TOSClientKit sharedTOSKit] setAdvanceParams:@{@"qno": @"0510"}];
//        ChatInfoViewController *chatVC = [[ChatInfoViewController alloc] init];
//        chatVC.titleName = @"客服";
//        chatVC.appName = @"客服SDK";
//        self.hidesBottomBarWhenPushed  = YES;
//        [self.navigationController pushViewController:chatVC animated:YES];
//    } error:^(TIMConnectErrorCode errCode, NSString * _Nonnull errorDes) {
//
//    }];
    
    
//    TOSClientKitCommodityCardOption *option = [[TOSClientKitCommodityCardOption alloc] init];
//    option.subTitle = @"华为P40麒麟990 5G SoC芯片 5000万超感知徕卡三摄 30倍数字变焦";
//    option.descriptions = @"这是商品描述，啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦";
//    option.price = @"100.99";
//    option.time = @"2022/05/24 18:32";
//    option.img = @"https://img2.baidu.com/it/u=3019548648,4204913203&fm=253&fmt=auto&app=138&f=JPEG?w=500&h=500";
//    option.status = @"已到货";
//    option.extraInfo =
//    @[@{@"name": @"订单号", @"value": @"1234567890"},
//    @{@"name": @"产品类型", @"value": @"电子产品"},
//    @{@"name": @"师傅"   , @"value": @"金师傅"},
//    @{@"name": @"服务地区", @"value": @"北京市"},
//    @{@"name": @"服务"   , @"value": @"满意"},
//    @{@"name": @"师傅电话", @"value": @"12345678900"},
//    @{@"name": @"订单状态", @"value": @"已完成"}];
//    
//    chatVC.commodityCardOption = option;
//    self.hidesBottomBarWhenPushed  = YES;
//    [self.navigationController pushViewController:chatVC animated:YES];
    
}

/// 集度的UI改造
- (void)jidukefuAction {
    
    /// 文本框的内边距
//    [TOSKitCustomInfo shareCustomInfo].chatBox_textView_textContainerInset = UIEdgeInsetsMake(10, 10, 10, 10);
    [TOSKitCustomInfo shareCustomInfo].chatBox_textView_backgroundColor = UIColor.cyanColor;
    
    /// 第二个不开启快捷区域
//    [TOSKitCustomInfo shareCustomInfo].quickEntryAllItems = @[];
    /// 头像距离屏幕边缘的边距
//    [TOSKitCustomInfo shareCustomInfo].headMargin = 30.0f;
    
    [TOSKitCustomInfo shareCustomInfo].ChatBox_textview_placeholder = @"买石灰街车站的海鸥 山水禽兽与年少一梦 买太平湖底陈年水墨 哥本哈根的童年传说";
//    [TOSKitCustomInfo shareCustomInfo].chatBox_Height = 90.0f;
    /// 文本框的默认提示内容距离输入框左边的距离
    [TOSKitCustomInfo shareCustomInfo].chatBox_textView_placeholderMargin = 20.0f;
    [TOSKitCustomInfo shareCustomInfo].chatBox_textView_cornerRadius = 8.0f;
//    [TOSKitCustomInfo shareCustomInfo].chatBox_itemBottomSpacing = 4.0;
    [TOSKitCustomInfo shareCustomInfo].chatBox_talkText = @"按我试试？";
    [TOSKitCustomInfo shareCustomInfo].chatBox_talkHighlightedText = @"快松开我";
    [TOSKitCustomInfo shareCustomInfo].chatBox_talkFont = [UIFont systemFontOfSize:22];
    /**  发送按钮的自定义     **/
    /// 关闭表情按钮和更多按钮
    [TOSKitCustomInfo shareCustomInfo].chatBox_emotionButton_enable = YES;
    [TOSKitCustomInfo shareCustomInfo].chatBox_moreButton_enable = YES;
//    /// 打开发送按钮
//    [TOSKitCustomInfo shareCustomInfo].chatBox_sendButton_enable = YES;
//    /// 设置自定义发送按钮的相关属性
//    [TOSKitCustomInfo shareCustomInfo].chatBox_sendButton_cornerRadius = 40/2;
//    [TOSKitCustomInfo shareCustomInfo].chatBox_sendButtonSize = CGSizeMake(80, 40);
//    [TOSKitCustomInfo shareCustomInfo].chatBox_sendButton_borderColor = UIColor.redColor;
//    [TOSKitCustomInfo shareCustomInfo].chatBox_sendButton_HighlightedColor = UIColor.orangeColor;
//    [TOSKitCustomInfo shareCustomInfo].chatBox_sendButton_borderWidth = 2.0f;
//
//    /// 设置自定义的发送按钮
    UIButton * btn = [[UIButton alloc] init];
    [btn setImage:[UIImage imageNamed:@"resendIcon"] forState:UIControlStateNormal];
//    [btn setBackgroundImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@/%@",FRAMEWORKS_BUNDLE_PATH,@"resendMessage"]] forState:(UIControlStateNormal)];
    btn.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 20);
    btn.titleLabel.font = [UIFont systemFontOfSize:12];
    [TOSKitCustomInfo shareCustomInfo].resendButton = btn;
    [TOSKitCustomInfo shareCustomInfo].resendButtonSize = CGSizeMake(20, 20);
    [TOSKitCustomInfo shareCustomInfo].resendToBubblePadding = 10.0f;
    [TOSKitCustomInfo shareCustomInfo].bubblePadding = 12.0;
    /// 自定义排队cell
//    [[TOSKitCustomInfo shareCustomInfo].customCellRegister setValue:[customTableViewCell class] forKey:@"GXSystem"];
    // ChatLocationMessage
//    [[TOSKitCustomInfo shareCustomInfo].customCellRegister setValue:[customTableViewCell class] forKey:@"TypeEventQueue"];
    [[TOSKitCustomInfo shareCustomInfo].customCellRegister setValue:[CustomFileTableViewCell class] forKey:@"GXCustomFile"];
    
    [TOSKitCustomInfo shareCustomInfo].chatBox_textView_maxRows = 1;
    [TOSKitCustomInfo shareCustomInfo].chatBox_talk_borderWidth = 2.0f;
    [TOSKitCustomInfo shareCustomInfo].chatBox_talk_borderColor = UIColor.redColor;
//    [TOSKitCustomInfo shareCustomInfo].chat_send_voiceLabelToBubbleLeftX = 10.0f;
    [TOSKitCustomInfo shareCustomInfo].chat_send_voiceImageToBubbleRightX = 40.0;
    [TOSKitCustomInfo shareCustomInfo].chat_send_voiceImageToBubbleTop = 10.0f;
    [TOSKitCustomInfo shareCustomInfo].chat_send_voiceLabelToBubbleTop = 10.0f;
    [TOSKitCustomInfo shareCustomInfo].chatBox_talk_backgroundColor = UIColor.redColor;
    [TOSKitCustomInfo shareCustomInfo].chatBox_talk_backgroundHighlightedColor = UIColor.yellowColor;
    [TOSKitCustomInfo shareCustomInfo].chatBox_talk_fontHighlightedColor = UIColor.blueColor;
    /// 语音录制HUD
    UIView * recordV = [[UIView alloc] initWithFrame:(CGRectMake(UIScreen.mainScreen.bounds.size.width/2-50, UIScreen.mainScreen.bounds.size.height/2-50, 100, 100))];
    recordV.backgroundColor = UIColor.orangeColor;
    [TOSKitCustomInfo shareCustomInfo].chatBox_voiceRecordView = recordV;
    /// 语音取消录制HUD
    UIView * cancelRecordV = [[UIView alloc] initWithFrame:(CGRectMake(UIScreen.mainScreen.bounds.size.width/2-50, UIScreen.mainScreen.bounds.size.height/2-50, 100, 100))];
    cancelRecordV.backgroundColor = UIColor.redColor;
    [TOSKitCustomInfo shareCustomInfo].chatBox_voiceCancelRecordView = cancelRecordV;
    /// 语音录制时间太短HUD
    UIView * shortV = [[UIView alloc] initWithFrame:(CGRectMake(UIScreen.mainScreen.bounds.size.width/2-50, UIScreen.mainScreen.bounds.size.height/2-50, 100, 50))];
    shortV.backgroundColor = UIColor.blackColor;
    [TOSKitCustomInfo shareCustomInfo].chatBox_voiceRecordSoShortView = shortV;
    /// 语音录制时间太短HUD的显示时间
//    [TOSKitCustomInfo shareCustomInfo].chatBox_voiceRecordSoShortTime = 3.0f;
    
    [TOSKitCustomInfo shareCustomInfo].chatBox_emotion_deleteButton_cornerRadius = 18.0f;
    [TOSKitCustomInfo shareCustomInfo].chatBox_emotion_deleteButton_image = [UIImage imageNamed:@"emotion_delete"];
    [TOSKitCustomInfo shareCustomInfo].chatBox_emotion_deleteButtonSize = CGSizeMake(68, 36);
    [TOSKitCustomInfo shareCustomInfo].chatBox_emotion_deleteButtonOffset = CGPointMake(30, 0);
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
    sendshadowLayer.shadowColor = [UIColor orangeColor].CGColor;
    sendshadowLayer.shadowOffset = CGSizeMake(2, 5);
    sendshadowLayer.shadowOpacity = 0.5;
    sendshadowLayer.shadowRadius = 18.0;
    [TOSKitCustomInfo shareCustomInfo].chatBox_emotion_sendCALayer = shadowLayer;
    [TOSKitCustomInfo shareCustomInfo].chatBox_emotion_sendButton_text = @"单车";
    [TOSKitCustomInfo shareCustomInfo].chatBox_emotion_sendButtonSize = CGSizeMake(68, 36);
    [TOSKitCustomInfo shareCustomInfo].chatBox_emotion_sendButton_textColor = UIColor.grayColor;
    [TOSKitCustomInfo shareCustomInfo].chatBox_emotion_sendButton_cornerRadius = 18.0f;
    [TOSKitCustomInfo shareCustomInfo].chatBox_emotion_sendButtonBackGroundColor = [UIColor colorWithHexString:@"#824DFC"];
    [TOSKitCustomInfo shareCustomInfo].chatBox_emotion_sendButtonMargins = UIEdgeInsetsMake(0, 0, 8, 20);
    
    [TOSKitCustomInfo shareCustomInfo].chatBox_topLineHeight = 2.0f;
    [TOSKitCustomInfo shareCustomInfo].ChatBox_lineColor = UIColor.orangeColor;
    [TOSKitCustomInfo shareCustomInfo].chatBox_textView_borderWidth = 2.0f;
    [TOSKitCustomInfo shareCustomInfo].chatBox_textView_borderColor = UIColor.yellowColor;
    [TOSKitCustomInfo shareCustomInfo].chatBox_Item_Width = 32;
//    [TOSKitCustomInfo shareCustomInfo].Chat_visitorName_enable = YES;
//    [TOSKitCustomInfo shareCustomInfo].Chat_tosRobotName_enable = YES;
    [TOSKitCustomInfo shareCustomInfo].lastMessage_spacing = 20.0f;
//    [TOSKitCustomInfo shareCustomInfo].cellMargin = 20.0f;
    [TOSKitCustomInfo shareCustomInfo].nickNameToBubbleSpacing = 10.0f;
    [TOSKitCustomInfo shareCustomInfo].chatBubble_CornerType = BubbleCornerTypeNoRightTop;
    
    [TOSKitCustomInfo shareCustomInfo].chatMessage_system_edgeInsets = UIEdgeInsetsMake(5, 30, 10, 30);
    [TOSKitCustomInfo shareCustomInfo].chatMessage_system_backgroundColor = UIColor.clearColor;
//    [TOSKitCustomInfo shareCustomInfo].chatMessage_system_textFont = [UIFont systemFontOfSize:13];
//    [TOSKitCustomInfo shareCustomInfo].chatMessage_system_labelTextEdgeInsets = UIEdgeInsetsMake(10, 10, 10, 10);
//    [TOSKitCustomInfo shareCustomInfo].chatMessage_system_center = NO;
    
    [TOSKitCustomInfo shareCustomInfo].ChatBox_backGroundColor = [UIColor colorWithHexString:@"#F2F2F7"];
    [TOSKitCustomInfo shareCustomInfo].senderBubble_cornerRadius = 20.0f;
    [TOSKitCustomInfo shareCustomInfo].receiveBubble_cornerRadius = 20.0f;
    [TOSKitCustomInfo shareCustomInfo].chatBox_more_topLineColor = UIColor.orangeColor;
    [TOSKitCustomInfo shareCustomInfo].chatBox_more_topLineHeight = 2.0f;
    [TOSKitCustomInfo shareCustomInfo].chatBox_more_itemCornerRadius = 48.0f;
//    [TOSKitCustomInfo shareCustomInfo].chatBox_more_itemBackgroundColor = UIColor.redColor;
    [TOSKitCustomInfo shareCustomInfo].chatBox_emotion_backgroundColor = UIColor.yellowColor;
    [TOSKitCustomInfo shareCustomInfo].chatBox_more_backgroundColor = UIColor.cyanColor;
    [TOSKitCustomInfo shareCustomInfo].chatBox_more_itemTextColor = UIColor.orangeColor;
    [TOSKitCustomInfo shareCustomInfo].chatBox_emotion_topLineColor = UIColor.orangeColor;
    [TOSKitCustomInfo shareCustomInfo].chatBox_emotion_topLineHeight = 2.0f;
    
    [TOSKitCustomInfo shareCustomInfo].chatBox_Height = 60.0f;
    [TOSKitCustomInfo shareCustomInfo].chatBox_textView_textContainerInset = UIEdgeInsetsMake(8, 10, 8, 10);
    [TOSKitCustomInfo shareCustomInfo].chatBox_emotion_functionItemDisplayed = YES;
    
    
    [TOSKitCustomInfo shareCustomInfo].Chat_tosRobotName_show = YES;
    [TOSKitCustomInfo shareCustomInfo].Chat_tosRobotName_enable = YES;
    [TOSKitCustomInfo shareCustomInfo].Chat_visitorName_enable = YES;
    [TOSKitCustomInfo shareCustomInfo].Chat_visitorName_show = YES;
    
    [TOSKitCustomInfo shareCustomInfo].chatMessage_visitorName_font = [UIFont boldSystemFontOfSize:18];
    [TOSKitCustomInfo shareCustomInfo].chatMessage_visitorName_textColor = UIColor.blackColor;
    [TOSKitCustomInfo shareCustomInfo].chatMessage_tosRobotName_font = [UIFont systemFontOfSize:28];
    [TOSKitCustomInfo shareCustomInfo].chatMessage_tosRobotName_textColor = UIColor.redColor;
    
//    [TOSKitCustomInfo shareCustomInfo].chatMessage_visitorText_font = [UIFont systemFontOfSize:20.0];
//    [TOSKitCustomInfo shareCustomInfo].chatMessage_tosRobotText_font = [UIFont systemFontOfSize:22.0];
    
    TOSKitCustomInfo.shareCustomInfo.chatMessage_tosRobotCombination_titleFont = [UIFont systemFontOfSize:30.0];
    TOSKitCustomInfo.shareCustomInfo.chatMessage_tosRobotCombination_subTitleFont = [UIFont systemFontOfSize:22.0];
    TOSKitCustomInfo.shareCustomInfo.chatMessage_tosRobotCombination_hotSubIssueTitleFont = [UIFont systemFontOfSize:18.0];
    TOSKitCustomInfo.shareCustomInfo.chatMessage_tosRobotCombination_hotSubIssueTitleColor = UIColor.redColor;
    TOSKitCustomInfo.shareCustomInfo.chatMessage_tosRobotCombination_segmentTextColor = UIColor.cyanColor;
    TOSKitCustomInfo.shareCustomInfo.chatMessage_tosRobotCombination_segmentLineColor = UIColor.blackColor;
    TOSKitCustomInfo.shareCustomInfo.chatMessage_tosRobotCombination_showRefreshTitleColor = UIColor.blackColor;
    TOSKitCustomInfo.shareCustomInfo.chatMessage_tosRobotCombination_showRefreshTitle = @"小伙子，你完了";
    TOSKitCustomInfo.shareCustomInfo.chatMessage_tosRobotCombination_showRefreshNumber = 3;
    TOSKitCustomInfo.shareCustomInfo.chatMessage_tosRobotCombination_showRefreshTitleFont = [UIFont systemFontOfSize:22.0];
    TOSKitCustomInfo.shareCustomInfo.chatMessage_tosRobotCombination_segmentFont = [UIFont systemFontOfSize:10.0f];
    
    
    
    
    //创建会话成功，进入聊天页面
    ChatInfoViewController *chatVC = [[ChatInfoViewController alloc] init];
    chatVC.titleName = @"客服";
    chatVC.appName = @"客服SDK";
    chatVC.isRewriteClose = YES;
    self.hidesBottomBarWhenPushed  = YES;
    [self.navigationController pushViewController:chatVC animated:YES];
    
    LoginModel *model = [LoginModel loginModel];
    NSLog(@"model.userId =========== %@",model.userId);
    TOSConnectOption * connectOption = [[TOSConnectOption alloc] initWithOption:model.userId?:@""
                                                                       nickname:@"ios_jidutest"
                                                                        headUrl:model.headerUrl?:@""
                                                                         mobile:model.phoneNumber?:@""
                                                                  advanceParams:model.advanceParams?:@{}];
    connectOption.externalId = model.externalId;
    [[TOSClientKit sharedTOSKit] connect:connectOption success:^{
        
    } error:^(TIMConnectErrorCode errCode, NSString * _Nonnull errorDes) {
        NSLog(@"errorDes === %@",errorDes);
//        [WHToast showMessage:errorDes duration:2 finishHandler:^{
//        }];
    } tokenIncorrect:^{
        NSLog(@"tokenIncorrect");
    }];
    
    
}


/// 默认客服
- (void)defaultAction {
    
    
    //创建会话成功，进入聊天页面
    TOSCustomerChatVC *chatVC = [[TOSCustomerChatVC alloc] init];
    chatVC.titleName = @"客服";
    chatVC.appName = @"客服SDK";
    self.hidesBottomBarWhenPushed  = YES;
    [self.navigationController pushViewController:chatVC animated:YES];
    
    LoginModel *model = [LoginModel loginModel];
    NSLog(@"model.userId =========== %@",model.userId);
    TOSConnectOption * connectOption = [[TOSConnectOption alloc] initWithOption:model.userId?:@""
                                                                       nickname:@"ios_jidutest"
                                                                        headUrl:model.headerUrl?:@""
                                                                         mobile:model.phoneNumber?:@""
                                                                  advanceParams:model.advanceParams?:@{}];
    connectOption.externalId = model.externalId;
    [[TOSClientKit sharedTOSKit] connect:connectOption success:^{
        
    } error:^(TIMConnectErrorCode errCode, NSString * _Nonnull errorDes) {
        NSLog(@"errorDes === %@",errorDes);
//        [WHToast showMessage:errorDes duration:2 finishHandler:^{
//        }];
    } tokenIncorrect:^{
        NSLog(@"tokenIncorrect");
    }];
    
    
}

- (void)closeAction {
    
    TOSSessionInfoModel * infoModel = [TOSClientKit.sharedTOSKit getCurrentSessionInfo];
    @weakify(self);
    [TOSClientKit.sharedTOSKit closeSessionMainUniqueId:infoModel.mainUniqueId withVisitorId:infoModel.visitorId succuess:^{
        @strongify(self);
        NSLog(@"关闭会话成功");
        [self defaultAction];
    } error:^(TIMConnectErrorCode errCode, NSString * _Nonnull errorDes) {
        NSLog(@"错误信息：%@", errorDes);
//        [MBProgressHUD showMBErrorView:errorDes];
    }];
    
    
    
}


- (void)updataAction {
    
    /// 获取未读数(离线期间的)
    [[TOSClientKit sharedTOSKit] getUnreadMessage:^(NSString * _Nonnull lastMessage, NSInteger unreadCount) {
        NSLog(@"+++++未读数：%ld, 最后一条消息：%@", unreadCount, lastMessage);
        
        [TOSClientKit.sharedTOSKit getLastMessage:^(TIMMessageFrame * _Nonnull lastMessage) {
            NSString * testLastMessage = lastMessage.model.message.content;
            NSLog(@"lastMessage.model.message.type : %@", lastMessage.model.message.type);
            NSString * type = lastMessage.model.message.type;
            if ([type isEqualToString:@"GXRichText"]) {
                NSMutableArray * elementModels = (NSMutableArray<RichTextMessage *> *)lastMessage.model.message.content;
                RichTextMessage * testMessage = elementModels.firstObject;
                NSLog(@"testMessage.content : %@", testMessage.content);
                testLastMessage = testMessage.content;
            }
            else if ([type isEqualToString:@"GXText"] || [type isEqualToString:@"GXSystem"]) {
                // 这里是文字不需要做处理
            }
            else if ([type isEqualToString:@"GXPic"]) {
                testLastMessage = @"【图片】";
            }
            else if ([type isEqualToString:@"GXVideo"]) {
                testLastMessage = @"【视频】";
            }
            else if ([type isEqualToString:@"GXCustomFile"]) {
                testLastMessage = @"【文件】";
            }
            else if ([type isEqualToString:@"GXVoice"]) {
                testLastMessage = @"【语音】";
            }
            else if ([type isEqualToString:@"GXLogisticsCard"] || [type isEqualToString:@"GXCommodityCardDetails"]) {
                testLastMessage = @"【卡片】";
            }
            else if ([type isEqualToString:@"GXInvestigation"]) {
                testLastMessage = @"满意度评价";
            }
            else {
                testLastMessage = @"未知消息";
            }
            
            self.unReadInfoLabel.text = [NSString stringWithFormat:@"未读数：%ld %@", unreadCount, testLastMessage];
        } withError:^(NSString * _Nonnull errorStr) {
            
        }];
        
        
    } withError:^(NSString * _Nonnull errorStr) {
        
    }];
    
}

- (UILabel *)unReadInfoLabel {
    if (!_unReadInfoLabel) {
        _unReadInfoLabel = [[UILabel alloc] initWithFrame:(CGRectMake(0, self.commentCountEnable.bottom_sd+10, self.view.bounds.size.width, 50))];
        _unReadInfoLabel.textAlignment = 1;
        _unReadInfoLabel.backgroundColor = UIColor.orangeColor;
        
    }
    return _unReadInfoLabel;
}

- (UITextField *)textField1 {
    if (!_textField1) {
        _textField1 = [[UITextField alloc] initWithFrame:CGRectMake(0, self.unReadInfoLabel.bottom_sd+10, 320, 40)];
        _textField1.borderStyle = UITextBorderStyleRoundedRect;
        _textField1.placeholder = @"请输入工单插件地址，不输入则默认test0";
        _textField1.font = [UIFont systemFontOfSize:12.f];
    }
    return _textField1;
}

- (UITextField *)textField2 {
    if (!_textField2) {
        _textField2 = [[UITextField alloc] initWithFrame:CGRectMake(0, 190, 220, 40)];
        _textField2.borderStyle = UITextBorderStyleRoundedRect;
        _textField2.placeholder = @"机器人模式快捷数据，用-号隔开";
        _textField2.font = [UIFont systemFontOfSize:12.f];
        _textField2.hidden = YES;
    }
    return _textField2;
}

- (UITextField *)textField3 {
    if (!_textField3) {
        _textField3 = [[UITextField alloc] initWithFrame:CGRectMake(0, 250, 220, 40)];
        _textField3.borderStyle = UITextBorderStyleRoundedRect;
        _textField3.placeholder = @"人工模式快捷数据，用-号隔开";
        _textField3.font = [UIFont systemFontOfSize:12.f];
        _textField3.hidden = YES;
    }
    return _textField3;
}

- (UITextField *)applicationStage {
    if (!_applicationStage) {
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, self.satisfactionModelSwitch.bottom_sd + 5, 220, 60)];
        label.text = @"输入1/2/3/4，分别代表关闭、机器人、人工、机器人和人工，四种状态下的留言显示";
        label.numberOfLines = 0;
        label.font = [UIFont systemFontOfSize:12.f];
        [self.view addSubview:label];
        
        _applicationStage = [[UITextField alloc] initWithFrame:CGRectMake(0, label.bottom_sd + 5, 220, 40)];
        _applicationStage.borderStyle = UITextBorderStyleRoundedRect;
        _applicationStage.placeholder = @"输入1/2/3/4，分别代表关闭、机器人、人工、机器人和人工，四种状态下的留言显示";
        _applicationStage.font = [UIFont systemFontOfSize:12.f];
    }
    return _applicationStage;
}

- (UISwitch *)satisfactionModelSwitch {
    if (!_satisfactionModelSwitch) {
        // 创建一个UISwitch实例
        _satisfactionModelSwitch = [[UISwitch alloc] initWithFrame:CGRectMake(0, 55, 60, 40)];
        // 设置开关的初始状态
        _satisfactionModelSwitch.on = NO;
        // 添加开关值改变事件处理器
        [_satisfactionModelSwitch addTarget:self action:@selector(satisfactionModelSwitchValueChanged:) forControlEvents:UIControlEventValueChanged];
    }
    return _satisfactionModelSwitch;
}

- (UISwitch *)setUpQuickEntry {
    if (!_setUpQuickEntry) {
        
        UILabel *setUpQuickEntryLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, self.textField1.bottom_sd+5, 220, 40)];
        setUpQuickEntryLabel.text = @"开启后，则开启快捷入口设置，关闭则关闭快接入口设置";
        setUpQuickEntryLabel.numberOfLines = 0;
        setUpQuickEntryLabel.font = [UIFont systemFontOfSize:12.f];
        [self.view addSubview:setUpQuickEntryLabel];
        
        // 创建一个UISwitch实例
        _setUpQuickEntry = [[UISwitch alloc] initWithFrame:CGRectMake(0, setUpQuickEntryLabel.bottom_sd+5, 60, 40)];
        // 设置开关的初始状态
        _setUpQuickEntry.on = NO;
        // 添加开关值改变事件处理器
        [_setUpQuickEntry addTarget:self action:@selector(setUpQuickEntryValueChanged:) forControlEvents:UIControlEventValueChanged];
    }
    return _setUpQuickEntry;
}

- (void)setUpQuickEntryValueChanged:(UISwitch *)sender {
    self.setUpQuickEntryBool = sender.on;
}

- (UISwitch *)commentCountEnable {
    if (!_commentCountEnable) {
        
        UILabel *chatLeaveMessageStatusLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, self.applicationStage.bottom_sd + 5, 220, 60)];
        chatLeaveMessageStatusLabel.text = @"下列开关分别为：客服留言数量提示开关、仅查询和展示访客创建的工单、没有客服留言时不展示该快捷入口";
        chatLeaveMessageStatusLabel.numberOfLines = 0;
        chatLeaveMessageStatusLabel.font = [UIFont systemFontOfSize:12.f];
        [self.view addSubview:chatLeaveMessageStatusLabel];
        
        // 创建一个UISwitch实例
        _commentCountEnable = [[UISwitch alloc] initWithFrame:CGRectMake(0, chatLeaveMessageStatusLabel.bottom_sd+5, 60, 40)];
        // 设置开关的初始状态
        _commentCountEnable.on = YES;
        // 添加开关值改变事件处理器
        [_commentCountEnable addTarget:self action:@selector(commentCountEnableValueChanged:) forControlEvents:UIControlEventValueChanged];
    }
    return _commentCountEnable;
}

- (UISwitch *)visitorCreatedTicket {
    if (!_visitorCreatedTicket) {
        // 创建一个UISwitch实例
        _visitorCreatedTicket = [[UISwitch alloc] initWithFrame:CGRectMake(80, self.commentCountEnable.mj_y, 60, 40)];
        // 设置开关的初始状态
        _visitorCreatedTicket.on = NO;
        // 添加开关值改变事件处理器
        [_visitorCreatedTicket addTarget:self action:@selector(commentCountEnableValueChanged:) forControlEvents:UIControlEventValueChanged];
    }
    return _visitorCreatedTicket;
}

- (UISwitch *)noCommentCountHideQuickEntry {
    if (!_noCommentCountHideQuickEntry) {
        // 创建一个UISwitch实例
        _noCommentCountHideQuickEntry = [[UISwitch alloc] initWithFrame:CGRectMake(160, self.commentCountEnable.mj_y, 60, 40)];
        // 设置开关的初始状态
        _noCommentCountHideQuickEntry.on = NO;
        // 添加开关值改变事件处理器
        [_noCommentCountHideQuickEntry addTarget:self action:@selector(commentCountEnableValueChanged:) forControlEvents:UIControlEventValueChanged];
    }
    return _noCommentCountHideQuickEntry;
}

- (void)commentCountEnableValueChanged:(UISwitch *)sender {
    if ([sender isEqual:self.commentCountEnable]) {
        BOOL commentCountEnableOn = self.commentCountEnable.on;
        self.visitorCreatedTicket.hidden = !commentCountEnableOn;
        self.noCommentCountHideQuickEntry.hidden = !commentCountEnableOn;
    }
}

@end
