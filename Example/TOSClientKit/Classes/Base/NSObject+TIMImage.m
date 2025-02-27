//
//  NSObject+TIMImage.m
//  TIMClientLib
//
//  Created by lianpeng on 2021/5/24.
//  Copyright © 2021 YanBo. All rights reserved.
//

#import "NSObject+TIMImage.h"

@implementation NSObject (TIMImage)

/*!
 *  @brief 使图片压缩后刚好小于指定大小
 *
 *  @param image 当前要压缩的图 maxLength 压缩后的大小
 *
 *  @return 图片对象
 */
//图片质量压缩到某一范围内，如果后面用到多，可以抽成分类或者工具类,这里压缩递减比二分的运行时间长，二分可以限制下限。
+ (UIImage *)TIMCompressImageSize:(UIImage *)image toByte:(NSUInteger)maxLength{
    //首先判断原图大小是否在要求内，如果满足要求则不进行压缩，over
    CGFloat compression = 1;
    NSData *data = UIImageJPEGRepresentation(image, compression);
    if (data.length < maxLength) return image;
    //原图大小超过范围，先进行“压处理”，这里 压缩比 采用二分法进行处理，6次二分后的最小压缩比是0.015625，已经够小了
    CGFloat max = 1;
    CGFloat min = 0;
    for (int i = 0; i < 6; ++i) {
        compression = (max + min) / 2;
        data = UIImageJPEGRepresentation(image, compression);
        if (data.length < maxLength * 0.9) {
            min = compression;
        } else if (data.length > maxLength) {
            max = compression;
        } else {
            break;
        }
    }
    //判断“压处理”的结果是否符合要求，符合要求就over
    UIImage *resultImage = [UIImage imageWithData:data];
    if (data.length < maxLength) return resultImage;
    
    //缩处理，直接用大小的比例作为缩处理的比例进行处理，因为有取整处理，所以一般是需要两次处理
    NSUInteger lastDataLength = 0;
    while (data.length > maxLength && data.length != lastDataLength) {
        lastDataLength = data.length;
        //获取处理后的尺寸
        CGFloat ratio = (CGFloat)maxLength / data.length;
        CGSize size = CGSizeMake((NSUInteger)(resultImage.size.width * sqrtf(ratio)),
                                 (NSUInteger)(resultImage.size.height * sqrtf(ratio)));
        // iOS 17.0以上针对某些接口UIGraphicsBeginImageContextWithOptions的废弃兼容
        CGFloat scale = 1.0f;  // 默认值 1.0f
        UIImage *result2Image = nil;
        if (@available(iOS 17.0, *)) {
            // 实际应该是在10.0作为分界点 但是为了谨慎起见只针对17做处理
            UIGraphicsImageRendererFormat *format = [[UIGraphicsImageRendererFormat alloc] init];
            format.scale = scale;
            format.opaque = NO;
            UIGraphicsImageRenderer *renderer = [[UIGraphicsImageRenderer alloc] initWithSize:size
                                                                                       format:format];
            result2Image = [renderer imageWithActions:^(UIGraphicsImageRendererContext * _Nonnull rendererContext) {
                [resultImage drawInRect:CGRectMake(0, 0, size.width, size.height)];
            }];
        } else {
            //通过图片上下文进行处理图片
            UIGraphicsBeginImageContext(size);
            [resultImage drawInRect:CGRectMake(0, 0, size.width, size.height)];
            result2Image = UIGraphicsGetImageFromCurrentImageContext();
            UIGraphicsEndImageContext();
        }
        //获取处理后图片的大小
        data = UIImageJPEGRepresentation(result2Image, compression);
    }
    
    return resultImage;
}

@end
