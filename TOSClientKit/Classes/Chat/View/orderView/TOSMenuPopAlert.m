//
//  TOSMenuPopAlert.m
//  TOSClientKit
//
//  Created by 李成 on 2024/11/7.
//  Copyright © 2024 YanBo. All rights reserved.
//  菜单弹窗

#import "TOSMenuPopAlert.h"
#import "TIMYYKit.h"
#import "TIMConstants.h"


@implementation TOSMenuConfiguration

- (instancetype)init {
    self = [super init];
    if (self) {
        self.showMaxRow = 5;
        self.rowHeight = 30.0f;
        self.backGroudColor = UIColor.clearColor;
        self.tableViewBackGroudColor = UIColor.whiteColor;
        self.tableViewBorderColor = UIColor.clearColor;
        self.tableViewBorderWidth = 1.0f;
        self.tableViewItemMinWidth = 80.0f;
        self.tableViewCornerRadius = 6.0f;
        
        
    }
    return self;
}



@end


@implementation TOSCustomMenuItem



@end


@interface TOSMenuPopAlert ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) NSArray<TOSCustomMenuItem *>                * dataSource;

/// 父视图
@property (nonatomic, strong) UIView                * bgView;

/// 列表的父视图
@property (nonatomic, strong) TOSMenuCustomBubbleView                * tableBgView;

/// 列表
@property (nonatomic, strong) TOSBaseTableView                * tableView;

/// 配置类
@property (nonatomic, strong) TOSMenuConfiguration                * config;

/// 数据源在列表数组中下标
@property (nonatomic, assign) NSInteger                index;

/// 数据源的下标起始位置
@property (nonatomic, assign) NSInteger                startIndex;

@end


@implementation TOSMenuPopAlert

/// 初始化实例
/// - Parameters:
///   - rect: 锚点位置
///   - array: 数据源
///   - config: 弹窗的配置项
///   - index: 数据源的下标
///   - startIndex: 数据源的下标起始位置
- (instancetype)initWithRect:(CGRect)rect withData:(NSArray<TOSCustomMenuItem*> *)array withConfig:(TOSMenuConfiguration *)config withIndex:(NSInteger)index withRangeStartIndex:(NSInteger)startIndex {
    self = [self initWithFrame:(CGRectMake(0, 0, App_Frame_Width, APP_Frame_Height))];
    if (self) {
        self.index = index;
        self.startIndex = startIndex;
        
        self.bgView.frame = self.frame;
        self.bgView.backgroundColor = config.backGroudColor;
        
        self.dataSource = array;
        self.config = config;
        CGFloat tableViewHeight = array.count > config.showMaxRow ? config.showMaxRow*config.rowHeight : array.count*config.rowHeight;
        
//        self.tableBgView.origin = rect.origin;
        /// 读取最低宽度
        CGFloat itemMinWidth = config.tableViewItemMinWidth;
        /// 遍历元素展示完全需要的配置
        for (TOSCustomMenuItem * item in array) {
            CGFloat testItemWidth = [self textContentWidth:item.title font:[UIFont fontWithName:@"PingFangSC-Regular" size:14.0f]]+28.0f;
            if (testItemWidth > itemMinWidth) {
                itemMinWidth = testItemWidth;
            }
        }
        
//        /// 阴影颜色
//        self.tableBgView.layer.shadowColor = [[UIColor colorWithHexString:@"#000000"] colorWithAlphaComponent:0.1].CGColor;
//        /// 阴影不透明度（0-1之间）
//        self.tableBgView.layer.shadowOpacity = 0.8;
//        /// 阴影偏移量
//        self.tableBgView.layer.shadowOffset = CGSizeMake(0.0, 10);
//        /// 阴影半径
//        self.tableBgView.layer.shadowRadius = 3.0;
        
//        self.tableBgView.backgroundColor = config.tableViewBackGroudColor;
        self.tableBgView.layer.borderWidth = config.tableViewBorderWidth;
        self.tableBgView.layer.borderColor = config.tableViewBorderColor.CGColor;
        self.tableBgView.layer.cornerRadius = config.tableViewCornerRadius;
        self.tableBgView.layer.maskedCorners = kCALayerMaxXMinYCorner | kCALayerMaxXMaxYCorner | kCALayerMinXMinYCorner;
        self.tableBgView.layer.masksToBounds = YES;
        
        CGFloat tableViewX = rect.origin.x+12.0f;
        if (tableViewX + itemMinWidth > kScreenWidth) {
            tableViewX = kScreenWidth - itemMinWidth - 15.0f;
        }
        
        /// 圆角在下方
        if (rect.origin.y > APP_Frame_Height/2) {
            self.tableBgView = [[TOSMenuCustomBubbleView alloc] initWithFrame:CGRectMake(tableViewX, CGRectGetMinY(rect)-tableViewHeight-2.0f, itemMinWidth, tableViewHeight + 10.0f)];
            self.tableBgView.arrowDirection = TOSMenuBubbleArrowDirectionDown;
//            self.tableBgView.frame = CGRectMake(tableViewX, CGRectGetMinY(rect)-tableViewHeight-10.0f, itemMinWidth, tableViewHeight + 10.0f);
            self.tableView.frame = CGRectMake(0.0, 0.0, itemMinWidth, tableViewHeight);
            
        }
        else {  /// 圆角在上方
            self.tableBgView = [[TOSMenuCustomBubbleView alloc] initWithFrame:CGRectMake(tableViewX, CGRectGetMaxY(rect)-18.0, itemMinWidth, tableViewHeight + 10.0f)];
            self.tableBgView.arrowDirection = TOSMenuBubbleArrowDirectionUp;
//            self.tableBgView.frame = CGRectMake(tableViewX, CGRectGetMaxY(rect), itemMinWidth, tableViewHeight + 10.0f);
            
            self.tableView.frame = CGRectMake(0.0, 10.0, itemMinWidth, tableViewHeight);
        }
        [self addSubview:self.tableBgView];
        [self.tableBgView addSubview:self.tableView];
        
        self.tableView.rowHeight = config.rowHeight;
        
        // 刷新 UITableView
        [self.tableView reloadData];
        
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
        [self addSubview:self.bgView];
        
        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapTouch)];
        [self.bgView addGestureRecognizer:tap];
        
        
    }
    return self;
}


#pragma mark - action

- (void)tapTouch {
    
    [self removeFromSuperview];
    
}

#pragma mark - Public
/// 添加到视图上
- (void)showView:(UIView *)superView {
    
    [superView addSubview:self];
    [self.tableView reloadData];
    
}

/// 添加到window上面
- (void)showWindow {
    
    if (@available(iOS 13.0, *)) {
        // 获取当前激活的 window scene
        UIWindow *keyWindow = nil;
        for (UIWindowScene *scene in [UIApplication sharedApplication].connectedScenes) {
            if (scene.activationState == UISceneActivationStateForegroundActive) {
                keyWindow = scene.windows.firstObject;
                break;
            }
        }

        // 检查并添加视图
        if (keyWindow) {
            [keyWindow addSubview:self];
        }
        
    } else {
        // 获取应用的主 window
        UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;

        [keyWindow addSubview:self];
    }
    [self.tableView reloadData];
    
}


/// 计算文本的宽度
- (CGFloat )textContentWidth:(NSString *)text font:(UIFont *)font {
    CGSize size = [text sizeWithAttributes:@{NSFontAttributeName : font}];
    return ceilf(size.width);
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:@"UITableViewCell"];
    }
    TOSCustomMenuItem * item = self.dataSource[indexPath.row];
    cell.textLabel.text = item.title?:@"";
    cell.textLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:13.0f];
    
    
    return cell;
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return self.config.rowHeight;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(TOSMenuPopAlertDidSelect:withSourceIndex:withStartIndex:)]) {
        [self.delegate TOSMenuPopAlertDidSelect:indexPath.row withSourceIndex:self.index withStartIndex:self.startIndex];
        [self removeFromSuperview];
    }
    
}

#pragma mark - lazy

- (UIView *)bgView {
    if (!_bgView) {
        _bgView = [[UIView alloc] initWithFrame:(CGRectZero)];
        _bgView.userInteractionEnabled = YES;
        
    }
    return _bgView;
}

//- (TOSMenuCustomBubbleView *)tableBgView {
//    if (!_tableBgView) {
//        _tableBgView = [[TOSMenuCustomBubbleView alloc] initWithFrame:(CGRectZero)];
////        _tableBgView.backgroundColor = [UIColor colorWithHexString:@"#FFFFFF"];
//        
//    }
//    return _tableBgView;
//}

- (TOSBaseTableView *)tableView {
    if (!_tableView) {
        _tableView = [[TOSBaseTableView alloc] initWithFrame:(CGRectZero)];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = UIColor.clearColor;
        
    }
    return _tableView;
}



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end



@implementation TOSMenuCustomBubbleView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        /// 阴影颜色
        self.layer.shadowColor = [[UIColor colorWithHexString:@"#000000"] colorWithAlphaComponent:0.1].CGColor;
        /// 阴影透明度
        self.layer.shadowOpacity = 0.8;
        /// 阴影偏移量
        self.layer.shadowOffset = CGSizeMake(5, 5);
        /// 阴影模糊半径
        self.layer.shadowRadius = 10;
        
        /// 设置背景颜色为透明
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

- (void)drawRect:(CGRect)rect {
    
    /// 设置气泡填充颜色
    UIColor *bubbleColor = [UIColor whiteColor];
    
    /// 创建路径
    UIBezierPath *bubblePath = [UIBezierPath bezierPath];
    
    /// 圆角值
    CGFloat cornerRadius = 0.0f;
    /// 尖角的宽
    CGFloat arrowWidth = 10.0f;
    /// 尖角的高
    CGFloat arrowHeight = 10.0f;
    /// 尖角离左侧边缘的偏移
    CGFloat arrowOffset = 0.0f;
        
    switch (self.arrowDirection) {
        case TOSMenuBubbleArrowDirectionUp: {
            // 绘制箭头朝上的气泡路径，尖角靠左
            [bubblePath moveToPoint:CGPointMake(cornerRadius, arrowHeight)];
            [bubblePath addLineToPoint:CGPointMake(arrowOffset, arrowHeight)];
            [bubblePath addLineToPoint:CGPointMake(arrowOffset, 0)];
            [bubblePath addLineToPoint:CGPointMake(arrowOffset + arrowWidth, arrowHeight)];
            [bubblePath addLineToPoint:CGPointMake(rect.size.width - cornerRadius, arrowHeight)];
            [bubblePath addArcWithCenter:CGPointMake(rect.size.width - cornerRadius, arrowHeight + cornerRadius)
                                  radius:cornerRadius
                              startAngle:-M_PI_2
                                endAngle:0
                               clockwise:YES];
            [bubblePath addLineToPoint:CGPointMake(rect.size.width, rect.size.height - cornerRadius)];
            [bubblePath addArcWithCenter:CGPointMake(rect.size.width - cornerRadius, rect.size.height - cornerRadius)
                                  radius:cornerRadius
                              startAngle:0
                                endAngle:M_PI_2
                               clockwise:YES];
            [bubblePath addLineToPoint:CGPointMake(cornerRadius, rect.size.height)];
            [bubblePath addArcWithCenter:CGPointMake(cornerRadius, rect.size.height - cornerRadius)
                                  radius:cornerRadius
                              startAngle:M_PI_2
                                endAngle:M_PI
                               clockwise:YES];
            [bubblePath addLineToPoint:CGPointMake(0, arrowHeight + cornerRadius)];
            [bubblePath addArcWithCenter:CGPointMake(cornerRadius, arrowHeight + cornerRadius)
                                  radius:cornerRadius
                              startAngle:M_PI
                                endAngle:-M_PI_2
                               clockwise:YES];
            break;
        }
        case TOSMenuBubbleArrowDirectionDown: {
            // 绘制箭头朝下的气泡路径，尖角靠左
            [bubblePath moveToPoint:CGPointMake(cornerRadius, 0)];
            [bubblePath addLineToPoint:CGPointMake(rect.size.width - cornerRadius, 0)];
            [bubblePath addArcWithCenter:CGPointMake(rect.size.width - cornerRadius, cornerRadius)
                                  radius:cornerRadius
                              startAngle:-M_PI_2
                                endAngle:0
                               clockwise:YES];
            [bubblePath addLineToPoint:CGPointMake(rect.size.width, rect.size.height - arrowHeight - cornerRadius)];
            [bubblePath addArcWithCenter:CGPointMake(rect.size.width - cornerRadius, rect.size.height - arrowHeight - cornerRadius)
                                  radius:cornerRadius
                              startAngle:0
                                endAngle:M_PI_2
                               clockwise:YES];
            [bubblePath addLineToPoint:CGPointMake(arrowOffset + arrowWidth, rect.size.height - arrowHeight)];
            [bubblePath addLineToPoint:CGPointMake(arrowOffset, rect.size.height)];
            [bubblePath addLineToPoint:CGPointMake(arrowOffset, rect.size.height - arrowHeight)];
            [bubblePath addLineToPoint:CGPointMake(cornerRadius, rect.size.height - arrowHeight)];
            [bubblePath addArcWithCenter:CGPointMake(cornerRadius, rect.size.height - arrowHeight - cornerRadius)
                                  radius:cornerRadius
                              startAngle:M_PI_2
                                endAngle:M_PI
                               clockwise:YES];
            [bubblePath addLineToPoint:CGPointMake(0, cornerRadius)];
            [bubblePath addArcWithCenter:CGPointMake(cornerRadius, cornerRadius)
                                  radius:cornerRadius
                              startAngle:M_PI
                                endAngle:-M_PI_2
                               clockwise:YES];
            break;
        }
        case TOSMenuBubbleArrowDirectionLeft: {
            // 绘制箭头朝左的气泡路径，尖角靠上
            [bubblePath moveToPoint:CGPointMake(arrowHeight, cornerRadius)];
            [bubblePath addLineToPoint:CGPointMake(0, cornerRadius)];
            [bubblePath addLineToPoint:CGPointMake(arrowHeight, cornerRadius / 2)];
            [bubblePath addLineToPoint:CGPointMake(arrowHeight, rect.size.height - cornerRadius)];
            [bubblePath addArcWithCenter:CGPointMake(arrowHeight + cornerRadius, rect.size.height - cornerRadius)
                                  radius:cornerRadius
                              startAngle:M_PI
                                endAngle:M_PI_2
                               clockwise:YES];
            [bubblePath addLineToPoint:CGPointMake(rect.size.width - cornerRadius, rect.size.height)];
            [bubblePath addArcWithCenter:CGPointMake(rect.size.width - cornerRadius, rect.size.height - cornerRadius)
                                  radius:cornerRadius
                              startAngle:M_PI_2
                                endAngle:0
                               clockwise:YES];
            [bubblePath addLineToPoint:CGPointMake(rect.size.width, cornerRadius)];
            [bubblePath addArcWithCenter:CGPointMake(rect.size.width - cornerRadius, cornerRadius)
                                  radius:cornerRadius
                              startAngle:0
                                endAngle:-M_PI_2
                               clockwise:YES];
            [bubblePath addLineToPoint:CGPointMake(arrowHeight + cornerRadius, 0)];
            [bubblePath addArcWithCenter:CGPointMake(arrowHeight + cornerRadius, cornerRadius)
                                  radius:cornerRadius
                              startAngle:-M_PI_2
                                endAngle:M_PI
                               clockwise:YES];
            break;
        }
        case TOSMenuBubbleArrowDirectionRight: {
            // 绘制箭头朝右的气泡路径，尖角靠上
            [bubblePath moveToPoint:CGPointMake(cornerRadius, 0)];
            [bubblePath addLineToPoint:CGPointMake(rect.size.width - arrowHeight - cornerRadius, 0)];
            [bubblePath addArcWithCenter:CGPointMake(rect.size.width - arrowHeight - cornerRadius, cornerRadius)
                                  radius:cornerRadius
                              startAngle:-M_PI_2
                                endAngle:0
                               clockwise:YES];
            [bubblePath addLineToPoint:CGPointMake(rect.size.width - arrowHeight, cornerRadius / 2)];
            [bubblePath addLineToPoint:CGPointMake(rect.size.width, cornerRadius)];
            [bubblePath addLineToPoint:CGPointMake(rect.size.width - arrowHeight, rect.size.height - cornerRadius)];
            [bubblePath addArcWithCenter:CGPointMake(rect.size.width - arrowHeight - cornerRadius, rect.size.height - cornerRadius)
                                  radius:cornerRadius
                              startAngle:0
                                endAngle:M_PI_2
                               clockwise:YES];
            [bubblePath addLineToPoint:CGPointMake(cornerRadius, rect.size.height)];
            [bubblePath addArcWithCenter:CGPointMake(cornerRadius, rect.size.height - cornerRadius)
                                  radius:cornerRadius
                              startAngle:M_PI_2
                                endAngle:M_PI
                               clockwise:YES];
            [bubblePath addLineToPoint:CGPointMake(0, cornerRadius)];
            [bubblePath addArcWithCenter:CGPointMake(cornerRadius, cornerRadius)
                                  radius:cornerRadius
                              startAngle:M_PI
                                endAngle:-M_PI_2
                               clockwise:YES];
            break;
        }
    }
    
    [bubblePath addClip];
    
    // 填充路径
    [bubbleColor setFill];
    [bubblePath fill];
}

@end

