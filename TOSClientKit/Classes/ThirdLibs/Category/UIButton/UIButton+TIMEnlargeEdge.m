//
//  UIButton+EnlargeEdge.m
//  SmartHome
//
//  Created by 赵言 on 2019/7/4.
//  Copyright © 2019 赵言. All rights reserved.
//

#import "UIButton+TIMEnlargeEdge.h"
#import <objc/runtime.h>

static char topNameKey;
static char rightNameKey;
static char bottomNameKey;
static char leftNameKey;

@implementation UIButton (TIMEnlargeEdge)

- (void)setEnlargeEdge:(CGFloat)size {
    objc_setAssociatedObject(self, &topNameKey, [NSNumber numberWithFloat:size], OBJC_ASSOCIATION_COPY_NONATOMIC);
    objc_setAssociatedObject(self, &rightNameKey, [NSNumber numberWithFloat:size], OBJC_ASSOCIATION_COPY_NONATOMIC);
    objc_setAssociatedObject(self, &bottomNameKey, [NSNumber numberWithFloat:size], OBJC_ASSOCIATION_COPY_NONATOMIC);
    objc_setAssociatedObject(self, &leftNameKey, [NSNumber numberWithFloat:size], OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (void)setEnlargeEdgeWithTop:(CGFloat)top right:(CGFloat)right bottom:(CGFloat)bottom left:(CGFloat)left {
    objc_setAssociatedObject(self, &topNameKey, [NSNumber numberWithFloat:top], OBJC_ASSOCIATION_COPY_NONATOMIC);
    objc_setAssociatedObject(self, &rightNameKey, [NSNumber numberWithFloat:right], OBJC_ASSOCIATION_COPY_NONATOMIC);
    objc_setAssociatedObject(self, &bottomNameKey, [NSNumber numberWithFloat:bottom], OBJC_ASSOCIATION_COPY_NONATOMIC);
    objc_setAssociatedObject(self, &leftNameKey, [NSNumber numberWithFloat:left], OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (CGRect)enlargedRect {
    NSNumber* topEdge = objc_getAssociatedObject(self, &topNameKey);
    NSNumber* rightEdge = objc_getAssociatedObject(self, &rightNameKey);
    NSNumber* bottomEdge = objc_getAssociatedObject(self, &bottomNameKey);
    NSNumber* leftEdge = objc_getAssociatedObject(self, &leftNameKey);
    if (topEdge && rightEdge && bottomEdge && leftEdge) {
        return CGRectMake(self.bounds.origin.x - leftEdge.floatValue,
                          self.bounds.origin.y - topEdge.floatValue,
                          self.bounds.size.width + leftEdge.floatValue + rightEdge.floatValue,
                          self.bounds.size.height + topEdge.floatValue + bottomEdge.floatValue);
    } else {
        return self.bounds;
    }
}

- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event {
    CGRect rect = [self enlargedRect];
    if (CGRectEqualToRect(rect, self.bounds)) {
        return [super pointInside:point withEvent:event];
    }
    return CGRectContainsPoint(rect, point) ? YES : NO;
}

@end




static const char *UIButtonDebounceIntervalKey = "TOSUIButtonDebounceIntervalKey";
static const char *UIButtonIsProcessingKey = "TOSUIButtonIsProcessingKey";
static const char *UIButtonOriginalTargetKey = "TOSUIButtonOriginalTargetKey";
static const char *UIButtonOriginalActionKey = "TOSUIButtonOriginalActionKey";


@implementation UIButton (Debounce)

- (void)setDebounceInterval:(NSTimeInterval)debounceInterval {
    objc_setAssociatedObject(self, UIButtonDebounceIntervalKey, @(debounceInterval), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSTimeInterval)debounceInterval {
    NSNumber *interval = objc_getAssociatedObject(self, UIButtonDebounceIntervalKey);
    return interval ? [interval doubleValue] : 0.5; // 默认防抖间隔为 0.5 秒
}

- (void)debounced_addTarget:(id)target action:(SEL)action forControlEvents:(UIControlEvents)controlEvents {
    // 存储原始的目标和方法
    objc_setAssociatedObject(self, UIButtonOriginalTargetKey, target, OBJC_ASSOCIATION_ASSIGN);
    objc_setAssociatedObject(self, UIButtonOriginalActionKey, NSStringFromSelector(action), OBJC_ASSOCIATION_COPY_NONATOMIC);
    
    // 替换按钮事件处理方法
    [self addTarget:self action:@selector(handleDebouncedAction:) forControlEvents:controlEvents];
}

- (void)handleDebouncedAction:(UIButton *)sender {
    // 检查是否处于防抖处理中
    NSNumber *isProcessing = objc_getAssociatedObject(sender, UIButtonIsProcessingKey);
    if (isProcessing.boolValue) {
        return; // 按钮处于防抖处理中，直接返回
    }
    
    // 标记为处理中
    objc_setAssociatedObject(sender, UIButtonIsProcessingKey, @(YES), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
    // 获取原始目标和方法
    id target = objc_getAssociatedObject(sender, UIButtonOriginalTargetKey);
    SEL originalAction = NSSelectorFromString(objc_getAssociatedObject(sender, UIButtonOriginalActionKey));
    
    // 执行原始的点击事件
    if (target && [target respondsToSelector:originalAction]) {
        IMP imp = [target methodForSelector:originalAction];
        void (*func)(id, SEL, id) = (void *)imp;
        func(target, originalAction, sender);
    }
    
    // 延迟后解除防抖标记
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(self.debounceInterval * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        objc_setAssociatedObject(sender, UIButtonIsProcessingKey, @(NO), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    });
}


@end
