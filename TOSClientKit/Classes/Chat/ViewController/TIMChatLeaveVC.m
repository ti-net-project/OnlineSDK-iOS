//
//  TIMChatLeaveVC.m
//  TIMClientKit
//
//  Created by apple on 2021/12/20.
//  Copyright © 2021 YanBo. All rights reserved.
//

#import "TIMChatLeaveVC.h"
#import "chatLeaveTitleCell.h"
#import "chatLeaveSingleLineCell.h"
#import "chatLeaveMultilineLineCell.h"
#import "TIMConstants.h"
#import "kitUtils.h"
#import "WHToast.h"
#import <TOSClientLib/TOSClientLib.h>
//#import "UIView+SDExtension.h"
//#import "IQKeyboardManager.h"
#import "NSString+Extension.h"
#import "UIView+TIMYYAdd.h"
#import "NSObject+TIMShowError.h"
#import "YYReachability.h"

@interface TIMChatLeaveVC ()<UITableViewDelegate,UITableViewDataSource>//chatLeaveMultilineLineCellDelegate
{
    DidPopViewController _didPop;
}

@property (nonatomic, strong) UITableView *chatLeaveTableView;
@property (nonatomic, strong) UIView *bottomView;
@property (nonatomic, strong) UIButton *commitBtn;
@property (nonatomic, strong) UIButton *backBtn;
@property (nonatomic, strong) UIView *successView;//提交成功的view
@property (nonatomic, strong) NSMutableArray *cellIdList;//记录只加载一次


@end

@implementation TIMChatLeaveVC

- (void)setDidPopViewController:(DidPopViewController)didPop {
    _didPop = didPop;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"请您留言";
    [self setupSubView];
//    [self addNotificationAction];
    
    self.cellIdList = [[NSMutableArray alloc]init];

//    [self setKeyboardAction];
    // 禁用返回手势
    self.navigationController.interactivePopGestureRecognizer.enabled = NO;
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@/%@",FRAMEWORKS_BUNDLE_PATH,@"leaveMessage_back"]] style:(UIBarButtonItemStylePlain) target:self action:@selector(leftBarBtnItemAction:)];
}

- (void)leftBarBtnItemAction:(UIBarButtonItem *)sender {
    @WeakObj(self);
    
    YYReachabilityStatus status = [YYReachability reachability].status;
    if (status == YYReachabilityStatusNone) {
        if (self.successView.hidden) { //未提交
            [self tim_showMBErrorView:@"当前网络异常，请稍候重试。"];
        } else {
            if (self->_didPop) {
                self->_didPop();
            }
            [self popVC];
        }
        return;
    }
    
    if ([kitUtils isBlankString:self.chatLeaveMessageMsg.leaveReturnNext]) {
        
        if (!self.successView.hidden) { //已提交
            if (self->_didPop) {
                self->_didPop();
            }
            [self popVC];
            return;
        }
        
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"确认要离开吗？"
                                                                                 message:@"您还没有提交，离开将结束本次咨询"
                                                                          preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确认"
                                                           style:UIAlertActionStyleDefault
                                                         handler:^(UIAlertAction * _Nonnull action) {
            @StrongObj(self);
            if (self->_didPop) {
                self->_didPop();
            }
            [self popVC];
        }];
        
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消"
                                                               style:UIAlertActionStyleDefault
                                                             handler:nil];
        [alertController addAction:cancelAction];
        [alertController addAction:okAction];
        
        [self presentViewController:alertController animated:YES completion:nil];
    } else {
        
        [[OnlineMessageSendManager sharedOnlineMessageSendManager] sendEventMessageWithEvent:@"chatSwitchReturn" messageUUID:[[NSUUID UUID] UUIDString] success:^(TOSMessage * _Nonnull timMessage) {
            @StrongObj(self);
            [self popVC];
        } error:^(TIMConnectErrorCode errCode, NSString * _Nonnull errorDes) {
            @StrongObj(self);
            [self popVC];
        }];
    }
}

-(void)setupSubView{
    [self.view addSubview:self.bottomView];
    
    [self.view addSubview:self.chatLeaveTableView];
    [self.bottomView addSubview:self.commitBtn];
    [self.bottomView addSubview:self.backBtn];
    [self.view addSubview:self.successView];
    self.successView.hidden = YES;
}

#pragma mark tableview
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.leaveMessageFields.count+1;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row == 0) {
        NSString * identifier = [NSString stringWithFormat:@"CellId%ld%ld",(long)indexPath.section,(long)indexPath.row];
        chatLeaveTitleCell *titleCell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (!titleCell) {
            titleCell = [[chatLeaveTitleCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identifier];
        }
        titleCell.title = self.welcomContent;

        return titleCell;
    }
    
    NSDictionary*dict = self.leaveMessageFields[indexPath.row - 1];
    NSString*type = [NSString stringWithFormat:@"%@",dict[@"type"]];

    if (![kitUtils isBlankString:type]) {
        if ([type isEqualToString:@"0"]) {//单选
            NSString * identifier = [NSString stringWithFormat:@"CellId%ld%ld",(long)indexPath.section,(long)indexPath.row];
            chatLeaveSingleLineCell *singleCell = [tableView dequeueReusableCellWithIdentifier:identifier];
            if (!singleCell) {
                singleCell = [[chatLeaveSingleLineCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identifier];
            }
            if (![kitUtils isBlankString:dict[@"name"]]) {
                [singleCell setCellWithTitle:[NSString stringWithFormat:@"%@",dict[@"name"]] must:[NSString stringWithFormat:@"%@",dict[@"must"]]];
            }
            return singleCell;
        }else
            if ([type isEqualToString:@"1"]) {//多选
            NSString * identifier = [NSString stringWithFormat:@"CellId%ld%ld",(long)indexPath.section,(long)indexPath.row];
            chatLeaveMultilineLineCell *multilineCell = [tableView dequeueReusableCellWithIdentifier:identifier];
            if (!multilineCell) {
                multilineCell = [[chatLeaveMultilineLineCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identifier];
            }
                
//            int j = 0;
//            if (self.cellIdList.count>0) {
//                for (NSString*ident in self.cellIdList) {
//                    if ([ident isEqualToString:identifier]) {//加载过了
//                        j = 1;
//                    }
//                }
//            }
//            if (j == 0) {
//                [self.cellIdList addObject:identifier];
//            }
                
            if (![kitUtils isBlankString:dict[@"name"]]) {
                [multilineCell setCellWithTitle:[NSString stringWithFormat:@"%@",dict[@"name"]] must:[NSString stringWithFormat:@"%@",dict[@"must"]] index:indexPath];
//                multilineCell.multilineDelegate = self;
            }

            return multilineCell;
        }
    }

    //防止为空情况崩溃
    UITableViewCell *lineCell = [tableView dequeueReusableCellWithIdentifier:@"CellId"];
    if (!lineCell) {
        lineCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"CellId"];
    }
    return lineCell;

}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row == 0) {
//        CGSize size = [self.welcomContent sizewithfont];
        return 80;
    }
    NSDictionary*dict = self.leaveMessageFields[indexPath.row - 1];
    NSString*type = [NSString stringWithFormat:@"%@",dict[@"type"]];

    if (![kitUtils isBlankString:type]) {
        if ([type isEqualToString:@"0"]) {//单选
            return 90;
        }else if ([type isEqualToString:@"1"]) {//多选
            return 110;
        }
    }
    
    return 90;
}

//- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
//    
//    [[[UIApplication sharedApplication] keyWindow] endEditing:YES];
//}


#pragma mark 初始化
-(UITableView *)chatLeaveTableView
{
    if (nil == _chatLeaveTableView) {
        _chatLeaveTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0,App_Frame_Width , APP_Frame_Height - kNavTop - self.bottomView.tos_height) style:UITableViewStylePlain];
        _chatLeaveTableView.delegate = self;
        _chatLeaveTableView.dataSource = self;
        _chatLeaveTableView.backgroundColor = [UIColor whiteColor];
        _chatLeaveTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _chatLeaveTableView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
        if (@available(iOS 15.0, *)) {
            _chatLeaveTableView.sectionHeaderTopPadding = 0.f;
            [UITableView appearance].sectionHeaderTopPadding = 0.f;
        }
    }
    return _chatLeaveTableView;
}

- (UIView *)bottomView {
    if (!_bottomView) {
        _bottomView = [[UIView alloc] init];
        _bottomView.backgroundColor = TOSHexAColor(0xFFFFFF,1.0);
        CGFloat height = 54.f+kBottomBarHeight;
        _bottomView.frame = CGRectMake(0, APP_Frame_Height-height-kNavTop, App_Frame_Width, height);
    }
    return _bottomView;
}

-(UIButton *)commitBtn{
    if (!_commitBtn) {
        _commitBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        if ([kitUtils isBlankString:self.chatLeaveMessageMsg.leaveReturnNext]) {
            _commitBtn.frame = CGRectMake(16.f, 8.f, App_Frame_Width - 32.f, 38.f);
        } else {
            _commitBtn.frame = CGRectMake(self.backBtn.tos_right + 12.f, 8.f, self.backBtn.tos_width, 38.f);
        }
        [_commitBtn setBackgroundColor:TOSHexAColor(0x4385FF,1.0)];
        [_commitBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_commitBtn setTitle:@"提交" forState:UIControlStateNormal];
        _commitBtn.layer.masksToBounds = YES;
        _commitBtn.layer.cornerRadius = 6.0f;
        [_commitBtn addTarget:self action:@selector(commitAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _commitBtn;
}

- (UIButton *)backBtn {
    if (!_backBtn) {
        _backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        if ([kitUtils isBlankString:self.chatLeaveMessageMsg.leaveReturnNext]) {
            _backBtn.frame = CGRectZero;
        } else {
            _backBtn.frame = CGRectMake(16.f, 8.f, (App_Frame_Width - 32.f - 12.f) / 2, 38.f);
        }
        [_backBtn setBackgroundColor:TOSHexAColor(0xFFFFFF,1.0)];
        [_backBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_backBtn setTitle:@"返回" forState:UIControlStateNormal];
        [_backBtn setTitleColor:TOSHexColor(0x262626) forState:(UIControlStateNormal)];
        _backBtn.layer.masksToBounds = YES;
        _backBtn.layer.cornerRadius = 6.0f;
        _backBtn.layer.borderWidth = .5f;
        _backBtn.layer.borderColor = TOSHexColor(0xE5E5E5).CGColor;
        [_backBtn addTarget:self action:@selector(backBtnAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _backBtn;
}

-(UIView *)successView{
    if (!_successView) {
        _successView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, App_Frame_Width, APP_Frame_Height)];
        _successView.backgroundColor = [UIColor whiteColor];
        
        UIImageView*successIcon = [[UIImageView alloc]initWithFrame:CGRectMake((App_Frame_Width - 120.f)/2, (APP_Frame_Height - 120.f)/2 - kBottomBarHeight - kNavTop - 44.f, 120.f, 120.f)];
        successIcon.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@/%@",FRAMEWORKS_BUNDLE_PATH,@"leaveMessage_success"]];
        [_successView addSubview:successIcon];
        
        UILabel*title = [[UILabel alloc]initWithFrame:CGRectMake(0, successIcon.tos_bottom, App_Frame_Width, 22.f)];
        title.textColor = TOSHexColor(0x262626);
        title.textAlignment = NSTextAlignmentCenter;
        title.font = [UIFont fontWithName:@"PingFangSC-Medium" size:14.0f];
        title.text = @"留言成功";
        [_successView addSubview:title];
        
        UILabel*subtitle = [[UILabel alloc]initWithFrame:CGRectMake(16.f, title.tos_bottom+8.f, App_Frame_Width - 32.f, APP_Frame_Height - 100)];
        subtitle.textColor = TOSHexColor(0x8C8C8C);
        subtitle.font = [UIFont fontWithName:@"PingFangSC-Regular" size:14.0f];
        subtitle.textAlignment = NSTextAlignmentCenter;
        subtitle.numberOfLines = 0;
        subtitle.text = [NSString stringWithFormat:@"%@",self.leaveTip];//@"我们将尽快与您取得联系并解决您的问题";
        
        CGSize size = [subtitle.text tim_sizeWithMaxWidth:App_Frame_Width - 32.f andFont:[UIFont fontWithName:@"PingFangSC-Regular" size:14.0f]];
        subtitle.tos_height = size.height;
        [_successView addSubview:subtitle];
        
        UIButton *closeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        closeBtn.frame = CGRectMake(16.f, APP_Frame_Height-54.f-kBottomBarHeight-kNavTop+8.f, App_Frame_Width - 32.f, 38.f);
        [closeBtn setBackgroundColor:TOSHexColor(0x4385FF)];
        [closeBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [closeBtn setTitle:@"返回" forState:UIControlStateNormal];
        closeBtn.layer.masksToBounds = YES;
        closeBtn.layer.cornerRadius = 6.0f;
        [closeBtn addTarget:self action:@selector(closeBtnAction) forControlEvents:UIControlEventTouchUpInside];
        [_successView addSubview:closeBtn];
    }
    return _successView;
}

- (void)backBtnAction{
    @WeakObj(self);
    
    YYReachabilityStatus status = [YYReachability reachability].status;
    if (status == YYReachabilityStatusNone) {
        [self tim_showMBErrorView:@"当前网络异常，请稍候重试。"];
        return;
    }
    
    [[OnlineMessageSendManager sharedOnlineMessageSendManager] sendEventMessageWithEvent:@"chatSwitchReturn" messageUUID:[[NSUUID UUID] UUIDString] success:^(TOSMessage * _Nonnull timMessage) {
        @StrongObj(self);
        [self popVC];
    } error:^(TIMConnectErrorCode errCode, NSString * _Nonnull errorDes) {
        @StrongObj(self);
        [self popVC];
    }];
}

- (void)closeBtnAction {
    if (self->_didPop) {
        self->_didPop();
    }
    [self popVC];
}

//提交
-(void)commitAction{
    
    YYReachabilityStatus status = [YYReachability reachability].status;
    if (status == YYReachabilityStatusNone) {
        [self tim_showMBErrorView:@"当前网络异常，请稍候重试。"];
        return;
    }
    
   __block int ifSuccess = 1;
    
    if (self.leaveMessageFields.count>0) {
        NSMutableDictionary*uploadDict = [[NSMutableDictionary alloc]init];
        for (int i = 0; i<self.leaveMessageFields.count; i++) {
            NSDictionary*dict = self.leaveMessageFields[i];
            NSString*type = [NSString stringWithFormat:@"%@",dict[@"type"]];
            if (![kitUtils isBlankString:type]) {
                if ([type isEqualToString:@"0"]) {//单选
                    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:i+1 inSection:0];
                    chatLeaveSingleLineCell *singleCell = [self.chatLeaveTableView cellForRowAtIndexPath:indexPath];
                    NSString*singleStr = [NSString stringWithFormat:@"%@",singleCell.textField.text];
                    NSString*mustStr = [NSString stringWithFormat:@"%@",dict[@"must"]];
                    if (singleStr.length == 0  && [mustStr isEqualToString:@"1"]) {
                        [WHToast showMessage:[NSString stringWithFormat:@"%@为必填项",dict[@"name"]] duration:1 finishHandler:^{
                        }];
                        ifSuccess = 0;
                        return;
                    }
                    [uploadDict setObject:singleStr forKey:[NSString stringWithFormat:@"%@",dict[@"name"]]];
                }else if ([type isEqualToString:@"1"]) {//多选
                    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:i+1 inSection:0];
                    chatLeaveMultilineLineCell *multilineCell = [self.chatLeaveTableView cellForRowAtIndexPath:indexPath];
                    NSString*multilineStr = [NSString stringWithFormat:@"%@",multilineCell.textView.text];
                    NSString*mustStr = [NSString stringWithFormat:@"%@",dict[@"must"]];
                    if (multilineStr.length == 0  && [mustStr isEqualToString:@"1"]) {
                        [WHToast showMessage:[NSString stringWithFormat:@"%@为必填项",dict[@"name"]] duration:1 finishHandler:^{
                        }];
                        ifSuccess = 0;
                        return;
                    }
                    [uploadDict setObject:multilineStr forKey:[NSString stringWithFormat:@"%@",dict[@"name"]]];

                }
            }
        }
        
        if (ifSuccess == 1) {
            
            WEAKSELF
            [[OnlineEventSendManager sharedOnlineEventSendManager]upLoadChatLeaveMessageEventWithPayloads:uploadDict
                                                                                                  success:^{
                weakSelf.chatLeaveTableView.hidden = YES;
                weakSelf.commitBtn.hidden = YES;
                weakSelf.successView.hidden = NO;
                
            } error:^(TIMConnectErrorCode errCode, NSString * _Nonnull errorDes) {
                [WHToast showMessage:@"提交失败" duration:2 finishHandler:^{

                }];
            }];
        }
    }
}


#pragma mark chatLeaveMultilineLineCellDelegate
//-(void)scrollerToIndex:(NSIndexPath *)index{
////    if (self.chatLeaveTableView.height<APP_Frame_Height -kNavTop - kBottomBarHeight  - 100) {
////        [self.chatLeaveTableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:index.row inSection:0] atScrollPosition:UITableViewScrollPositionBottom animated:NO];
////    }
//}
//
//
//
//-(void)addNotificationAction{
//    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
//    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
//}
//
//#pragma mark 键盘出现
//- (void)keyboardWillShow:(NSNotification*)note
//{
//    CGRect keyBoardRect=[note.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
//    
////    self.chatLeaveTableView.contentInset= UIEdgeInsetsMake(0,0, keyBoardRect.size.height,0);
//    self.chatLeaveTableView.height = APP_Frame_Height -kNavTop - kBottomBarHeight  - keyBoardRect.size.height;
////    [self innerScrollToBottom];
//}
//
//#pragma mark 键盘消失
//- (void)keyboardWillHide:(NSNotification*)note
//{
////    self.chatLeaveTableView.contentInset = UIEdgeInsetsZero;
//    self.chatLeaveTableView.height = APP_Frame_Height -kNavTop - kBottomBarHeight  - 100;
//
//}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}

- (void)dealloc {
    NSLog(@"dealloc");
}

- (void)popVC {
    if (self.navigationController) {
        [self.navigationController popViewControllerAnimated:YES];
    } else {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

@end
