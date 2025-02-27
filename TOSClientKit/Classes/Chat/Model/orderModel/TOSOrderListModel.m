//
//  TOSOrderListModel.m
//  TOSClientKit
//
//  Created by 李成 on 2024/11/4.
//  Copyright © 2024 YanBo. All rights reserved.
//

#import "TOSOrderListModel.h"

@implementation TOSOrderListModel

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{
        @"buttonConfigList" : [TOSOrderButtonConfigModel class],
        @"productList" : [TOSOrderListProductModel class],
    };
}


- (CGFloat)functionHeight {
    CGFloat totalHeight = 0.0f;
    if (self.buttonConfigList.count) {
        totalHeight += 62.0f;
    }
    if (self.bottomButtonConfig) {
        totalHeight += 34.0f;
    }
    return totalHeight;
}

- (CGFloat)bottomCustomHeight {
    CGFloat totalHeight = 0.0f;
    if (self.showMore) {
        totalHeight = self.extraInfoArr.count * 22.0f + 4.0 + 12.0f;
    }
    else {
        if (self.extraInfoArr.count > 3) {
            totalHeight = 89.0f;
        }
        else if (self.extraInfoArr.count) {
            totalHeight = self.extraInfoArr.count * 22.0f + 4.0 + 12.0f;
        }
    }
    return totalHeight;
}

@end

