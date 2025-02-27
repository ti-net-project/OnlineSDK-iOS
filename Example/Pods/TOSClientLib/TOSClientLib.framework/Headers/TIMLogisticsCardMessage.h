//
//  TIMLogisticsCardMessage.h
//  TOSClientLib
//
//  Created by 言 on 2023/1/4.
//  Copyright © 2023 YanBo. All rights reserved.
//

#import <TOSClientLib/TOSClientLib.h>

NS_ASSUME_NONNULL_BEGIN

@interface TIMLogisticsCardMessage : TIMMessageContent

/*
 {
     "cardType":"1",
     "createTime":"04月11日",
     "goodsName":"石子",
     "senderName":"梅州蕉岭-文化厂",
     "recipientName":"汕头潮阳-朝阳区梅花站",
     "goodsAmount":"58.00元/吨",
     "goodsQuantity":"可接一车",
     "orderLink":"https://tchat-item.jd.com/100006607505.html",
     "orderNumber":"800-89741258"
 }
 */

@property (nonatomic, copy) NSString *cardType;
@property (nonatomic, copy) NSString *createTime;
@property (nonatomic, copy) NSString *goodsName;
@property (nonatomic, copy) NSString *senderName;
@property (nonatomic, copy) NSString *recipientName;
@property (nonatomic, copy) NSString *goodsAmount;
@property (nonatomic, copy) NSString *goodsQuantity;
@property (nonatomic, copy) NSString *orderLink;
@property (nonatomic, copy) NSString *orderNumber;

@end

NS_ASSUME_NONNULL_END
