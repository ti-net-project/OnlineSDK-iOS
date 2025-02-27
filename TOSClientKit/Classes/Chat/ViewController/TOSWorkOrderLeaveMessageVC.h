//
//  TOSWorkOrderLeaveMessageVC.h
//  TOSClientKit
//
//  Created by 言 on 2024/7/11.
//  Copyright © 2024 YanBo. All rights reserved.
//

#import <TOSClientKit/TOSClientKit.h>
#import <TOSClientLib/ChatLeaveMessage.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^DidPopViewController)(void);

@interface TOSWorkOrderLeaveMessageVC : TOSBaseViewController

@property (nonatomic, strong) ChatLeaveMessage *chatLeaveMessageMsg;

- (void)setDidPopViewController:(DidPopViewController)didPop;

@end

NS_ASSUME_NONNULL_END
