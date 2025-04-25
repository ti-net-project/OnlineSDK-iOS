//
//  YYTextDebugOption.m
//  YYKit <https://github.com/ibireme/YYKit>
//
//  Created by ibireme on 15/4/8.
//  Copyright (c) 2015 ibireme.
//
//  This source code is licensed under the MIT-style license found in the
//  LICENSE file in the root directory of this source tree.
//

#import "TIMYYTextDebugOption.h"
#import "TIMYYKitMacro.h"
#import "UIColor+TIMYYAdd.h"
#import "TIMYYWeakProxy.h"


static pthread_mutex_t _sharedDebugLock;
static CFMutableSetRef _sharedDebugTargets = nil;
static TIMYYTextDebugOption *_sharedDebugOption = nil;

static const void* _sharedDebugSetRetain(CFAllocatorRef allocator, const void *value) {
    return value;
}

static void _sharedDebugSetRelease(CFAllocatorRef allocator, const void *value) {
}

void _sharedDebugSetFunction(const void *value, void *context) {
    id<TIMYYTextDebugTarget> target = (__bridge id<TIMYYTextDebugTarget>)(value);
    [target setDebugOption:_sharedDebugOption];
}

static void _initSharedDebug() {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        pthread_mutex_init(&_sharedDebugLock, NULL);
        CFSetCallBacks callbacks = kCFTypeSetCallBacks;
        callbacks.retain = _sharedDebugSetRetain;
        callbacks.release = _sharedDebugSetRelease;
        _sharedDebugTargets = CFSetCreateMutable(CFAllocatorGetDefault(), 0, &callbacks);
    });
}

static void _setSharedDebugOption(TIMYYTextDebugOption *option) {
    _initSharedDebug();
    pthread_mutex_lock(&_sharedDebugLock);
    _sharedDebugOption = option.copy;
    CFSetApplyFunction(_sharedDebugTargets, _sharedDebugSetFunction, NULL);
    pthread_mutex_unlock(&_sharedDebugLock);
}

static TIMYYTextDebugOption *_getSharedDebugOption() {
    _initSharedDebug();
    pthread_mutex_lock(&_sharedDebugLock);
    TIMYYTextDebugOption *op = _sharedDebugOption;
    pthread_mutex_unlock(&_sharedDebugLock);
    return op;
}

static void _addDebugTarget(id<TIMYYTextDebugTarget> target) {
    _initSharedDebug();
    pthread_mutex_lock(&_sharedDebugLock);
    CFSetAddValue(_sharedDebugTargets, (__bridge const void *)(target));
    pthread_mutex_unlock(&_sharedDebugLock);
}

static void _removeDebugTarget(id<TIMYYTextDebugTarget> target) {
    _initSharedDebug();
    pthread_mutex_lock(&_sharedDebugLock);
    CFSetRemoveValue(_sharedDebugTargets, (__bridge const void *)(target));
    pthread_mutex_unlock(&_sharedDebugLock);
}


@implementation TIMYYTextDebugOption

- (id)copyWithZone:(NSZone *)zone {
    TIMYYTextDebugOption *op = [self.class new];
    op.baselineColor = self.baselineColor;
    op.CTFrameBorderColor = self.CTFrameBorderColor;
    op.CTFrameFillColor = self.CTFrameFillColor;
    op.CTLineBorderColor = self.CTLineBorderColor;
    op.CTLineFillColor = self.CTLineFillColor;
    op.CTLineNumberColor = self.CTLineNumberColor;
    op.CTRunBorderColor = self.CTRunBorderColor;
    op.CTRunFillColor = self.CTRunFillColor;
    op.CTRunNumberColor = self.CTRunNumberColor;
    op.CGGlyphBorderColor = self.CGGlyphBorderColor;
    op.CGGlyphFillColor = self.CGGlyphFillColor;
    return op;
}

- (BOOL)needDrawDebug {
    if (self.baselineColor ||
        self.CTFrameBorderColor ||
        self.CTFrameFillColor ||
        self.CTLineBorderColor ||
        self.CTLineFillColor ||
        self.CTLineNumberColor ||
        self.CTRunBorderColor ||
        self.CTRunFillColor ||
        self.CTRunNumberColor ||
        self.CGGlyphBorderColor ||
        self.CGGlyphFillColor) return YES;
    return NO;
}

- (void)clear {
    self.baselineColor = nil;
    self.CTFrameBorderColor = nil;
    self.CTFrameFillColor = nil;
    self.CTLineBorderColor = nil;
    self.CTLineFillColor = nil;
    self.CTLineNumberColor = nil;
    self.CTRunBorderColor = nil;
    self.CTRunFillColor = nil;
    self.CTRunNumberColor = nil;
    self.CGGlyphBorderColor = nil;
    self.CGGlyphFillColor = nil;
}

+ (void)addDebugTarget:(id<TIMYYTextDebugTarget>)target {
    if (target) _addDebugTarget(target);
}

+ (void)removeDebugTarget:(id<TIMYYTextDebugTarget>)target {
    if (target) _removeDebugTarget(target);
}

+ (TIMYYTextDebugOption *)sharedDebugOption {
    return _getSharedDebugOption();
}

+ (void)setSharedDebugOption:(TIMYYTextDebugOption *)option {
    YYAssertMainThread();
    _setSharedDebugOption(option);
}

@end

