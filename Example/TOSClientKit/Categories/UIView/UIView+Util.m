//
//  UIView+Util.m
//  TOSClientKitDemo
//
//  Created by 言 on 2023/10/24.
//  Copyright © 2023 YanBo. All rights reserved.
//

#import "UIView+Util.h"

@implementation UIView (Util)

- (CGFloat)centerX {

    return self.center.x;
}

- (void)setCenterX:(CGFloat)centerX {
    CGPoint center = self.center;
    center.x = centerX;
    self.center = center;
}


//- (CGFloat)centerX
//{
//    return self.center.x;
//}
//
//- (void)setCenterX:(CGFloat)centerX
//{
//    CGRect newFrame = self.frame;
//    newFrame.origin.x = centerX- newFrame.size.width/2 ;
//    self.frame = newFrame;
//}

@end
