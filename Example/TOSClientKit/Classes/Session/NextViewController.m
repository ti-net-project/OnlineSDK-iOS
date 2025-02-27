//
//  NextViewController.m
//  TOSClientKitDemo
//
//  Created by 李成 on 2024/4/16.
//  Copyright © 2024 YanBo. All rights reserved.
//

#import "NextViewController.h"
#import "ChatInfoViewController.h"
#import "LoginModel.h"

@interface NextViewController ()

@end

@implementation NextViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"子级页面";
    
    self.view.backgroundColor = [UIColor orangeColor];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"聊天" style:(UIBarButtonItemStyleDone) target:self action:@selector(justChat)];
    
    
}

/// 跳转聊天
- (void)justChat {
    LoginModel *model = [LoginModel loginModel];
    TOSConnectOption * connectOption = [[TOSConnectOption alloc] initWithOption:model.userId?:@""
                                                                       nickname:model.nickname?:@""
                                                                        headUrl:model.headerUrl?:@""
                                                                         mobile:model.phoneNumber?:@""
                                                                  advanceParams:model.advanceParams?:@{}];
    connectOption.externalId = model.externalId;
    
    [[TOSClientKit sharedTOSKit] connect:connectOption success:^{
        
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
        NSMutableArray <TOSQuickEntryModel *>*quickEntryRobotItems = [NSMutableArray array];
        
        [[@"测试1-测试2-测试3" componentsSeparatedByString:@"-"] enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            
            TOSQuickEntryModel *model = [[TOSQuickEntryModel alloc] init];
            model.name = obj;
            model.value = obj;
            model.eventName = obj;
            model.dynamicConfigParameters = [NSMutableDictionary dictionary];
            [quickEntryRobotItems addObject:model];
        }];
        chatVC.quickEntryRobotItems = quickEntryRobotItems;
        
        NSMutableArray <TOSQuickEntryModel *>*quickEntryOnlineItems = [NSMutableArray array];
        [[@"测试4-测试5-测试6" componentsSeparatedByString:@"-"] enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            
            TOSQuickEntryModel *model = [[TOSQuickEntryModel alloc] init];
            model.name = obj;
            model.value = obj;
            model.eventName = obj;
            model.dynamicConfigParameters = [NSMutableDictionary dictionary];
            [quickEntryOnlineItems addObject:model];
        }];
        chatVC.quickEntryOnlineItems = quickEntryOnlineItems;
            
        self.hidesBottomBarWhenPushed  = YES;
        [self.navigationController pushViewController:chatVC animated:YES];
    } error:^(TIMConnectErrorCode errCode, NSString * _Nonnull errorDes) {
        NSLog(@"errorDes === %@",errorDes);
        
    } tokenIncorrect:^{
        NSLog(@"tokenIncorrect");
    }];
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
