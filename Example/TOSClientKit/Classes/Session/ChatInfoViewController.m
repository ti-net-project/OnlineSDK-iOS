//
//  ChatInfoViewController.m
//  TIMClientKitDemo
//
//  Created by 赵言 on 2021/4/29.
//  Copyright © 2021 YanBo. All rights reserved.
//

#import "ChatInfoViewController.h"
//#import "STBaseWebViewController.h"
#import "customTableViewCell.h"
#import "customTypeEventQueueTableViewCell.h"
#import "CustomFileTableViewCell.h"
#import "CustomRefreshHeader.h"
//#import "MYHTZImagePickerController.h"
//#import "ICMediaManager.h"

#import "UIView+Util.h"

#import "NextViewController.h"

@interface ChatInfoViewController ()<TIMOnlineQueueDelegate>

@end

@implementation ChatInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[TOSClientKit sharedTOSKit] setTIMOnlineQueueDelegate:self];
    
    TOSKitExtendBoardItemModel *model1 = [[TOSKitExtendBoardItemModel alloc] init];
    model1.type = TOSChatBoxExtendBoardTypePhotos;
    model1.title = @"";
    model1.image = @"";
    model1.index = 1;

    TOSKitExtendBoardItemModel *model2 = [[TOSKitExtendBoardItemModel alloc] init];
    model2.type = TOSChatBoxExtendBoardTypeTakePicture;
    model2.title = @"";
    model2.image = @"";
    model2.index = 2;

    TOSKitExtendBoardItemModel *model3 = [[TOSKitExtendBoardItemModel alloc] init];
    model3.type = TOSChatBoxExtendBoardTypeCustomFile;
    model3.title = @"";
    model3.image = @"";
    model3.index = 3;
    
    TOSKitExtendBoardItemModel *model4 = [[TOSKitExtendBoardItemModel alloc] init];
    model4.type = TOSChatBoxExtendBoardTypeArtificial;
    model4.title = @"";
    model4.image = @"";
    model4.index = 4;
    
    TOSKitExtendBoardItemModel *model5 = [[TOSKitExtendBoardItemModel alloc] init];
    model5.type = TOSChatBoxExtendBoardTypeCloseChat;
    model5.title = @"";
    model5.image = @"";
    model5.index = 5;
    
    TOSKitExtendBoardItemModel *model6 = [[TOSKitExtendBoardItemModel alloc] init];
    model6.type = TOSChatBoxExtendBoardTypeCustom;
    model6.title = @"连发图片和视频";
    model6.image = @"";
    model6.index = 6;
    
    TOSKitExtendBoardItemModel *model7 = [[TOSKitExtendBoardItemModel alloc] init];
    model7.type = TOSChatBoxExtendBoardTypeCustom;
    model7.title = @"满意度评价";
    model7.image = @"";
    model7.index = 7;
    
    TOSKitExtendBoardItemModel *model8 = [[TOSKitExtendBoardItemModel alloc] init];
    model8.type = TOSChatBoxExtendBoardTypeCustomFileApp;
    model8.title = @"";
    model8.image = @"";
    model8.index = 8;
    
    NSMutableArray *array = [NSMutableArray arrayWithArray:@[model1,model2,model3,model4,model5,model6,model7,model8]];
    
    [TOSKitChatBoxExtendBoard shareChatBoxExtendBoard].allItems = array;
    
    [TOSKitChatBoxExtendBoard shareChatBoxExtendBoard].onlineChange = YES;
    TOSKitChatBoxExtendBoard.shareChatBoxExtendBoard.onlienAllItems = @[model1,model2,model3,model4,model5,model6,model7,model8];
    
    /// 防止循环引用需要__weak
    __weak typeof(self) weakself = self;
    self.customRefreshHeader = [CustomRefreshHeader headerWithRefreshingBlock:^{
        __strong typeof(self) strongself = weakself;
        [strongself loadMoreMessage];
    }];
    
    
//    if (self.rewriteBack) {
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:(UIBarButtonItemStylePlain) target:self action:@selector(backTouch)];
//    }
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"跳转" style:(UIBarButtonItemStylePlain) target:self action:@selector(justNext)];
    
    self.view.backgroundColor = TOSHexColor(0xEFF0F3);
}

/// 当前会话状态监听
- (void)chatStatusChanged:(TinetChatStatusType)status {
    [super chatStatusChanged:status];
    
    if (self.setUpQuickEntryBool) {    
        
        if (self.quickEntryAcquiesceItems.count <= 0) {
            switch (status) {
                case TinetChatStatusTypeOutline: {  // 不在线或结束会话
                    NSLog(@"触发了不在线或结束会话回调");
                    [self updateSessionWindowQuickEntrys:self.quickEntryRobotItems];
                }
                    break;
                case TinetChatStatusTypeRobot: {    // 机器人在线
                    NSLog(@"触发了机器人在线回调");
                    [self updateSessionWindowQuickEntrys:self.quickEntryRobotItems];
                }
                    break;
                case TinetChatStatusTypeOnline: {   // 客服在线
                    NSLog(@"触发了客服在线回调");
                    [self updateSessionWindowQuickEntrys:self.quickEntryOnlineItems];
                }
                    break;
                default:
                    break;
            }
        }
    }
}

- (void)justNext {
    NextViewController * nextVC = [[NextViewController alloc] init];
    [self.navigationController pushViewController:nextVC animated:YES];
    
}

- (void)didClinkCustomExtendBoardItemAction:(TOSKitExtendBoardItemModel *)item {
    NSLog(@"%@",[item yy_modelToJSONObject]);
    if (item.index == 6) {
//        [self tosClientDemoOpenPicker];
    }
    if (item.index == 7) {
        [self tosVisitorSendInvestigation];
    }
    
    if (item.type == TOSChatBoxExtendBoardTypeLink) {
        NSLog(@"点击了外链：%@", item.dynamicConfigParameters);
//        [MBProgressHUD showMBErrorView:[NSString stringWithFormat:@"点击了更多面板的外链，参数为%@", item.dynamicConfigParameters]];
    }
    if (item.type == TOSChatBoxExtendBoardTypeCustom) {
        NSLog(@"点击了自定义");
//        [MBProgressHUD showMBErrorView:[NSString stringWithFormat:@"点击了更多面板的%@", item.title]];
    }
    
}

- (void)bariItemDidTouchIndex:(NSInteger)index {
    //    [super bariItemDidTouchIndex:index];
    
    NSLog(@"bariItemDidTouchIndex       %ld", index);
    
}

- (void)quickEntryItemDidTouchModel:(TOSQuickEntryModel *)model {
    [super quickEntryItemDidTouchModel:model];
    
    NSLog(@"快捷入口点击的数据：%@", model.params);
//    [MBProgressHUD showMBErrorView:[NSString stringWithFormat:@"点击了快捷按钮的：%@", model.name]];
    
//    if (index == 0) {
//        [self tosVisitorSendInvestigation];
//    } else if (index == 1) {
//        [self sendTransferToHumanMessage:@"转人工消息"];
//    } else {
//        TOSClientKitCommodityCardOption *option = [[TOSClientKitCommodityCardOption alloc] init];
//        option.subTitle = @"快捷区域 华为P40麒麟990 ";
//        option.descriptions = @"快捷区域 这是商品描述，啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦";
//        option.price = @"100.99100.99100";
//        option.time = @"2022/05/24 18:32:55";
//        option.img = @"https://lmg.jj20.com/up/allimg/tp09/210F2130512J47-0-lp.jpg";
//    //    option.status = @"快捷区域 已到货";
//        option.extraInfo = @[@{@"name": @"订单号", @"value": @"1234567890"},
//                             @{@"name": @"产品类型", @"value": @"快捷区域 电子产品"},
//                             @{@"name": @"师傅"   , @"value": @"快捷区域 金师傅"},
//                             @{@"name": @"服务地区", @"value": @"快捷区域 北京市"},
//                             @{@"name": @"服务"   , @"value": @"满意"},
//                             @{@"name": @"师傅电话", @"value": @"12345678900"},
//                             @{@"name": @"订单状态", @"value": @"已完成"}];
//        option.url = @"https://hellojoy.jd.com/";
//    //    option.title = @"华为P40快捷区域";
//        option.subUrl = @"https://p4psearch.1688.com/";
//    //    option.buttonText = @"快捷区域";
//    //    option.extraData = @"";
//        
//        [self sendCard:option];
//    }
}

//- (void)closeViewEvent {
//    NSLog(@"重写了结束会话的功能事件");
//    if (self.isRewriteClose) {
//        
//    }
//    else {
//        [super closeViewEvent];
//    }
//    
//    
//}

- (void)tableViewContentOffset:(CGPoint)contentOffset withMessageHeight:(CGFloat)messageHeight {
//    NSLog(@"Horizontal offset: %f, Vertical offset: %f, 消息列表的高度：%f", contentOffset.x, contentOffset.y, messageHeight);
}

/// 返回按钮的点击
- (void)backTouch {
    [self investigationAlert];
    
}

#pragma mark - TIMOnlineQueueDelegate

- (void)chatBridge:(ChatBridgeMessage *)message {
//    [MBProgressHUD showMBErrorView:@"排队结束"];
}

- (void)chatQueue:(ChatQueueMessage *)message {
    NSLog(@"放弃排队是否启用：%ld", (long)message.abandonEnabled);
//    [MBProgressHUD showMBErrorView:@"进入排队"];
}

- (void)chatQueueLocation:(ChatLocationMessage *)message {
    
//    [MBProgressHUD showMBErrorView:@"排队播报"];
    
}

- (void)exitChatQueue {
    
    
//    [MBProgressHUD showMBErrorView:[NSString stringWithFormat:@"退出排队"]];
}



- (void)tinet_textMessageClickAction:(TinetClickTextMessageEventType)eventType userInfo:(NSDictionary *)userInfo {
    [super tinet_textMessageClickAction:eventType userInfo:userInfo];
    
    if (eventType == TinetClickOrderCard) {
        NSLog(@"商品卡片点击后传递过来的数据：%@", userInfo);
        if ([userInfo objectForKey:@"content"]) {
            NSDictionary * content = userInfo[@"content"];
            if ([content objectForKey:@"productModel"]) {
//                [self justNext];
                UIViewController *topViewController = [self getTopViewController];
                
                NSLog(@"rootNavController ： %@", [topViewController class]);
                NextViewController *targetVC = [[NextViewController alloc] init];
                if (topViewController.navigationController) {
                    
                    [topViewController.navigationController pushViewController:targetVC animated:YES];
                    
                }
                else {
                    targetVC.modalPresentationStyle = UIModalPresentationCustom;
                    [topViewController presentViewController:targetVC animated:YES completion:nil];
                }
            }
        }
    }

    
    /// 超链接点击事例
    if (eventType == TinetClickEventTypePhone) {
        NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"telprompt://%@",userInfo[@"content"]?:@""]];
        if (@available(iOS 10.0, *)) {
            [UIApplication.sharedApplication openURL:url options:@{} completionHandler:^(BOOL success) {
                if (success) {
                    NSLog(@"拨打电话成功");
                } else {
                    NSLog(@"拨打电话失败");
                }
            }];
        } else {
            [UIApplication.sharedApplication openURL:url];
        }
    }
    
//    /// 超链接点击事例
//    if (eventType == TinetClickEventTypeUrl) {
//        STBaseWebViewController * webView = [[STBaseWebViewController alloc] init];
//        webView.urlString = [NSString stringWithFormat:@"%@", userInfo[@"content"]];
//        [self.navigationController pushViewController:webView animated:YES];
//    }
    
//    if (eventType == TinetClickMiniProgramCard) {
//        STBaseWebViewController * webView = [[STBaseWebViewController alloc] init];
//        webView.urlString = [NSString stringWithFormat:@"%@", userInfo[@"content"][@"pagepath"]?:@""];
//        [self.navigationController pushViewController:webView animated:YES];
//    }
//
//    if (eventType == TinetClickLogisticsCard) {
//        STBaseWebViewController * webView = [[STBaseWebViewController alloc] init];
//        webView.urlString = [NSString stringWithFormat:@"%@", userInfo[@"content"][@"orderLink"]?:@""];
//        [self.navigationController pushViewController:webView animated:YES];
//    }
    
    [self showMBErrorView:[NSString stringWithFormat:@"%ld ========= %@",eventType,userInfo]];
}

- (UIViewController *)getTopViewController {
    UIViewController *rootViewController = [UIApplication sharedApplication].keyWindow.rootViewController;
    return [self findTopViewController:rootViewController];
}

- (UIViewController *)findTopViewController:(UIViewController *)viewController {
    if (viewController.presentedViewController) {
        // 如果有模态弹出的视图控制器，继续递归
        return [self findTopViewController:viewController.presentedViewController];
    } else if ([viewController isKindOfClass:[UINavigationController class]]) {
        // 如果是导航控制器，返回可见视图控制器
        UINavigationController *nav = (UINavigationController *)viewController;
        return [self findTopViewController:nav.visibleViewController];
    } else if ([viewController isKindOfClass:[UITabBarController class]]) {
        // 如果是标签控制器，返回选中的视图控制器
        UITabBarController *tab = (UITabBarController *)viewController;
        return [self findTopViewController:tab.selectedViewController];
    } else {
        // 返回当前视图控制器
        return viewController;
    }
}

- (TOSChatCustomBaseTableViewCell *)customTableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath withModel:(nonnull TIMMessageModel *)model {
    TOSChatCustomBaseTableViewCell * cell ;
    
    NSLog(@"消息的内容： %@   messageId : %@  type : %@", model.message.content, model.message.messageId, model.message.type);
    if ([model.message.type isEqualToString:@"GXText"]) {
        customTableViewCell * customCell = [tableView dequeueReusableCellWithIdentifier:@"customTableViewCell"];
        if (!customCell) {
            customCell = [[customTableViewCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:@"customTableViewCell"];
        }
        customCell.textLabel.text = model.message.content;
        return customCell;
    }
    if ([model.message.type isEqualToString:@"TypeEventQueue"]) {
        customTypeEventQueueTableViewCell * customCell = [tableView dequeueReusableCellWithIdentifier:@"customTableViewCell"];
        if (!customCell) {
            customCell = [[customTypeEventQueueTableViewCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:@"customTableViewCell"];
        }
        customCell.textLabel.text = model.message.content;
        return customCell;
    }
    if ([model.message.type isEqualToString:@"GXCustomFile"]) {
        CustomFileTableViewCell * customCell = [tableView dequeueReusableCellWithIdentifier:@"CustomFileTableViewCell"];
        if (!customCell) {
            customCell = [[CustomFileTableViewCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:@"CustomFileTableViewCell"];
        }
        customCell.model = model;
        return customCell;
    }
    
    
    return cell;
}
- (void)tosVisitorSendInvestigation{
    
    [[OnlineRequestManager sharedCustomerManager] getInvestigationUniqueIdSuccess:^(NSString * _Nonnull messageUniqueId) {
        
    } error:^(TIMConnectErrorCode errCode, NSString * _Nonnull errorDes) {
        NSLog(@"获取满意度弹窗的uniqueid报错：%ld   请求体：%@", errCode, errorDes);
        [self showMBErrorView:[NSString stringWithFormat:@"%@",errorDes]];
    }];
}
@end
