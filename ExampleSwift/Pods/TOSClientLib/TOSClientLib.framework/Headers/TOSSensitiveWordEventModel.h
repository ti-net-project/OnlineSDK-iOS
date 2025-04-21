//
//  TOSSensitiveWordEventModel.h
//  TOSClientLib
//
//  Created by 言 on 2022/10/28.
//  Copyright © 2022 YanBo. All rights reserved.
//

#import <TOSClientLib/TOSClientLib.h>

NS_ASSUME_NONNULL_BEGIN

@interface TOSSensitiveWordEventModel : TIMLibBaseModel

@property(nonatomic, copy) NSString *sensitiveWord;
@property(nonatomic, strong) NSNumber *messageType;
@property(nonatomic, strong) NSNumber *createTime;
@property(nonatomic, copy) NSString *mainUniqueId;
@property(nonatomic, strong) NSNumber *sendStatus;
@property(nonatomic, copy) NSString *message;
@property(nonatomic, strong) NSNumber *msgId;
@property(nonatomic, copy) NSString *messageUUID;

@end

NS_ASSUME_NONNULL_END
