//
//  OSRobotCombinationSpecialSubjectSubview.m
//  TOSClientKit
//
//  Created by 言 on 2024/12/24.
//  Copyright © 2024 YanBo. All rights reserved.
//

#import "OSRobotCombinationSpecialSubjectSubview.h"
#import "TIMMessageModel.h"
#import "ICFileTool.h"
#import "NSDictionary+Extension.h"
#import "TIMLabel.h"
#import "TIMConstants.h"
#import "UIView+SDExtension.h"
#import "kitUtils.h"
#import "UIImageView+TIMWebCache.h"
#import "ICFaceManager.h"
#import "ICChatMessageBaseCell+CustomerUnread.h"
#import <TOSClientLib/CombinationMessage.h>
#import "YYKit.h"
#import "NSString+Frame.h"
#import "NSString+Extension.h"
#import "TIMMessageFrame.h"
#import "OSRobotCombinationSpecialSubjectCell.h"
#import <TOSClientKit/TOSKitCustomInfo.h>

@interface OSRobotCombinationSpecialSubjectSubview () <UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSMutableArray <CombinationDataModel *>*dataSource;

@property (nonatomic, strong) CombinationMessage *model;

@end

@implementation OSRobotCombinationSpecialSubjectSubview

- (void)setupSubviews {
    [super setupSubviews];
    
    self.backgroundColor = [UIColor clearColor];
    [self addSubview:self.collectionView];
}

- (void)defineLayout {
    [super defineLayout];
    
}

#pragma mark - Private Method
- (void)setWithModel:(CombinationMessage *)model {
    
    self.model = model;
    self.collectionView.frame = self.bounds;
    
    if (!CGPointEqualToPoint(model.contentOffset, CGPointZero)) {
        [self.collectionView setContentOffset:model.contentOffset animated:NO];
    } else {
        [self.collectionView setContentOffset:CGPointZero animated:NO];
    }
    
    self.dataSource = [NSMutableArray arrayWithArray:model.data];
    [self.collectionView reloadData];
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.dataSource.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    OSRobotCombinationSpecialSubjectCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"OSRobotCombinationSpecialSubjectCell" forIndexPath:indexPath];
    [cell setWithModel:self.model
             indexPath:indexPath.row];
    return cell;
}

#pragma mark - UICollectionViewDelegate
// 处理点击事件
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    ((NSMutableArray <CombinationMessage *>*)self.tempModelFrame.model.message.content)[self.indexPath.row].specialSubjectSelect = indexPath.row;
        
    ((NSMutableArray <CombinationMessage *>*)self.tempModelFrame.model.message.content)[self.indexPath.row].selectData = 0;
    
    ((NSMutableArray <CombinationMessage *>*)self.tempModelFrame.model.message.content)[self.indexPath.row].contentOffset = self.collectionView.contentOffset;
    
    //此段代码为触发model的setModel
    self.tempModelFrame.model = self.tempModelFrame.model;
    
    [self routerEventWithName:GXRobotCombinationHotIssueCellRefreshEventName
                     userInfo:@{MessageKey:self.tempModelFrame}];
}

#pragma mark - 初始化
- (UICollectionView *)collectionView {
    if (!_collectionView) {
        // 设置布局
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        layout.itemSize = CGSizeMake(84.f, 78.f);
        layout.minimumLineSpacing = 8.f;
        
        // 初始化 UICollectionView
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.backgroundColor = [UIColor clearColor];
        [_collectionView registerClass:[OSRobotCombinationSpecialSubjectCell class] forCellWithReuseIdentifier:@"OSRobotCombinationSpecialSubjectCell"];
    }
    return _collectionView;
}

@end
