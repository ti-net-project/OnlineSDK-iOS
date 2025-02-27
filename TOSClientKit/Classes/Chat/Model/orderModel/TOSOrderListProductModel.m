//
//  TOSOrderListProductModel.m
//  TOSClientKit
//
//  Created by 李成 on 2024/11/5.
//  Copyright © 2024 YanBo. All rights reserved.
//

#import "TOSOrderListProductModel.h"
#import "TIMConstants.h"


@implementation TOSOrderListProductModel

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{
        @"buttonConfigList" : [TOSOrderButtonConfigModel class],
    };
}

- (CGFloat)totalFunctionHeight {
    /// icon 占用区域的宽度为 72.0，默认为0.0
    CGFloat iconWidth = 0.0;
    if (self.img.length) {
        iconWidth = 72.0f;
    }
    /// 按钮最大宽度
    CGFloat buttonMaxWidth = 124.0;
    /// 按钮的高度
    CGFloat buttonHeight = 26.0;
    /// 按钮间距
    CGFloat spacing = 8.0;
    /// 父视图的宽度
    CGFloat totalWidth = App_Frame_Width-32.0f-24.0;
    /// 从右向左开始布局
    CGFloat xPosition = totalWidth;
    /// 初始 y 坐标
    CGFloat yPosition = 4.0;
    /// 标记当前是否为第一行
    BOOL isFirstRow = YES;
    NSArray<TOSOrderButtonConfigModel *> * itemsArray = self.buttonConfigList;
    for (NSInteger i = 0; i < self.buttonConfigList.count; i++) {
        
        TOSOrderButtonConfigModel * buttonConfig = itemsArray[i];
        /// 计算按钮宽度
        CGFloat buttonWidth = [self widthForButtonWithTitle:buttonConfig.text maxWidth:buttonMaxWidth];
        /// 检查是否需要换行
        if (isFirstRow) {
            /// 第一行按钮布局需要考虑 icon 的宽度
            if (xPosition - buttonWidth < iconWidth) {
                /// 换行，重置 x 位置并增加 y 位置
                xPosition = totalWidth;
                yPosition += buttonHeight + spacing;
                /// 后续行不需要考虑 icon 占位
                isFirstRow = NO;
            }
        } else {
            /// 非第一行布局时
            if (xPosition - buttonWidth < spacing) {
                /// 换行，重置 x 位置并增加 y 位置
                xPosition = totalWidth;
                yPosition += buttonHeight + spacing;
            }
        }
        /// 更新下一个按钮的 x 位置
        xPosition -= (buttonWidth + spacing);
        
    }
    yPosition += buttonHeight;
    return yPosition;
}

// 根据按钮标题计算按钮的宽度，限制最大宽度
- (CGFloat)widthForButtonWithTitle:(NSString *)title maxWidth:(CGFloat)maxWidth {
    NSDictionary *attributes = @{NSFontAttributeName: [UIFont systemFontOfSize:13]};
    CGSize size = [title sizeWithAttributes:attributes];
    return MIN(size.width + 28.0, maxWidth); // 添加20.0用于按钮的内边距
}

@end
