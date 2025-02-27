//
//  CustomFileTableViewCell.h
//  TOSClientKitDemo
//
//  Created by 李成 on 2024/10/8.
//  Copyright © 2024 YanBo. All rights reserved.
//

#import <TOSClientKit/TOSClientKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CustomFileTableViewCell : TOSChatCustomBaseTableViewCell

@property (nonatomic, strong) TIMMessageModel                * model;

@end

NS_ASSUME_NONNULL_END
