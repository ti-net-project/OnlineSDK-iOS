//
//  TOSOrderMessage.h
//  TOSClientLib
//
//  Created by 李成 on 2024/11/12.
//  Copyright © 2024 YanBo. All rights reserved.
//

#import <TOSClientLib/TOSClientLib.h>

NS_ASSUME_NONNULL_BEGIN

@class TOSOrderProductModel;

@interface TOSOrderMessage : TIMMessageContent

/// 店铺名称（示例: XX专营店）
@property (nonatomic, copy) NSString                * title;

/// 店铺头像
@property (nonatomic, copy) NSString                * logo;

/// 订单时间，具体时间（示例: xx年xx月xx日 00:00:00）
@property (nonatomic, copy) NSString                * time;

/// 订单编号（示例: 1234**2457000）
@property (nonatomic, copy) NSString                * number;

/// 订单标签
@property (nonatomic, strong) NSDictionary                * tag;

/// 订单状态（示例: 待收货）
@property (nonatomic, copy) NSString                * status;

/// 底部订单按钮
@property (nonatomic, strong) NSArray                * buttonConfigList;

/// 订单底部按钮配置
@property (nonatomic, strong) NSDictionary                * bottomButtonConfig;

/// 商品列表数组
@property (nonatomic, strong) NSArray<TOSOrderProductModel *>                * productList;

/// 您的自定字段，一般来说是个数组或null，会携带给机器人，不展示在页面上，我们不做处理
@property (nonatomic, strong) NSArray                * extraData;

/// 自定义参数，只在订单列表显示，且显示在该订单底部，发送出去的消息不显示
@property (nonatomic, strong) NSArray                * extraInfoArr;

/// 是否展开（本地使用，是否显示更多的自定义参数）
@property (nonatomic, assign) BOOL                showMore;

/// 总的高度
@property (nonatomic, assign) CGFloat                totalHeight;

/// 顶部订单信息的总高度
@property (nonatomic, assign) CGFloat                topOrderheight;

@end


@interface TOSOrderProductModel : NSObject

/// 商品标题（示例: xxx商品）
@property (nonatomic, copy) NSString                * title;

/// 商品副标题（示例: 商品说明）
@property (nonatomic, copy) NSString                * subtitle;

/// 描述，展示为标签样式（示例: 商品描述）
@property (nonatomic, copy) NSString                * remark;

/// 商品数量，非数字，可携带单位（示例: x5）
@property (nonatomic, copy) NSString                * amount;

/// 商品价格，非数字，可携带单位（示例: $2999）
@property (nonatomic, copy) NSString                * price;

/// 商品图片url（示例: https://xxx.com/image/xxx.jpeg）
@property (nonatomic, copy) NSString                * img;

/// 商品标签，对应商品图片左上角标签文字，建议小于等于4个中文（示例: 敬请期待）
@property (nonatomic, copy) NSString                * imgTag;

/// 商品标签样式（示例: { "color": "red" }）
@property (nonatomic, copy) NSString                * imgTagStyle;

/// 只在在线客服工作台座席端才起作用，客服点击则定位到工作台右侧边栏同名的 tab 打开。（Tips：SDK应该用不到这个）
@property (nonatomic, copy) NSString                * agentNavigateTabName;

/// 访客点击后打开的链接（示例: https://xxx.com/）
@property (nonatomic, copy) NSString                * visitorUrl;

/// 客服点击后打开的链接（示例: https://xxx.com）。 Tips：SDK应该用不到这个
@property (nonatomic, copy) NSString                * agentUrl;

/// 访客点击跳转目标小程序的appId，适用于小程序嵌入H5和公众号嵌入H5，只在访客端生效，和pagePath一起传才会触发小程序跳转，优先级高于url。（示例: 3qwrq***o43op）
@property (nonatomic, copy) NSString                * appId;

/// 访客点击跳转目标小程序的路由地址，适用于小程序嵌入H5和公众号嵌入H5，和appId一起传才会触发小程序跳转，优先级高于url。（示例: /xxx/path）
@property (nonatomic, copy) NSString                * pagePath;

/// 商品状态（示例: 待收货）
@property (nonatomic, copy) NSString                * status;

/// 商品按钮配置，支持三种类型，链接，发送文本，发送订单（发送单个商品也是作为订单发送出去，只是不传递订单的数据信息显示为一个商品）
@property (nonatomic, strong) NSArray                * buttonConfigList;

/// 您的自定字段，一般来说是个数组或null，会携带给机器人，不展示在页面上，我们不做处理
@property (nonatomic, strong) NSArray                * extraData;




@end

NS_ASSUME_NONNULL_END
