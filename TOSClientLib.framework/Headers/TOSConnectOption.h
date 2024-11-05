//
//  TOSConnectOption.h
//  TOSClientLib
//
//  Created by 高延波 on 2022/6/23.
//  Copyright © 2022 YanBo. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface TOSConnectOption : NSObject

/**
 访客Id
 */
@property(nonatomic,readonly) NSString * visitorId;

/**
 昵称
 */
@property(nonatomic, readonly) NSString *nickname;

/**
 头像url
 */
@property(nonatomic, readonly) NSString *headUrl;

/**
 手机号
 */
@property(nonatomic, readonly) NSString *mobile;

/**
 外部id
 */
@property(nonatomic, copy) NSString *externalId;

/**
 附加参数
 */
@property(nonatomic, readonly) NSDictionary *advanceParams;

/// 自动创建客户资料
@property (nonatomic, strong) NSDictionary                * customerFields;

/**
 参数对象初始化方法
 @return                参数对象
 */

- (instancetype)initWithOption:(NSString *)visitorId nickname:(NSString *)nickname headUrl:(NSString *)headUrl mobile:(NSString *)mobile advanceParams:(NSDictionary *)advanceParams;


/// 初始化方法（需要更新客户资料使用该方法，前置条件为在配置中开启了【自动创建客户资料】）
/// @param visitorId 访客ID
/// @param nickname 昵称
/// @param headUrl 头像地址
/// @param mobile 手机号
/// @param advanceParams 自定义参数
/// @param customerFields 自定义更新客户资料
- (instancetype)initWithOption:(NSString *)visitorId nickname:(NSString *)nickname headUrl:(NSString *)headUrl mobile:(NSString *)mobile advanceParams:(NSDictionary *)advanceParams customerFields:(NSDictionary *)customerFields;

/// 重置附加参数
/// @param advanceParams 附加参数
- (void)resetAdvanceParams:(NSDictionary *)advanceParams;

@end

NS_ASSUME_NONNULL_END
