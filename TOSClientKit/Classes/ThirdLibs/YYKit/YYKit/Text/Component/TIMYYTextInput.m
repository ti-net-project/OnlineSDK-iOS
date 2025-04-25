//
//  YYTextInput.m
//  YYKit <https://github.com/ibireme/YYKit>
//
//  Created by ibireme on 15/4/17.
//  Copyright (c) 2015 ibireme.
//
//  This source code is licensed under the MIT-style license found in the
//  LICENSE file in the root directory of this source tree.
//

#import "TIMYYTextInput.h"
#import "TIMYYKitMacro.h"

@implementation TIMYYTextPosition

+ (instancetype)positionWithOffset:(NSInteger)offset {
    return [self positionWithOffset:offset affinity:YYTextAffinityForward];
}

+ (instancetype)positionWithOffset:(NSInteger)offset affinity:(YYTextAffinity)affinity {
    TIMYYTextPosition *p = [self new];
    p->_offset = offset;
    p->_affinity = affinity;
    return p;
}

- (instancetype)copyWithZone:(NSZone *)zone {
    return [self.class positionWithOffset:_offset affinity:_affinity];
}

- (NSString *)description {
    return [NSString stringWithFormat:@"<%@: %p> (%@%@)", self.class, self, @(_offset), _affinity == YYTextAffinityForward ? @"F":@"B"];
}

- (NSUInteger)hash {
    return _offset * 2 + (_affinity == YYTextAffinityForward ? 1 : 0);
}

- (BOOL)isEqual:(TIMYYTextPosition *)object {
    if (!object) return NO;
    return _offset == object.offset && _affinity == object.affinity;
}

- (NSComparisonResult)compare:(TIMYYTextPosition *)otherPosition {
    if (!otherPosition) return NSOrderedAscending;
    if (_offset < otherPosition.offset) return NSOrderedAscending;
    if (_offset > otherPosition.offset) return NSOrderedDescending;
    if (_affinity == YYTextAffinityBackward && otherPosition.affinity == YYTextAffinityForward) return NSOrderedAscending;
    if (_affinity == YYTextAffinityForward && otherPosition.affinity == YYTextAffinityBackward) return NSOrderedDescending;
    return NSOrderedSame;
}

@end



@implementation TIMYYTextRange {
    TIMYYTextPosition *_start;
    TIMYYTextPosition *_end;
}

- (instancetype)init {
    self = [super init];
    if (!self) return nil;
    _start = [TIMYYTextPosition positionWithOffset:0];
    _end = [TIMYYTextPosition positionWithOffset:0];
    return self;
}

- (TIMYYTextPosition *)start {
    return _start;
}

- (TIMYYTextPosition *)end {
    return _end;
}

- (BOOL)isEmpty {
    return _start.offset == _end.offset;
}

- (NSRange)asRange {
    return NSMakeRange(_start.offset, _end.offset - _start.offset);
}

+ (instancetype)rangeWithRange:(NSRange)range {
    return [self rangeWithRange:range affinity:YYTextAffinityForward];
}

+ (instancetype)rangeWithRange:(NSRange)range affinity:(YYTextAffinity)affinity {
    TIMYYTextPosition *start = [TIMYYTextPosition positionWithOffset:range.location affinity:affinity];
    TIMYYTextPosition *end = [TIMYYTextPosition positionWithOffset:range.location + range.length affinity:affinity];
    return [self rangeWithStart:start end:end];
}

+ (instancetype)rangeWithStart:(TIMYYTextPosition *)start end:(TIMYYTextPosition *)end {
    if (!start || !end) return nil;
    if ([start compare:end] == NSOrderedDescending) {
        YY_SWAP(start, end);
    }
    TIMYYTextRange *range = [TIMYYTextRange new];
    range->_start = start;
    range->_end = end;
    return range;
}

+ (instancetype)defaultRange {
    return [self new];
}

- (instancetype)copyWithZone:(NSZone *)zone {
    return [self.class rangeWithStart:_start end:_end];
}

- (NSString *)description {
    return [NSString stringWithFormat:@"<%@: %p> (%@, %@)%@", self.class, self, @(_start.offset), @(_end.offset - _start.offset), _end.affinity == YYTextAffinityForward ? @"F":@"B"];
}

- (NSUInteger)hash {
    return (sizeof(NSUInteger) == 8 ? OSSwapInt64(_start.hash) : OSSwapInt32(_start.hash)) + _end.hash;
}

- (BOOL)isEqual:(TIMYYTextRange *)object {
    if (!object) return NO;
    return [_start isEqual:object.start] && [_end isEqual:object.end];
}

@end



@implementation TIMYYTextSelectionRect

@synthesize rect = _rect;
@synthesize writingDirection = _writingDirection;
@synthesize containsStart = _containsStart;
@synthesize containsEnd = _containsEnd;
@synthesize isVertical = _isVertical;

- (id)copyWithZone:(NSZone *)zone {
    TIMYYTextSelectionRect *one = [self.class new];
    one.rect = _rect;
    one.writingDirection = _writingDirection;
    one.containsStart = _containsStart;
    one.containsEnd = _containsEnd;
    one.isVertical = _isVertical;
    return one;
}

@end
