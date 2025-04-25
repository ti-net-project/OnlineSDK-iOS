//
//  YYTextSelectionView.h
//  YYKit <https://github.com/ibireme/YYKit>
//
//  Created by ibireme on 15/2/25.
//  Copyright (c) 2015 ibireme.
//
//  This source code is licensed under the MIT-style license found in the
//  LICENSE file in the root directory of this source tree.
//

#import <UIKit/UIKit.h>

#if __has_include(<YYKit/YYKit.h>)
#import <TIMYYKit/YYTextAttribute.h>
#import <TIMYYKit/YYTextInput.h>
#else
#import "TIMYYTextAttribute.h"
#import "TIMYYTextInput.h"
#endif

NS_ASSUME_NONNULL_BEGIN

/**
 A single dot view. The frame should be foursquare.
 Change the background color for display.
 
 @discussion Typically, you should not use this class directly.
 */
@interface TIMYYSelectionGrabberDot : UIView
/// Dont't access this property. It was used by `YYTextEffectWindow`.
@property (nonatomic, strong) UIView *mirror;
@end


/**
 A grabber (stick with a dot).
 
 @discussion Typically, you should not use this class directly.
 */
@interface TIMYYSelectionGrabber : UIView

@property (nonatomic, readonly) TIMYYSelectionGrabberDot *dot; ///< the dot view
@property (nonatomic) YYTextDirection dotDirection;         ///< don't support composite direction
@property (nullable, nonatomic, strong) UIColor *color;     ///< tint color, default is nil

@end


/**
 The selection view for text edit and select.
 
 @discussion Typically, you should not use this class directly.
 */
@interface TIMYYTextSelectionView : UIView

@property (nullable, nonatomic, weak) UIView *hostView; ///< the holder view
@property (nullable, nonatomic, strong) UIColor *color; ///< the tint color
@property (nonatomic, getter = isCaretBlinks) BOOL caretBlinks; ///< whether the caret is blinks
@property (nonatomic, getter = isCaretVisible) BOOL caretVisible; ///< whether the caret is visible
@property (nonatomic, getter = isVerticalForm) BOOL verticalForm; ///< weather the text view is vertical form

@property (nonatomic) CGRect caretRect; ///< caret rect (width==0 or height==0)
@property (nullable, nonatomic, copy) NSArray<TIMYYTextSelectionRect *> *selectionRects; ///< default is nil

@property (nonatomic, readonly) UIView *caretView;
@property (nonatomic, readonly) TIMYYSelectionGrabber *startGrabber;
@property (nonatomic, readonly) TIMYYSelectionGrabber *endGrabber;

- (BOOL)isGrabberContainsPoint:(CGPoint)point;
- (BOOL)isStartGrabberContainsPoint:(CGPoint)point;
- (BOOL)isEndGrabberContainsPoint:(CGPoint)point;
- (BOOL)isCaretContainsPoint:(CGPoint)point;
- (BOOL)isSelectionRectsContainsPoint:(CGPoint)point;

@end

NS_ASSUME_NONNULL_END
