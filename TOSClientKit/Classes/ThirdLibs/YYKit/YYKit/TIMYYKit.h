//
//  TIMYYKit.h
//  YYKit <https://github.com/ibireme/YYKit>
//
//  Created by ibireme on 13/3/30.
//  Copyright (c) 2015 ibireme.
//
//  This source code is licensed under the MIT-style license found in the
//  LICENSE file in the root directory of this source tree.
//

#import <Foundation/Foundation.h>

#if __has_include(<YYKit/TIMYYKit.h>)

FOUNDATION_EXPORT double YYKitVersionNumber;
FOUNDATION_EXPORT const unsigned char YYKitVersionString[];

#import  <TIMYYKit/YYKitMacro.h>
#import  <TIMYYKit/NSObject+YYAdd.h>
#import  <TIMYYKit/NSObject+YYAddForKVO.h>
#import  <TIMYYKit/NSObject+YYAddForARC.h>
#import  <TIMYYKit/NSString+YYAdd.h>
#import  <TIMYYKit/NSNumber+YYAdd.h>
#import  <TIMYYKit/NSData+YYAdd.h>
#import  <TIMYYKit/NSArray+YYAdd.h>
#import  <TIMYYKit/NSDictionary+YYAdd.h>
#import  <TIMYYKit/NSDate+YYAdd.h>
#import  <TIMYYKit/NSNotificationCenter+YYAdd.h>
#import  <TIMYYKit/NSKeyedUnarchiver+YYAdd.h>
#import  <TIMYYKit/NSTimer+YYAdd.h>
#import  <TIMYYKit/NSBundle+YYAdd.h>
#import  <TIMYYKit/NSThread+YYAdd.h>

#import  <TIMYYKit/UIColor+YYAdd.h>
#import  <TIMYYKit/UIImage+YYAdd.h>
#import  <TIMYYKit/UIControl+YYAdd.h>
#import  <TIMYYKit/UIBarButtonItem+YYAdd.h>
#import  <TIMYYKit/UIGestureRecognizer+YYAdd.h>
#import  <TIMYYKit/UIView+YYAdd.h>
#import  <TIMYYKit/UIScrollView+YYAdd.h>
#import  <TIMYYKit/UITableView+YYAdd.h>
#import  <TIMYYKit/UITextField+YYAdd.h>
#import  <TIMYYKit/UIScreen+YYAdd.h>
#import  <TIMYYKit/UIDevice+YYAdd.h>
#import  <TIMYYKit/UIApplication+YYAdd.h>
#import  <TIMYYKit/UIFont+YYAdd.h>
#import  <TIMYYKit/UIBezierPath+YYAdd.h>

#import  <TIMYYKit/CALayer+YYAdd.h>
#import  <TIMYYKit/YYCGUtilities.h>

#import  <TIMYYKit/NSObject+YYModel.h>
#import  <TIMYYKit/YYClassInfo.h>

#import  <TIMYYKit/YYCache.h>
#import  <TIMYYKit/YYMemoryCache.h>
#import  <TIMYYKit/YYDiskCache.h>
#import  <TIMYYKit/YYKVStorage.h>

#import  <TIMYYKit/YYImage.h>
#import  <TIMYYKit/YYFrameImage.h>
#import  <TIMYYKit/YYSpriteSheetImage.h>
#import  <TIMYYKit/YYAnimatedImageView.h>
#import  <TIMYYKit/YYImageCoder.h>
#import  <TIMYYKit/YYImageCache.h>
#import  <TIMYYKit/YYWebImageOperation.h>
#import  <TIMYYKit/YYWebImageManager.h>
#import  <TIMYYKit/UIImageView+YYWebImage.h>
#import  <TIMYYKit/UIButton+YYWebImage.h>
#import  <TIMYYKit/MKAnnotationView+YYWebImage.h>
#import  <TIMYYKit/CALayer+YYWebImage.h>

#import  <TIMYYKit/YYLabel.h>
#import  <TIMYYKit/YYTextView.h>
#import  <TIMYYKit/YYTextAttribute.h>
#import  <TIMYYKit/YYTextArchiver.h>
#import  <TIMYYKit/YYTextParser.h>
#import  <TIMYYKit/YYTextUtilities.h>
#import  <TIMYYKit/YYTextRunDelegate.h>
#import  <TIMYYKit/YYTextRubyAnnotation.h>
#import  <TIMYYKit/NSAttributedString+YYText.h>
#import  <TIMYYKit/NSParagraphStyle+YYText.h>
#import  <TIMYYKit/UIPasteboard+YYText.h>
#import  <TIMYYKit/YYTextLayout.h>
#import  <TIMYYKit/YYTextLine.h>
#import  <TIMYYKit/YYTextInput.h>
#import  <TIMYYKit/YYTextDebugOption.h>
#import  <TIMYYKit/YYTextContainerView.h>
#import  <TIMYYKit/YYTextSelectionView.h>
#import  <TIMYYKit/YYTextMagnifier.h>
#import  <TIMYYKit/YYTextEffectWindow.h>
#import  <TIMYYKit/YYTextKeyboardManager.h>

#import  <TIMYYKit/YYReachability.h>
#import  <TIMYYKit/YYGestureRecognizer.h>
#import  <TIMYYKit/YYFileHash.h>
#import  <TIMYYKit/YYKeychain.h>
#import  <TIMYYKit/YYWeakProxy.h>
#import  <TIMYYKit/YYTimer.h>
#import  <TIMYYKit/YYTransaction.h>
#import  <TIMYYKit/YYAsyncLayer.h>
#import  <TIMYYKit/YYSentinel.h>
#import  <TIMYYKit/YYDispatchQueuePool.h>
#import  <TIMYYKit/YYThreadSafeArray.h>
#import  <TIMYYKit/YYThreadSafeDictionary.h>

#else

#import "TIMYYKitMacro.h"
#import "NSObject+TIMYYAdd.h"
#import "NSObject+TIMYYAddForKVO.h"
#import "NSObject+TIMYYAddForARC.h"
#import "NSString+TIMYYAdd.h"
#import "NSNumber+TIMYYAdd.h"
#import "NSData+YYAdd.h"
#import "NSArray+TIMYYAdd.h"
#import "NSDictionary+YYAdd.h"
#import "NSDate+YYAdd.h"
#import "NSNotificationCenter+YYAdd.h"
#import "NSKeyedUnarchiver+YYAdd.h"
#import "NSTimer+TIMYYAdd.h"
#import "NSBundle+TIMYYAdd.h"
#import "NSThread+TIMYYAdd.h"

#import "UIColor+TIMYYAdd.h"
#import "UIImage+TIMYYAdd.h"
#import "UIControl+TIMYYAdd.h"
#import "UIBarButtonItem+TIMYYAdd.h"
#import "UIGestureRecognizer+TIMYYAdd.h"
#import "UIView+TIMYYAdd.h"
#import "UIScrollView+TIMYYAdd.h"
#import "UITableView+TIMYYAdd.h"
#import "UITextField+TIMYYAdd.h"
#import "UIScreen+TIMYYAdd.h"
#import "UIDevice+TIMYYAdd.h"
#import "UIApplication+TIMYYAdd.h"
#import "UIFont+TIMYYAdd.h"
#import "UIBezierPath+TIMYYAdd.h"

#import "CALayer+TIMYYAdd.h"
#import "TIMYYCGUtilities.h"

#import "NSObject+TIMYYModel.h"
#import "TIMYYClassInfo.h"

#import "TIMYYCache.h"
#import "TIMYYMemoryCache.h"
#import "TIMYYDiskCache.h"
#import "TIMYYKVStorage.h"

#import "TIMYYImage.h"
#import "TIMYYFrameImage.h"
#import "TIMYYSpriteSheetImage.h"
#import "TIMYYAnimatedImageView.h"
#import "TIMYYImageCoder.h"
#import "TIMYYImageCache.h"
#import "TIMYYWebImageOperation.h"
#import "TIMYYWebImageManager.h"
#import "UIImageView+YYWebImage.h"
#import "UIButton+YYWebImage.h"
#import "MKAnnotationView+YYWebImage.h"
#import "CALayer+YYWebImage.h"

#import "TIMYYLabel.h"
#import "TIMYYTextView.h"
#import "TIMYYTextAttribute.h"
#import "TIMYYTextArchiver.h"
#import "TIMYYTextParser.h"
#import "TIMYYTextUtilities.h"
#import "TIMYYTextRunDelegate.h"
#import "TIMYYTextRubyAnnotation.h"
#import "NSAttributedString+TIMYYText.h"
#import "NSParagraphStyle+TIMYYText.h"
#import "UIPasteboard+TIMYYText.h"
#import "TIMYYTextLayout.h"
#import "TIMYYTextLine.h"
#import "TIMYYTextInput.h"
#import "TIMYYTextDebugOption.h"
#import "TIMYYTextContainerView.h"
#import "TIMYYTextSelectionView.h"
#import "TIMYYTextMagnifier.h"
#import "TIMYYTextEffectWindow.h"
#import "TIMYYTextKeyboardManager.h"

#import "TIMYYReachability.h"
#import "TIMYYGestureRecognizer.h"
#import "TIMYYFileHash.h"
#import "TIMYYKeychain.h"
#import "TIMYYWeakProxy.h"
#import "TIMYYTimer.h"
#import "TIMYYTransaction.h"
#import "TIMYYAsyncLayer.h"
#import "TIMYYSentinel.h"
#import "TIMYYDispatchQueuePool.h"
#import "TIMYYThreadSafeArray.h"
#import "TIMYYThreadSafeDictionary.h"

#endif
