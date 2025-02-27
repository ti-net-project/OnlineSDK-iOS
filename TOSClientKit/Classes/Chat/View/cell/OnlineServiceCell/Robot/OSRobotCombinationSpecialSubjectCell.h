//
//  OSRobotCombinationSpecialSubjectCell.h
//  TOSClientKit
//
//  Created by 言 on 2024/12/24.
//  Copyright © 2024 YanBo. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class CombinationMessage;
@interface OSRobotCombinationSpecialSubjectCell : UICollectionViewCell

- (void)setWithModel:(CombinationMessage *)model indexPath:(NSUInteger)indexPath;

@end

NS_ASSUME_NONNULL_END
