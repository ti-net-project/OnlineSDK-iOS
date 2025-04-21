//
//  TOSMessageSmallProgramModel.h
//  TOSClientLib
//
//  Created by 言 on 2022/12/30.
//  Copyright © 2022 YanBo. All rights reserved.
//

#import <TOSClientLib/TOSClientLib.h>

NS_ASSUME_NONNULL_BEGIN

@interface TOSMessageSmallProgramModel : TIMMessageContent

@property (nonatomic, copy) NSString *cardType;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *pagepath;
@property (nonatomic, copy) NSString *picurl;
@property (nonatomic, copy) NSString *appid;
@property (nonatomic, copy) NSString *appLogo;
@property (nonatomic, copy) NSString *appName;
@property (nonatomic, copy) NSString *appSecret;

@end

NS_ASSUME_NONNULL_END
