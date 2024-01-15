//
//  OctoIMParamDefines.h
//  TIMClientDemo
//
//  Created by YanBo on 2020/4/14.
//  Copyright © 2020 YanBo. All rights reserved.
//

#ifndef OctoIMParamDefines_h
#define OctoIMParamDefines_h

// 内部不暴露的代码都以Octo开头
// 此处头文件包含内部参数的设置等

#ifdef DEBUG
#define strSDKVersion @"1.10.5"
#else

#define strSDKVersion @"1.10.5"//todo  // 防止打包遗忘
#endif

/**
 SDK对外接口相关
 */
static NSString * const kInitSDKDefaultApiUrl = @"http://39.102.48.91:8081/api/sdk/v1";//@"https://im-api.octopus.video";

static NSString * const kInitSDKDefaultWebSocketUrl = @"tcbus-im-broker-556308068.cn-northwest-1.elb.amazonaws.com.cn";

static NSString * const kInitSDKTIMServiceApiUrl = @"https://chat-web-dev-cxcloud.cticloud.cn";

//未知的消息类型展示文本
static NSString * const kTIMUnsupportMessageCellType = @"[未知的消息类型]";

// 使用ssl登录 端口8883
static int kInitSDKDefaultMqttPort = 8883;

// 缩略图 最小尺寸 198
static int kUploadThumbailImageMinLength = 198;

// PingMQTT 服务器间隔时长s
static int kPINGMQTTServerInternal = 60;

#define WeakObj(o) autoreleasepool{} __weak typeof(o) o##Weak = o;  //宏定义self
#define StrongObj(o) autoreleasepool{} __strong typeof(o) o = o##Weak;

#define RECONNECT_TIMER 1.0
#define RECONNECT_TIMER_MAX_DEFAULT 64.0

#endif /* OctoIMParamDefines_h */
