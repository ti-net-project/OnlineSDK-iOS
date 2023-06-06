//
//  TOSSessionInfoModel.h
//  TOSClientKit
//
//  Created by 高延波 on 2022/6/23.
//  Copyright © 2022 YanBo. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface TOSSessionInfoModel : NSObject

@property (nonatomic, copy) NSString *enterpriseId;

@property (nonatomic, copy) NSString *mainUniqueId;

@property (nonatomic, strong) NSNumber *startTime;
/// 会话状态(新打开 1;路由中 2;排队中 3;接通座席 4;留言中 5;满意度 6;关闭 7;接通机器人 8;座席主动发起会话 9;)
@property (nonatomic, strong) NSNumber *status;

@property (nonatomic, copy) NSString *visitorId;

@end

NS_ASSUME_NONNULL_END
