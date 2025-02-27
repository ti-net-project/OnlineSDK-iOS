//
//  TOSOrderListTableViewCell.m
//  TOSClientKit
//
//  Created by 李成 on 2024/10/31.
//  Copyright © 2024 YanBo. All rights reserved.
//

#import "TOSOrderListTableViewCell.h"
#import "TIMMasonry.h"
#import "TIMConstants.h"
#import "YYKit.h"

#import "TOSOrderListTopView.h"
#import "TOSOrderListItemView.h"
#import "TOSOrderListFunctionView.h"
#import "TOSOrderListBottomView.h"


@interface TOSOrderListTableViewCell ()<TOSOrderListFunctionViewDelegate, TOSOrderListBottomViewDelegate, TOSOrderListItemViewDelegate>

/// 容器父视图
@property (nonatomic, strong) UIView                * bgView;

/// 顶部店铺
@property (nonatomic, strong) TOSOrderListTopView                * topView;

/// 功能按钮区域
@property (nonatomic, strong) TOSOrderListFunctionView                * functionView;

/// 自定义参数的值
@property (nonatomic, strong) TOSOrderListBottomView                * bottomCustomView;

@end


@implementation TOSOrderListTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.contentView.backgroundColor = [UIColor clearColor];
        self.backgroundColor = [UIColor clearColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.contentView.userInteractionEnabled = YES;
        [self.contentView addSubview:self.bgView];
//        [self.bgView addSubview:self.topView];
//        [self.bgView addSubview:self.functionView];
        [self.bgView addSubview:self.bottomCustomView];
        
        [self.bgView mas_TIMmakeTIMConstraints:^(TIMMASConstraintMaker *make) {
            make.leading.mas_TIMequalTo(16.0f);
            make.trailing.mas_TIMequalTo(-16.0f);
            make.top.mas_TIMequalTo(12.0f);
            make.bottom.mas_TIMequalTo(0.0f);
        }];
        
        [self.bottomCustomView mas_TIMmakeTIMConstraints:^(TIMMASConstraintMaker *make) {
            make.left.right.mas_TIMequalTo(0);
            make.bottom.equalTo(self.bgView.mas_TIMbottom);
            make.height.mas_TIMequalTo(0);
        }];
        
        
//        self.functionView.itemsArray = @[@"测试一下", @"拉了深刻的快打开啊啥情况啊", @"哈哈", @"大大大", @"更多更多"];
        
    }
    return self;
}


#pragma mark - TOSOrderListItemViewDelegate

- (void)TOSOrderListItemViewFunctionClick:(NSInteger)index withModel:(TOSOrderListProductModel *)model {
    
//    NSUInteger idx = [self.model.productList indexOfObject:model];
    TOSOrderButtonConfigModel * btnModel = model.buttonConfigList[index];
    NSLog(@"商品按钮点击了：%@", btnModel.text);
    if (self.delegate && [self.delegate respondsToSelector:@selector(TOSOrderListTableViewCellProductFunctionClick:withModel:withProductModel:)]) {
        [self.delegate TOSOrderListTableViewCellProductFunctionClick:index withModel:self.model withProductModel:model];
    }
    
    
}


- (void)TOSOrderListItemViewCradTouchClick:(NSInteger)index withModel:(TOSOrderListProductModel *)productModel {
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(TOSOrderListTableViewCellProductModel:withModel:)]) {
        [self.delegate TOSOrderListTableViewCellProductModel:productModel withModel:self.model];
    }
    
    
}


#pragma mark - TOSOrderListBottomViewDelegate

- (void)TOSOrderListBottomViewMoreClink {
    self.model.showMore = !self.model.showMore;
    if (self.delegate && [self.delegate respondsToSelector:@selector(TOSOrderListTableViewCellCustomMoreClick:withIndex:)]) {
        [self.delegate TOSOrderListTableViewCellCustomMoreClick:self.model withIndex:self.tag];
    }
}

#pragma mark - TOSOrderListFunctionViewDelegate

- (void)TOSOrderListFunctionViewClink:(NSInteger)index {
    
    if (index == -1) {
        NSLog(@"更多按钮点击，需要展示选择弹窗");
        if (self.delegate && [self.delegate respondsToSelector:@selector(TOSOrderListTableViewCellFunctionMoreClick:withModel:withRect:)]) {
            // 将子视图的 frame 转换为相对于屏幕的坐标
            CGRect subviewFrameInScreen = [self.functionView convertRect:self.functionView.bounds toView:nil];

            [self.delegate TOSOrderListTableViewCellFunctionMoreClick:self.functionView.moreIndex withModel:self.model withRect:subviewFrameInScreen];
        }
        return;
    }
    if (index == -2) {
        if (self.delegate && [self.delegate respondsToSelector:@selector(TOSOrderListTableViewCellBottomFunctionClick:withModel:)]) {
            [self.delegate TOSOrderListTableViewCellBottomFunctionClick:index withModel:self.model];
        }
        return;
    }
    TOSOrderButtonConfigModel * model = self.model.buttonConfigList[index];
    NSLog(@"点击了第%ld个, 按钮的文案是：%@", index, model.text);
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(TOSOrderListTableViewCellFunctionClick:withModel:)]) {
        [self.delegate TOSOrderListTableViewCellFunctionClick:index withModel:self.model];
    }
    
}


#pragma mark - 重用池的系统方法，需要对cell的子视图进行重置处理

- (void)prepareForReuse {
    [super prepareForReuse];
    
    [self.topView prepareForReuse];
    
    for (UIView * view in self.bgView.subviews) {
        [view removeFromSuperview];
    }
    
}

#pragma mark - setter/getter

- (void)setModel:(TOSOrderListModel *)model {
    _model = model;
    CGFloat itemTotalHeight = 60.0f;
    if (![model.title isNotBlank] && ![model.status isNotBlank] && ![model.logo isNotBlank] && ![model.time isNotBlank]) {
        self.topView.height_sd = 0.0f;
        itemTotalHeight = 0.0f;
    }
    [self.bgView addSubview:self.topView];
    self.topView.model = model;
    
    for (NSInteger i = 0; i < model.productList.count; i++) {
        TOSOrderListProductModel * productModel = model.productList[i];
        CGFloat itemHeight = 88.0f;
        if (productModel.buttonConfigList.count>0) {
            itemHeight += productModel.totalFunctionHeight;
        }
        TOSOrderListItemView * itemView = [[TOSOrderListItemView alloc] initWithFrame:(CGRectMake(0.0, itemTotalHeight, App_Frame_Width-32.0, itemHeight))];
        itemView.tag = i;
        itemView.delegate = self;
        itemView.model = productModel;
        [self.bgView addSubview:itemView];
        itemTotalHeight += itemHeight;
    }
    
    [self.bgView addSubview:self.functionView];
    /// 底部功能按钮的数据
    if (model.buttonConfigList.count > 0) {
//        NSLog(@"按钮的数据：%@", model.buttonConfigList);
        self.functionView.itemsArray = model.buttonConfigList;
    }
    /// 底部功能按钮的右下角
    if (model.bottomButtonConfig) {
        self.functionView.bottomModel = model.bottomButtonConfig;
    }
    
    [self.functionView mas_TIMmakeTIMConstraints:^(TIMMASConstraintMaker *make) {
        make.left.right.mas_TIMequalTo(0);
        make.top.mas_TIMequalTo(itemTotalHeight);
        make.height.mas_TIMequalTo(model.functionHeight);
    }];
    
    [self.bgView addSubview:self.bottomCustomView];
//    CGFloat bottomCustomHeight = 0.0f;
//    if (model.showMore) {
//        bottomCustomHeight = model.extraInfoArr.count * 22.0f + 4.0 + 12.0;
//        NSLog(@"展开: %lf", bottomCustomHeight);
//    }
//    else {
//        if (model.extraInfoArr.count > 3) {
//            bottomCustomHeight = 89.0f;
//        }
//        else if (model.extraInfoArr.count) {
//            bottomCustomHeight = model.extraInfoArr.count * 22.0f + 4.0 + 12.0;
//        }
//        NSLog(@"收起: %lf", bottomCustomHeight);
//    }
    
    self.bottomCustomView.model = model;
    
    [self.bottomCustomView mas_TIMupdateTIMConstraints:^(TIMMASConstraintMaker *make) {
        make.left.right.mas_TIMequalTo(0);
        make.bottom.equalTo(self.bgView.mas_TIMbottom);
        make.height.mas_TIMequalTo(model.bottomCustomHeight);
    }];
    
    
}




#pragma mark - lazy

- (UIView *)bgView {
    if (!_bgView) {
        _bgView = [[UIView alloc] initWithFrame:(CGRectZero)];
        _bgView.backgroundColor = TOSKitCustomInfo.shareCustomInfo.orderDrawer.backGroundColor;
        _bgView.layer.cornerRadius = TOSKitCustomInfo.shareCustomInfo.orderDrawer.orderCorner;
        _bgView.layer.masksToBounds = YES;
        
        
    }
    return _bgView;
}

- (TOSOrderListTopView *)topView {
    if (!_topView) {
        _topView = [[TOSOrderListTopView alloc] initWithFrame:(CGRectMake(0.0, 0.0, App_Frame_Width-32.0f, 60.0))];
        
    }
    return _topView;
}


- (TOSOrderListFunctionView *)functionView {
    if (!_functionView) {
        _functionView = [[TOSOrderListFunctionView alloc] initWithFrame:(CGRectZero)];
        _functionView.delegate = self;
        
    }
    return _functionView;
}

- (TOSOrderListBottomView *)bottomCustomView {
    if (!_bottomCustomView) {
        _bottomCustomView = [[TOSOrderListBottomView alloc] initWithFrame:(CGRectZero)];
        _bottomCustomView.delegate = self;
        
    }
    return _bottomCustomView;
}



- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
