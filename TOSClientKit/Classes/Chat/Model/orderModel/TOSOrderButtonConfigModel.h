//
//  TOSOrderButtonConfigModel.h
//  TOSClientKit
//
//  Created by 李成 on 2024/11/5.
//  Copyright © 2024 YanBo. All rights reserved.
//  订单抽屉列表中功能按钮的model

#import <TOSClientLib/TOSClientLib.h>
#import <TOSClientLib/TIMLibBaseModel.h>


NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, OrderButtonConfigType) {
    /// 发送卡片
    OrderButtonConfigTypeSendCard       = 0,
    /// 发送内容
    OrderButtonConfigTypeSendContent    = 1,
    /// 链接
    OrderButtonConfigTypeLink           = 2,
};

@interface TOSOrderButtonConfigModel : TIMLibBaseModel

/// 文案内容
@property (nonatomic, copy) NSString                * text;

/// 按钮类型
@property (nonatomic, assign) OrderButtonConfigType                type;

/// 发送内容的文案（ type = OrderButtonConfigTypeSendContent 时生效）
@property (nonatomic, copy) NSString                * content;

/// 链接的URL（ type = OrderButtonConfigTypeLink 时生效）
@property (nonatomic, copy) NSString                * linkUrl;

/// 按钮风格
@property (nonatomic, strong) NSDictionary                * style;

/// model转成字典
- (NSDictionary *)dictionaryRepresentation;

@end


@interface TOSOrderBottomButtonConfigModel : TIMLibBaseModel

/// 文案内容
@property (nonatomic, copy) NSString                * text;

/// 按钮类型
@property (nonatomic, assign) OrderButtonConfigType                type;

/// 发送内容的文案（ type = OrderButtonConfigTypeSendContent 时生效）
@property (nonatomic, copy) NSString                * content;

/// 链接的URL（ type = OrderButtonConfigTypeLink 时生效）
@property (nonatomic, copy) NSString                * linkUrl;

/// 按钮风格
@property (nonatomic, strong) NSDictionary                * style;

@property (nonatomic, copy) NSString                * target;

/// model转成字典
- (NSDictionary *)dictionaryRepresentation;

@end

NS_ASSUME_NONNULL_END
