//
//  TIMKitConstants.h
//  TIMClientKitDemo
//
//  Created by YanBo on 2020/5/26.
//  Copyright © 2020 YanBo. All rights reserved.
//

#ifndef TIMKitConstants_h
#define TIMKitConstants_h

/// 登录应用编号保存
//static NSString * const kAppIdNumbers = @"kAppIdNumbers";
///// 登录用户名保存
//static NSString * const kLoginUserName = @"kLoginUserName";
///// 登录密码保存
//static NSString * const kLoginPassword = @"kLoginPassword";
///// 登录token保存
//static NSString * const kLoginToken = @"kLoginToken";
///// 登录platformShowName
//static NSString * const kPlatformShowName = @"kPlatformShowName";
///// 登录信息字典保存
//static NSString * const kLoginInfoDic = @"kLoginInfoDic";
/// paas 平台保存
static NSString * const kApiUrlDomainName = @"kApiUrlDomainName";
/// 在线客服平台保存
static NSString * const kOnlineUrlDomainName = @"kOnlineUrlDomainName";
/// 秘钥
static NSString * const kAccessSecretDomainName = @"kAccessSecretDomainName";
/// 渠道入口Id
static NSString * const kAccessIdDomainName = @"kAccessIdDomainName";
/// 相应的企业Id保存
static NSString * const kEnterpriseIdDomainName = @"kEnterpriseIdDomainName";
/// 项目域名保存
static NSString * const kDomainName = @"kDomainName";


static NSString * const kFontNameRegular = @"PingFangSC-Regular";      //常规
static NSString * const kFontNameMedium = @"PingFangSC-Medium";        //中黑体
static NSString * const kFontNameLight = @"PingFangSC-Light";   //细体

//static NSInteger const kStateBarColor = 0xFFFFFF;
//static NSInteger const kBackgroundColor = 0xF5F8F9;
//static NSInteger const kThemeColor = 0x2397FF;
//static NSInteger const kDefaultBlue = 0x007AFF;

static NSString * const kTRLocalizeLanguageCodeKey = @"LangCode";
static NSString * const kTRLocalizeLanguageDescriptionKey = @"LangDescription";
static NSString * const kUserDefaultLanguageKey = @"kUserDefaultLanguageKey";

static CGFloat const kNetworkRequestTimeout = 30.f;

//获取语言
#define TRLocalizedString(key) [[TRLocalizeHelper sharedInstance] localizedStringForKey:key]

#define TOSColor(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]
//16进制颜色值，注意：在使用的时候hexValue写成：0x000000
#define TOSHexColor(hexValue) [UIColor colorWithRed:((float)(((hexValue) & 0xFF0000) >> 16))/255.0 green:((float)(((hexValue) & 0xFF00) >> 8))/255.0 blue:((float)((hexValue) & 0xFF))/255.0 alpha:1.0]

#define kWindowWidth    [UIScreen mainScreen].bounds.size.width
#define kWindowHeight   [[UIScreen mainScreen] bounds].size.height
#define kMainWindow      [[[UIApplication sharedApplication] delegate] window]

#pragma mark - UI适配

#define IS_IPAD (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
#define IS_IPHONE (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)

#define SCREEN_WIDTH ([[UIScreen mainScreen] bounds].size.width)
#define SCREEN_HEIGHT ([[UIScreen mainScreen] bounds].size.height)
#define SCREEN_MAX_LENGTH (MAX(SCREEN_WIDTH, SCREEN_HEIGHT))
#define SCREEN_MIN_LENGTH (MIN(SCREEN_WIDTH, SCREEN_HEIGHT))
#define SCALE(x)  x*self.scale
#define HEIGHTSCALE(x)  (IS_IPHONE_X || IS_IPHONE_XsMax ? x*self.heightScale : x*self.scale)


#define IS_IPHONE_4_OR_LESS (IS_IPHONE && SCREEN_MAX_LENGTH < 568.0)
#define IS_IPHONE_5 (IS_IPHONE && SCREEN_MAX_LENGTH == 568.0)

#define IS_IPHONE_6 (IS_IPHONE && SCREEN_MAX_LENGTH == 667.0)
#define IS_IPHONE_6P (IS_IPHONE && SCREEN_MAX_LENGTH == 736.0)
#define IS_IPHONE_X (IS_IPHONE && SCREEN_MAX_LENGTH == 812)
#define IS_IPHONE_XsMax (IS_IPHONE && SCREEN_MAX_LENGTH == 896)

#define IS_IPHONE_BangsScreen (IS_IPHONE && SCREEN_MAX_LENGTH >= 780)

#define kNavTop (IS_IPHONE_BangsScreen ? 88.f : 64.f)
#define kBottomBarHeight (IS_IPHONE_BangsScreen ? 34.0f : 0)
#define kStatusBarHeight    (IS_IPHONE_BangsScreen ? 44.f : 20.f)


#define kTiNet_UserDef_OBJ(s) [[NSUserDefaults standardUserDefaults] objectForKey:s]
#define kTiNet_UserDef_Bool(s) [[NSUserDefaults standardUserDefaults] boolForKey:s]
#define kTiNet_UserDef [NSUserDefaults standardUserDefaults]

#endif /* TIMKitConstants_h */
