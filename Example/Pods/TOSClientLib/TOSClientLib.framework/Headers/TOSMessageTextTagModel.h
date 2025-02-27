//
//  TOSMessageTextTagModel.h
//  TOSClientLib
//
//  Created by 言 on 2022/9/13.
//  Copyright © 2022 YanBo. All rights reserved.
//

#import <TOSClientLib/TOSClientLib.h>

NS_ASSUME_NONNULL_BEGIN

@interface TOSMessageTextSubTagModel : TIMMessageContent

@property (nonatomic, copy) NSString *text;
@property (nonatomic, copy) NSString *bgColor;

@end

@interface TOSMessageTextTagModel : TIMMessageContent

@property (nonatomic, copy) NSString *text;
@property (nonatomic, strong) NSArray <NSString *>*data;

@property (nonatomic, strong) NSArray <TOSMessageTextSubTagModel *>*tags;

@end

NS_ASSUME_NONNULL_END
