//
//  OSRobotCombinationSpecialSubjectSubview.h
//  TOSClientKit
//
//  Created by 言 on 2024/12/24.
//  Copyright © 2024 YanBo. All rights reserved.
//

#import <TOSClientKit/TOSClientKit.h>

NS_ASSUME_NONNULL_BEGIN
@class TIMMessageFrame;
@class CombinationMessage;
@interface OSRobotCombinationSpecialSubjectSubview : TOSBaseView

- (void)setWithModel:(CombinationMessage *)model;

@property (nonatomic, strong) TIMMessageFrame *tempModelFrame;
@property (nonatomic, strong) NSIndexPath *indexPath;

@end

NS_ASSUME_NONNULL_END
