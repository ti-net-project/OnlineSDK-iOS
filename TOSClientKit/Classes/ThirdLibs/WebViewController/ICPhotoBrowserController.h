//
//  ICPhotoBrowserController.h
//  XZ_WeChat
//
//  Created by 赵言 on 16/4/12.
//  Copyright © 2016年 gxz All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TOSImageTransitionAnimator : NSObject <UIViewControllerAnimatedTransitioning>
@property (nonatomic, assign) BOOL isPresenting;
@property (nonatomic, strong) UIImageView *originImageView; // 起始的图片视图
@property (nonatomic, strong) UIImageView *targetImageView; // 目标的图片视图
@end


@interface ICPhotoBrowserController : UIViewController

@property (nonatomic, strong) UIImage *image;

@property (nonatomic, strong) UIImageView *imageView;

/// 转场动画
@property (nonatomic, strong) TOSImageTransitionAnimator *animator;

- (instancetype)initWithImage:(UIImage *)image msgId:(NSString *)msgId originImageUrl:(NSString *)originImageUrl;

@end





