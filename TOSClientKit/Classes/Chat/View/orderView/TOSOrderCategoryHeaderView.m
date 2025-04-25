//
//  TOSOrderCategoryHeaderView.m
//  TOSClientKit
//
//  Created by 李成 on 2025/1/6.
//  Copyright © 2025 YanBo. All rights reserved.
//  订单分类head

#import "TOSOrderCategoryHeaderView.h"
#import "TIMMasonry.h"
#import "TIMYYKit.h"

@interface TOSOrderCategoryHeaderView ()

/**标题宽度*/
@property (nonatomic, assign) CGFloat titleWidth;

/** 标题间距 */
@property (nonatomic, assign) CGFloat titleMargin;

/** 所有标题数组 */
@property (nonatomic, strong) NSMutableArray * titleLabels;

/** 所有标题宽度数组 */
@property (nonatomic, strong) NSMutableArray *titleWidths;

/**标题滚动视图*/
@property (nonatomic, strong)UIScrollView * titleScrollView;

/**下滑线*/
@property (nonatomic, weak) UIView * underLine;
/**下标颜色*/
@property (nonatomic, strong) UIColor *underLineColor;
/**下标高度 */
@property (nonatomic, assign) CGFloat underLineH;

/** 记录上一次内容滚动视图偏移量 */
@property (nonatomic, assign) CGFloat lastOffsetX;

@end

// 默认标题间距
static CGFloat const margin = 12;
// 下划线默认高度
static CGFloat const TeilUnderLineH = 4;
/// 默认字体大小
static CGFloat const TeilDefaultFontSize = 12;
/// 选中字体大小
static CGFloat const TeilSelectedFontSize = 12;
/// item的高度
static CGFloat const TeilLabelHeight = 24;

@implementation TOSOrderCategoryHeaderView

- (instancetype)initWithFrame:(CGRect)frame items:(NSArray *)items {
    self = [super initWithFrame:frame];
    if (self) {
        
        self.itemsArray = items;
        
        self.selectIndex = 0;
        
        self.titleMargin = 16;
        
        self.labelTopMargin = -1;
        
        self.underLineYOffset = 0;
        
        
        [self setUpViews];
        
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
        
        
    }
    return self;
}


- (void)setUpViews {
    
    self.selectTextColor = [UIColor colorWithHexString:@"#2496FF"];
    self.defaultTextColor = [UIColor colorWithHexString:@"#595959"];
    self.selectFontSize = TeilSelectedFontSize;
    self.defaultFontSize = TeilDefaultFontSize;
    self.selectIndex = 0;
    
    [self addSubview:self.titleScrollView];
    [self.titleScrollView mas_TIMmakeTIMConstraints:^(TIMMASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    
    /// 计算标题宽度
    [self calculatorWidths];
    [self setUpSegmentView];
    
}

- (void)calculatorWidths{
    
    /// 判断是否能占据整个屏幕
    [self.titleWidths removeAllObjects];
    if (self.selectIndex > self.itemsArray.count) {
        self.selectIndex = 0;
    }
    CGFloat totalWidth = 0;
    /// 计算所有标题的宽度
    
    for (NSString *title in self.itemsArray) {
        
        NSString *currentTitle = self.itemsArray[self.selectIndex];
        
        NSMutableDictionary *dic;
        if ([currentTitle isEqualToString:title]) {
           dic = [NSMutableDictionary dictionaryWithObject:[UIFont systemFontOfSize:TeilSelectedFontSize+4 weight:(UIFontWeightSemibold)] forKey:NSFontAttributeName];
        }else {
            dic = [NSMutableDictionary dictionaryWithObject:[UIFont systemFontOfSize:TeilDefaultFontSize+4] forKey:NSFontAttributeName];
        }
        
        CGSize size = [title boundingRectWithSize:CGSizeMake(MAXFLOAT, 0.0) options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil].size;
        
        CGFloat width = ceil(size.width);
        [self.titleWidths addObject:@(width)];
        
        totalWidth += width;
    }
    
    _titleMargin = margin;
    
    self.titleScrollView.contentInset = UIEdgeInsetsMake(0, 0, 0, _titleMargin);
}

- (void)setUpSegmentView{
    
    for (UIView * item in self.titleScrollView.subviews) {
        if ([item isKindOfClass:[UILabel class]]) {
            [item removeFromSuperview];
        }
    }
    if (self.titleLabels.count) {
        [self.titleLabels removeAllObjects];
    }
    
    /// 添加所有的标题
    CGFloat labelW = _titleWidth;
    CGFloat labelH = TeilLabelHeight;
    CGFloat labelX = 16.0;
    CGFloat labelY = self.labelTopMargin > 0 ? self.labelTopMargin : 0;
    
    for (int i = 0; i < self.itemsArray.count; i++) {
        
        UILabel *label = [[UILabel alloc] init];
        label.userInteractionEnabled = YES;
        label.text = self.itemsArray[i];
        label.tag = i;
        label.layer.cornerRadius = 2.0f;
        label.layer.masksToBounds = YES;
        label.textAlignment = 1;
        
        /// 设置按钮的文字颜色
        if (self.selectIndex == i) {
            label.textColor = self.selectTextColor;
            label.font = [UIFont systemFontOfSize:self.selectFontSize weight:(UIFontWeightSemibold)];
        }else {
            label.textColor = self.defaultTextColor;
            label.font = [UIFont systemFontOfSize:self.defaultFontSize];
        }
        
        labelW = [self.titleWidths[i] floatValue];
        
        /// 设置按钮位置
        UILabel * lastLabel = [self.titleLabels lastObject];
        if (i == 0) {
            labelX = CGRectGetMaxX(lastLabel.frame)+labelX;
        }else {
            labelX = _titleMargin + CGRectGetMaxX(lastLabel.frame);
        }

        label.frame = CGRectMake(labelX, labelY, labelW, labelH);
        NSLog(@"item的位置：%@", NSStringFromCGRect(label.frame));
        /// 监听标题的点击
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(titleClick:)];
        [label addGestureRecognizer:tap];
        
        /// 保存到数组
        [self.titleLabels addObject:label];
        
        [self.titleScrollView addSubview:label];
    
    }
    
    if (_isShowUnderLine) {
        [self setUpUnderLine:self.titleLabels.firstObject];
    }
    
    /// 设置标题滚动视图的内容范围
    UILabel *lastLabel = self.titleLabels.lastObject;
    self.titleScrollView.contentSize = CGSizeMake(CGRectGetMaxX(lastLabel.frame), 0);
    NSLog(@"滑动的范围：%@", NSStringFromCGSize(self.titleScrollView.contentSize));
    
    
}

- (void)titleClick:(UITapGestureRecognizer *)tap{
    /// 获取对应标题label
    UILabel *label = (UILabel *)tap.view;
    
    /// 获取当前角标
    NSInteger i = label.tag;
    
    if ([self.delegate respondsToSelector:@selector(TOSOrderCategoryHeaderViewSelected:)]) {
        [self.delegate TOSOrderCategoryHeaderViewSelected:i];
    }
    
}



///  选中标题
- (void)selectLabel:(UILabel *)label {
    for (UILabel *labelView in self.titleLabels) {
        if (label == labelView) continue;
        
        labelView.transform = CGAffineTransformIdentity;
        
        labelView.textColor = self.defaultTextColor;
        labelView.font = [UIFont systemFontOfSize:self.defaultFontSize];
    }
    
    [self calculatorWidths];
    
    /// 更新label 宽度
    for (int i = 0; i < self.titleLabels.count; i++) {
        
        UILabel *label = self.titleLabels[i];
        
        if (i == self.selectIndex) {
            /// 修改标题选中颜色
            label.textColor = self.selectTextColor;
            label.font = [UIFont systemFontOfSize:self.selectFontSize weight:(UIFontWeightSemibold)];
        }
        
        CGFloat labelW = [self.titleWidths[i] floatValue];
        
        CGFloat labelX = 16.0f;
        
        if (i != 0) {
            UILabel *lastLabel = self.titleLabels[i - 1];
            labelX = _titleMargin + CGRectGetMaxX(lastLabel.frame);
        }
    
        CGFloat labelH = TeilLabelHeight;
        CGFloat labelY = self.labelTopMargin >0 ? self.labelTopMargin : 0;
        label.frame = CGRectMake(labelX, labelY, labelW, labelH);
    }
    
    
    /// 设置标题居中
    [self setLabelTitleCenter:label];
    
    /// 设置下标的位置
    if (self.isShowUnderLine) {
        [self setUpUnderLine:label];
    }
}

/// 让选中的按钮居中显示
- (void)setLabelTitleCenter:(UILabel *)label {
    
    if (self.titleScrollView.contentSize.width <= self.width_sd) return;
    
    CGFloat offsetX = label.center.x - self.width_sd * 0.5;
    
    offsetX = offsetX > 0 ? offsetX : 0;
    
    CGFloat maxOffsetX = self.titleScrollView.contentSize.width - self.width_sd + _titleMargin;
    
    maxOffsetX = maxOffsetX ?:0;
    
    offsetX = offsetX > maxOffsetX ? maxOffsetX : offsetX;
    
    [self.titleScrollView setContentOffset:CGPointMake(offsetX, 0) animated:YES];
    
}


// 设置下标的位置
- (void)setUpUnderLine:(UILabel *)label {
    
    CGFloat width = 20.0;
    
    CGFloat underLineH = _underLineH?_underLineH:TeilUnderLineH;
    
//    self.underLine.right_sd = label.bottom_sd - underLineH/2 + self.underLineYOffset;
    self.underLine.height_sd = underLineH;
    
    /// 最开始不需要动画
    if (self.underLine.left_sd == 0) {
        self.underLine.tos_width = width;
        self.underLine.tos_centerX = label.tos_centerX;
        self.underLine.tos_top = label.tos_bottom+self.underLineYOffset;
        return;
    }
    
    /// 点击时候需要动画
    [UIView animateWithDuration:0.25 animations:^{
        self.underLine.tos_width = width;
        self.underLine.tos_centerX = label.tos_centerX;
        self.underLine.tos_top = label.tos_bottom+self.underLineYOffset;
        
    }];
    
}



// 设置下标偏移
- (void)setUpUnderLineOffset:(CGFloat)offsetX rightLabel:(UILabel *)rightLabel leftLabel:(UILabel *)leftLabel {
   
    // 获取两个标题中心点距离
    CGFloat centerDelta = rightLabel.left_sd - leftLabel.left_sd;
    // 标题宽度差值
    CGFloat widthDelta = [self widthDeltaWithRightLabel:rightLabel leftLabel:leftLabel];
    // 获取移动距离
    CGFloat offsetDelta = offsetX - _lastOffsetX;
    // 计算当前下划线偏移量
    CGFloat underLineTransformX = offsetDelta * centerDelta / kScreenWidth;
    // 宽度递增偏移量
    CGFloat underLineWidth = offsetDelta * widthDelta / kScreenWidth;
    
    self.underLine.width_sd += underLineWidth;
    self.underLine.left += underLineTransformX;
    
}

// 获取两个标题按钮宽度差值
- (CGFloat)widthDeltaWithRightLabel:(UILabel *)rightLabel leftLabel:(UILabel *)leftLabel {
    CGRect titleBoundsR = [rightLabel.text boundingRectWithSize:CGSizeMake(MAXFLOAT, 0) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:@(15)} context:nil];
    
    CGRect titleBoundsL = [leftLabel.text boundingRectWithSize:CGSizeMake(MAXFLOAT, 0) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:@(15)} context:nil];
    
    return titleBoundsR.size.width - titleBoundsL.size.width;
}



#pragma mark -  set方法
- (void)setItemsArray:(NSArray *)itemsArray {
    _itemsArray = itemsArray;
    
    for (UIView * testView in self.titleScrollView.subviews) {
        [testView removeFromSuperview];
    }
    [self.titleLabels removeAllObjects];
    
    self.titleScrollView.bounds = self.bounds;
    /// 计算标题宽度
    [self calculatorWidths];
    [self setUpSegmentView];
    if (self.isShowUnderLine) {
        [self.titleScrollView addSubview:self.underLine];
    }
    
}


- (void)didMoveToSuperview {
    [super didMoveToSuperview];
    self.selectIndex = 0;
}


- (void)setSelectIndex:(NSInteger)selectIndex {
    _selectIndex = selectIndex;
   
    if (selectIndex < 0) {
        return;
    }
    if (selectIndex > self.itemsArray.count) {
        _selectIndex = 0;
    }
    
    if (self.titleLabels.count) {
        UILabel *label = self.titleLabels[_selectIndex];
        if (_selectIndex >= self.titleLabels.count) {
            @throw [NSException exceptionWithName:@"Teil_ERROR" reason:@"选中控制器的角标越界" userInfo:nil];
        }
//        [self titleClick:[label.gestureRecognizers firstObject]];
        [self selectLabel:label];
    }

}

#pragma mark -  懒加载

- (UIScrollView *)titleScrollView {
    if (!_titleScrollView) {
        _titleScrollView = [[UIScrollView alloc] init];
        _titleScrollView.backgroundColor = [UIColor clearColor];
        _titleScrollView.showsHorizontalScrollIndicator = NO;
      
        
    }
    return _titleScrollView;
}

- (NSMutableArray *)titleWidths {
    if (!_titleWidths) {
        _titleWidths = [NSMutableArray array];
    }
    return _titleWidths;
}
- (NSMutableArray *)titleLabels {
    if (!_titleLabels) {
        _titleLabels = [NSMutableArray array];
    }
    return _titleLabels;
}

- (UIView *)underLine {
    if (_underLine == nil) {
        UIView *underLineView = [[UIView alloc] init];
        underLineView.backgroundColor = _underLineColor?_underLineColor:[UIColor colorWithHexString:@"#4385FF"];
        underLineView.layer.cornerRadius = 2;
        underLineView.layer.masksToBounds = YES;
        [self.titleScrollView addSubview:underLineView];
        _underLine = underLineView;
    }
    return _underLine;
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
