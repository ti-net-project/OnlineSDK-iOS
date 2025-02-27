//
//  Utils.h
//  TIMClientLib
//
//  Created by YanBo on 2020/4/27.
//  Copyright © 2020 YanBo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

#define TIMLog(format,...)  [TIMLibUtils customLogWithFunction:__FUNCTION__ lineNumber:__LINE__ formatString:[NSString stringWithFormat:format, ##__VA_ARGS__]]

@interface TIMLibUtils : NSObject

#pragma mark -- 日志方法
// 设置日志输出状态
+ (void)setLogEnable:(BOOL)enable;

// 获取日志输出状态
+ (BOOL)getLogEnable;

// 设置环境 为了判断KT
+ (void)setEnvConfig:(NSString *)env;

// 获取环境 为了判断KT
+ (NSString*)getEnvConfig;

// 日志输出方法
+ (void)customLogWithFunction:(const char *)function lineNumber:(int)lineNumber formatString:(NSString *)formatString;

// 获取当前时间戳 毫秒
+(long long)getNowTimestamp;

// 获取当前时间戳 秒
+(NSString *)getNowTimestampWithSec;

/// 获取当前时间
/// @param dateFormat 时间格式 YYYY-MM-dd HH:mm:ss
+(NSString *)getNowTimestampWithDateFormat:(NSString *)dateFormat;

// 获取BundleId
+(NSString *)getBundleId;

//获取bundle版本号
+(NSString*) getLocalAppVersion;

// 获取app名称
+(NSString*) getAppName;

// 初次获取UDID
+(NSString *)getFirstDeviceUDID;

// 获取UDID
+(NSString *)getDeviceUDID;

// 获取SDK版本号
+(NSString *)getSDKVersion;

// 获取手机系统版本
+(NSString *)getOSVersion;

// 获取设备厂商
+(NSString *)getDeviceVendor;

// 获取手机型号
+(NSString *)getPhoneModel;

// 加密
+ (NSData *)sha512:(NSString *)str;

// sha256
+ (NSString*)sha256HashFor:(NSString*)input;

// NSData转MD5
+ (NSString *)dataConversionMD5:(NSData *)data;

// 生成随机uuid
+ (NSString *)getMsgUUID;

// dictionary to NSString
+ (NSString*)DataTOjsonString:(id)object;

+ (NSString *)removeSpaceAndNewline:(NSString *)str;

// NSString to Dictionary
+ (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString;

// NSString to Array
+ (NSArray *)arrayWithJsonString:(NSString *)jsonString;

// 随机字符串 默认10位
+ (NSString *)RandomString;

// 截取字符串的最后一位
+ (NSString *)removeTheLastOneStr:(NSString*)string;

// 获取video
+ (NSString *)videoPathWithFileName:(NSString *)videoName;

// 判断字串为空
+ (BOOL)isBlankString:(NSString *)str;

// 判断是否是gif
+ (NSString *)typeForImageData:(NSData *)data;

// 获取语音时长
+ (NSUInteger)durationWithVideo:(NSURL *)voiceUrl;

// 截取视频缩略图
+ (UIImage *)thumbnailImageRequestWithVideoUrl:(NSURL *)videoUrl;

// 旋转图片
+ (UIImage *)rotateImage:(UIImage *)image withOrientation:(UIImageOrientation)orientation;

/// 字典转字符串
/// @param dic 字典
+ (NSString *)convertToJsonDataWithDic:(NSDictionary *)dic;

+ (NSString *)md5StringFromString:(NSString *)string;

/// 判断富文本的标签是否属于文本类型
/// @param type 类型
+ (BOOL)isTextTypeLabel:(NSString *)type;

@end

NS_ASSUME_NONNULL_END
