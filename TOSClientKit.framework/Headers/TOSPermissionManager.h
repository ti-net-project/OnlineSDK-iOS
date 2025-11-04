//
//  TOSPermissionManager.h
//  TOSClientKit
//
//  Created by AI Assistant on 2025/09/26.
//  Copyright © 2025 TiNet. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class TOSPermissionManager;

/**
 * 权限管理代理协议
 * 用于将权限请求的决策权交给上层应用
 */
@protocol TOSPermissionManagerDelegate <NSObject>

@optional
/**
 * 请求相机权限（摄像头、麦克风和相册）的代理方法
 * 当用户首次请求相机权限时，SDK 会调用此方法让上层应用决定如何处理
 * 相册权限是用于将拍摄的图片或视频保存到相册
 *
 * @param manager 权限管理器实例
 * @param completion 完成回调，上层应用需要在适当的时机调用此回调，传入是否授权的结果
 */
- (void)permissionManager:(TOSPermissionManager *)manager requestCameraAccessWithCompletion:(void (^)(BOOL granted))completion;

/**
 * 请求相册权限的代理方法
 * 当用户首次请求相册权限时，SDK 会调用此方法让上层应用决定如何处理
 *
 * @param manager 权限管理器实例
 * @param completion 完成回调，上层应用需要在适当的时机调用此回调，传入是否授权的结果
 */
- (void)permissionManager:(TOSPermissionManager *)manager requestPhotoLibraryAccessWithCompletion:(void (^)(BOOL granted))completion;

/**
 * 请求麦克风权限的代理方法
 * 当用户首次请求麦克风权限时，SDK 会调用此方法让上层应用决定如何处理
 *
 * @param manager 权限管理器实例
 * @param completion 完成回调，上层应用需要在适当的时机调用此回调，传入是否授权的结果
 */
- (void)permissionManager:(TOSPermissionManager *)manager requestMicrophoneAccessWithCompletion:(void (^)(BOOL granted))completion;

@end

/**
 * 全局权限管理器
 * 提供统一的权限检查和请求接口
 */
@interface TOSPermissionManager : NSObject

/**
 * 获取权限管理器的单例实例
 */
+ (instancetype)sharedManager;

/**
 * 权限管理代理
 */
@property (nonatomic, weak) id<TOSPermissionManagerDelegate> delegate;

/**
 * 请求摄像头、麦克风和相册权限
 * 
 * @param completion 完成回调
 *   - granted: 是否授权
 */
- (void)requestSystemCameraPermissionWithCompletion:(void (^)(BOOL granted))completion;

/**
 * 请求相册权限
 * 
 * @param completion 完成回调
 *   - granted: 是否授权
 */
- (void)requestSystemPhotoLibraryPermissionWithCompletion:(void (^)(BOOL granted))completion;

/**
 * 请求麦克风权限
 * 
 * @param completion 完成回调
 *   - granted: 是否授权
 */
- (void)requestSystemMicrophonePermissionWithCompletion:(void (^)(BOOL granted))completion;

@end

NS_ASSUME_NONNULL_END
