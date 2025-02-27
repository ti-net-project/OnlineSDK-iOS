//
//  TOSClientKitCommodityCardOption.h
//  TIMClientLib
//
//  Created by 赵言 on 2022/5/24.
//  Copyright © 2022 YanBo. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN


@interface TOSClientKitCommodityCardOption : NSObject

/// 副标题
@property (nonatomic, strong) NSString *subTitle;

/// 描述
@property (nonatomic, strong) NSString *descriptions;

/// 价格
/// 注:1.11.4版本及之后 不再默认前缀增加￥,请将带符号的价格赋值
@property (nonatomic, strong) NSString *price;

/// 时间
@property (nonatomic, strong) NSString *time;

/// 图片链接，http/https
@property (nonatomic, strong) NSString *img;

/// 运输状态
@property (nonatomic, strong) NSString *status;

/// 标题
@property (nonatomic, strong) NSString *title;

/// 卡片副标题点击跳转链接
@property (nonatomic, strong) NSString *subUrl;

/// 卡片点击跳转链接
@property (nonatomic, strong) NSString *url;

/// 发送按钮文本内容
@property (nonatomic, strong) NSString *buttonText;

/// 附加字段 Tips：2.3.1版本修改了字段类型(从NSString改成了id类型)
@property (nonatomic, strong, nullable) id  extraData;

/// 附加字段，例：[{"name":"订单号","value":"1234567890"},{"name":"产品类型","value":"电子产品"},{"name":"师傅","value":"金师傅"},{"name":"服务地区","value":"北京市"},{"name":"服务","value":"满意"},{"name":"师傅电话","value":"12345678900"},{"name":"订单状态","value":"已完成"}]
@property (nonatomic, strong) NSArray <NSDictionary <NSString *, NSString *>*>*extraInfo;

@end

NS_ASSUME_NONNULL_END
