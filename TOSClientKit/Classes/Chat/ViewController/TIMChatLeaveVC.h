//
//  TIMChatLeaveVC.h
//  TIMClientKit
//
//  Created by apple on 2021/12/20.
//  Copyright © 2021 YanBo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TOSBaseViewController.h"
#import <TOSClientLib/ChatLeaveMessage.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^DidPopViewController)(void);

@interface TIMChatLeaveVC : TOSBaseViewController

@property (nonatomic, copy) NSString *welcomContent;//留言引导语
@property (nonatomic, copy) NSString *leaveTip;//留言成功提示语
@property (nonatomic, strong) NSMutableArray *leaveMessageFields;//数据源

@property (nonatomic, strong) ChatLeaveMessage *chatLeaveMessageMsg;

- (void)setDidPopViewController:(DidPopViewController)didPop;

@end

NS_ASSUME_NONNULL_END
