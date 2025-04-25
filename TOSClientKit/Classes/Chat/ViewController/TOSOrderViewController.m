//
//  TOSOrderViewController.m
//  TOSClientKit
//
//  Created by 李成 on 2024/10/30.
//  Copyright © 2024 YanBo. All rights reserved.
//  订单抽屉

#import "TOSOrderViewController.h"
#import "TIMConstants.h"
#import "TIMYYKit.h"
#import "HWPanModal.h"
#import "TIMMasonry.h"
#import "UIButton+TIMEnlargeEdge.h"
#import "TOSOrderSearchView.h"
#import "TOSOrderNoDataView.h"
#import "TOSOrderListTableViewCell.h"
#import "TOSKitCustomInfo.h"
#import "TOSMenuPopAlert.h"
#import <TOSClientLib/OnlineRequestManager.h>
#import "WHToast.h"
#import "UIScrollView+TIMRefresh.h"
#import "TOSSDKConfigModel.h"
#import "TOSOrderCategoryHeaderView.h"
#import "TOSOrderListViewController.h"

@interface TOSOrderViewController ()<TOSOrderCategoryHeaderViewDelegate, UIScrollViewDelegate, TOSOrderListViewControllerDelegate>
// <HWPanModalPresentable, TOSOrderSearchViewDelegate, UITableViewDelegate, UITableViewDataSource, TOSOrderListTableViewCellDelegate, TOSMenuPopAlertDelegate>

@property (nonatomic, strong) UIView                * bgView;

/// 标题
@property (nonatomic, strong) UILabel                * titleView;

/// 关闭按钮
@property (nonatomic, strong) UIButton                * closeBtn;

@property (nonatomic, strong) TOSOrderCategoryHeaderView                * headerView;

/// 列表滑动
@property (nonatomic, strong) UIScrollView                * contentScrollView;

/// UINavigationBarAppearance样式
@property (nonatomic, strong) UINavigationBarAppearance                * appearance;

/// navigation的颜色值等信息，在进入该页面时需要设置为透明，离开时需要重新赋值为原来的颜色值，所以需要在页面中记录，在页面离开和加载时设置
@property (nonatomic, strong) NSDictionary *savedTitleTextAttributes;

@end

@implementation TOSOrderViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    if (@available(iOS 11.0, *)) {
        self.navigationController.navigationBar.prefersLargeTitles = NO;
    } else {
        // Fallback on earlier versions
    }
    /// 隐藏导航栏
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    /// 设置UINavigationController为透明样式
    [self makeNavigationControllerCompletelyTransparent];
    
}


- (void)makeNavigationControllerCompletelyTransparent {

    /// 设置整个 UINavigationController.view 的背景透明
    self.navigationController.view.backgroundColor = [UIColor clearColor];
    /// 保存 titleTextAttributes
    if (![self.savedTitleTextAttributes allKeys].count) {
        self.savedTitleTextAttributes = self.navigationController.navigationBar.titleTextAttributes;
    }
    
    
    /// iOS 15+ 导航栏外观设置
    if (@available(iOS 15.0, *)) {
        UINavigationBarAppearance *appearance = [[UINavigationBarAppearance alloc] init];
        if (self.appearance == nil) {
            self.appearance = self.navigationController.navigationBar.standardAppearance.copy;
        }
        [appearance configureWithTransparentBackground];
        appearance.titleTextAttributes = @{NSForegroundColorAttributeName : [UIColor clearColor]};
        self.navigationController.navigationBar.standardAppearance = appearance;
        self.navigationController.navigationBar.scrollEdgeAppearance = appearance;
    }
    
    /// 设置导航栏透明
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.shadowImage = [UIImage new];
    self.navigationController.navigationBar.translucent = YES;
    self.navigationController.navigationBar.backgroundColor = [UIColor clearColor];
    
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    
    if (@available(iOS 15.0, *)) {
        /// 如果保存了UINavigationBarAppearance，就需要在页面将要离开时还原之前的配置
        if (self.appearance) {
            self.navigationController.navigationBar.standardAppearance = self.appearance;
            self.navigationController.navigationBar.scrollEdgeAppearance = self.appearance;
        }
        
    }
    /// 恢复 titleTextAttributes
    if (self.savedTitleTextAttributes) {
        self.navigationController.navigationBar.titleTextAttributes = self.savedTitleTextAttributes;
    }

    /// 如果需要恢复背景图片或阴影，也可以在这里处理
    [self.navigationController.navigationBar setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.shadowImage = nil;
    self.navigationController.navigationBar.translucent = NO;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor.blackColor colorWithAlphaComponent:0.3];
    
    [self.view addSubview:self.bgView];
    [self.bgView addSubview:self.titleView];
    [self.bgView addSubview:self.closeBtn];
    
    if (self.titleStr.length) {
        self.titleView.text = self.titleStr;
    }
    
    [self.bgView mas_TIMmakeTIMConstraints:^(TIMMASConstraintMaker *make) {
        make.bottom.mas_TIMequalTo(0.0);
        make.left.right.mas_TIMequalTo(0.0f);
        make.height.mas_TIMequalTo(APP_Frame_Height*0.8f);
    }];
    
    [self.titleView mas_TIMmakeTIMConstraints:^(TIMMASConstraintMaker *make) {
        make.leading.mas_TIMequalTo(80.0f);
        make.trailing.mas_TIMequalTo(-80.0f);
        make.top.mas_TIMequalTo(18.0f);
        make.height.mas_TIMequalTo(24.0f);
    }];
    
    [self.closeBtn mas_TIMmakeTIMConstraints:^(TIMMASConstraintMaker *make) {
        make.width.height.mas_TIMequalTo(20.0f);
        make.top.mas_TIMequalTo(20.0f);
        make.right.mas_TIMequalTo(-24.0f);
    }];
    
    
    CGFloat modalHeight = APP_Frame_Height*0.8;
    if (self.param) {
        if ([self.param objectForKey:@"categoryDisplay"]) {
            NSNumber * categoryDisplay = self.param[@"categoryDisplay"];
            if (categoryDisplay.boolValue) {
                self.headerView = [[TOSOrderCategoryHeaderView alloc] initWithFrame:(CGRectMake(0, 42.0f, CGRectGetWidth(self.view.frame), 50.0f)) items:self.param[@"categoryList"]];
                self.headerView.labelTopMargin = 12.0f;
                self.headerView.isShowUnderLine = YES;
                self.headerView.selectTextColor = [UIColor colorWithHexString:@"#262626"];
                self.headerView.selectFontSize = 14.0f;
                self.headerView.defaultTextColor = [UIColor colorWithHexString:@"#595959"];
                self.headerView.defaultFontSize = 14.0f;
                self.headerView.underLineYOffset = 2.0f;
                self.headerView.delegate = self;
                [self.bgView addSubview:self.headerView];
                
                [self.bgView addSubview:self.contentScrollView];
                
                [self.contentScrollView mas_TIMmakeTIMConstraints:^(TIMMASConstraintMaker *make) {
                    make.left.right.mas_TIMequalTo(0.0f);
                    make.top.mas_TIMequalTo(self.headerView.bottom_sd);
                    make.height.mas_TIMequalTo(modalHeight-92.0f);
                }];
                
                
                [self setupChildControllers];
                
            }
            else {
                [self.bgView addSubview:self.contentScrollView];
                
                [self.contentScrollView mas_TIMmakeTIMConstraints:^(TIMMASConstraintMaker *make) {
                    make.left.right.mas_TIMequalTo(0.0f);
                    make.top.mas_TIMequalTo(42.0f);
                    make.height.mas_TIMequalTo(modalHeight-42.0f);
                }];
                
                TOSOrderListViewController * listView = [[TOSOrderListViewController alloc] init];
                listView.searchPlaceholder = self.searchPlaceholder;
                listView.showSearch = self.showSearch;
                listView.passiveEvoke = self.passiveEvoke;
                listView.param = self.param;
                listView.delegate = self;
                [self addChildViewController:listView];
                
                self.contentScrollView.contentSize = CGSizeMake(App_Frame_Width, 0);
                self.contentScrollView.contentOffset = CGPointMake(0, 0);
                
                [self scrollViewDidEndScrollingAnimation:self.contentScrollView];
                
            }
        }
        else {
            [self.bgView addSubview:self.contentScrollView];
            
            [self.contentScrollView mas_TIMmakeTIMConstraints:^(TIMMASConstraintMaker *make) {
                make.left.right.mas_TIMequalTo(0.0f);
                make.top.mas_TIMequalTo(42.0f);
                make.height.mas_TIMequalTo(modalHeight-42.0f);
            }];
            
            TOSOrderListViewController * listView = [[TOSOrderListViewController alloc] init];
            listView.searchPlaceholder = self.searchPlaceholder;
            listView.showSearch = self.showSearch;
            listView.passiveEvoke = self.passiveEvoke;
            listView.param = self.param;
            listView.delegate = self;
            [self addChildViewController:listView];
            
            self.contentScrollView.contentSize = CGSizeMake(App_Frame_Width, 0);
            self.contentScrollView.contentOffset = CGPointMake(0, 0);
            
            [self scrollViewDidEndScrollingAnimation:self.contentScrollView];
            
        }
    }
    
    /// 添加关闭方法
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(closeTouch)];
    [self.view addGestureRecognizer:tap];
    
    
}


- (void)setupChildControllers {
    
    for (UIView *subV in self.contentScrollView.subviews) {
        [subV removeFromSuperview];
    }
    for (UIViewController *vc in self.childViewControllers) {
        [vc removeFromParentViewController];
    }
    CGFloat headerViewHeight = 0.0f;
    if (self.headerView) {
        headerViewHeight = 50.0f;
    }
    for (NSInteger i = 0 ; i < self.headerView.itemsArray.count; i++) {
        
        TOSOrderListViewController * listVC = [[TOSOrderListViewController alloc] init];
        listVC.categoryStr = self.headerView.itemsArray[i];
        listVC.searchPlaceholder = self.searchPlaceholder;
        listVC.showSearch = self.showSearch;
        listVC.passiveEvoke = self.passiveEvoke;
        listVC.param = self.param;
        listVC.delegate = self;
        [self addChildViewController:listVC];
        [listVC didMoveToParentViewController:self];
        
    }
    
    self.contentScrollView.contentSize = CGSizeMake(App_Frame_Width * self.headerView.itemsArray.count, 0);
    self.contentScrollView.contentOffset = CGPointMake(0, 0);
    
    [self scrollViewDidEndScrollingAnimation:self.contentScrollView];

}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView {
    
    /// contentScrollView的width
    CGFloat width = scrollView.width_sd;//scrollView.frame.size.width;
    
    CGFloat offsetX = scrollView.contentOffset.x;
    /// 获取索引
    NSInteger index = offsetX / width;
    
    if (self.childViewControllers.count == 0) {
        return;
    }
    /// 有表头才需要设置表头
    if (self.headerView) {
        self.headerView.selectIndex = index;
    }
    
    TOSOrderListViewController * childVC = self.childViewControllers[index];
    
    ///视图控制器是否加载过
    if (![childVC isViewLoaded]) {
        [childVC loadDataSourceSearch:@""];
    }
    childVC.view.frame = CGRectMake(index * width, 0, width, self.contentScrollView.height_sd);
    [scrollView addSubview:childVC.view];
    
    
}


- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    
    [self scrollViewDidEndScrollingAnimation:scrollView];
    
}


#pragma mark - action

/// 关闭按钮点击事件
- (void)closeTouch {
    
    if (self.passiveEvoke) {
        if (self.delegate && [self.delegate respondsToSelector:@selector(TOSOrderViewControllerSendFailText:)]) {
            if ([self.param objectForKey:@"failContent"]) {
                [self.delegate TOSOrderViewControllerSendFailText:self.param[@"failContent"]];
            }
            else {
                [self.delegate TOSOrderViewControllerSendFailText:@""];
            }
        }
    }
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

- (void)bgTapTouch {
    return;
}

#pragma mark - TOSOrderListViewControllerDelegate


- (void)TOSOrderListViewControllerSendCard:(nonnull TOSOrderListModel *)cardModel withProductModel:(nullable TOSOrderListProductModel *)productModel withType:(TOSOrderModelType)type {
    self.passiveEvoke = NO;
    if (self.delegate && [self.delegate respondsToSelector:@selector(TOSOrderViewControllerSendCard:withProductModel:withType:)]) {
        [self.delegate TOSOrderViewControllerSendCard:cardModel withProductModel:productModel withType:type];
        [self closeTouch];
    }
    
}

- (void)TOSOrderListViewControllerSendContent:(nonnull NSString *)content withCard:(nonnull TOSOrderListModel *)cardModel {
    self.passiveEvoke = NO;
    if (self.delegate && [self.delegate respondsToSelector:@selector(TOSOrderViewControllerSendContent:withCard:)]) {
        [self.delegate TOSOrderViewControllerSendContent:content withCard:cardModel];
        [self closeTouch];
    }
}

- (void)TOSOrderListViewControllerSendFailText:(nonnull NSString *)failText {
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(TOSOrderViewControllerSendFailText:)]) {
        [self.delegate TOSOrderViewControllerSendFailText:failText];
        [self closeTouch];
    }
}

- (void)TOSOrderListViewControllerSendLink:(nonnull NSString *)link withCard:(nonnull TOSOrderListModel *)cardModel {
    self.passiveEvoke = NO;
    if (self.delegate && [self.delegate respondsToSelector:@selector(TOSOrderViewControllerSendLink:withCard:)]) {
        [self.delegate TOSOrderViewControllerSendLink:link withCard:cardModel];
        [self closeTouch];
    }
}

- (void)TOSOrderListViewControllerTouchProductCard:(nonnull TOSOrderListProductModel *)cardModel withOrderModel:(nonnull TOSOrderListModel *)orderModel {
    self.passiveEvoke = NO;
    if (self.delegate && [self.delegate respondsToSelector:@selector(TOSOrderViewControllerTouchProductCard:withOrderModel:)]) {
        [self.delegate TOSOrderViewControllerTouchProductCard:cardModel withOrderModel:orderModel];
//        [self closeTouch];
    }
//    // 获取根导航控制器
//       UINavigationController *rootNavController = (UINavigationController *)UIApplication.sharedApplication.keyWindow.rootViewController;
//       
//       if ([rootNavController isKindOfClass:[UINavigationController class]]) {
//           UIViewController *targetVC = [[UIViewController alloc] init];
//           [rootNavController pushViewController:targetVC animated:YES];
//           
//           // 关闭当前 HWPanModal
////           [self dismissViewControllerAnimated:YES completion:nil];
//       }
//    UIViewController * vc = [[UIViewController alloc] init];
//    [self.navigationController pushViewController:vc animated:YES];
    
}

#pragma mark - TOSOrderCategoryHeaderViewDelegate

- (void)TOSOrderCategoryHeaderViewSelected:(NSInteger)index {
    
    self.headerView.selectIndex = index;
    
    [self.contentScrollView setContentOffset:(CGPointMake(index*self.contentScrollView.width_sd, 0)) animated:YES];
    
    
    
}


//#pragma mark - HWPanModalPresentable
///// 半屏的高度
//- (PanModalHeight)shortFormHeight {
//    return PanModalHeightMake(PanModalHeightTypeContent, APP_Frame_Height*0.8); // 设置初始高度
//}
//
///// 最大的高度
//- (PanModalHeight)longFormHeight {
//    return PanModalHeightMake(PanModalHeightTypeMax, 0); // 设置最大高度为全屏
//}
//
///// 不显示顶部的箭头
//- (BOOL)showDragIndicator {
//    return NO;
//}
//
///// 顶部圆角
//- (CGFloat)cornerRadius {
//    return TOSKitCustomInfo.shareCustomInfo.orderDrawer.drawerCorner;
//}
//
///**
// * 询问delegate是否需要使拖拽手势生效
// * 若返回NO，则禁用拖拽手势操作，即不能拖拽dismiss
// * 默认为YES
// */
//- (BOOL)shouldRespondToPanModalGestureRecognizer:(UIPanGestureRecognizer *)panGestureRecognizer {
//    return NO;
//}
//
////- (UIScrollView *)panScrollable {
////    return self.tableView;
////}
//
//- (BOOL)allowsDragToDismiss {
//    return NO;
//}
//
//
//- (BOOL)isAutoHandleKeyboardEnabled {
//    return NO;
//}
//
//- (BOOL)allowsTouchEventsPassingThroughTransitionView {
//    return NO;
//}
//
//
//- (void)panModalWillDismiss {
//    
//    /// 主动被唤起的，没有做发送的操作，需要发送失败话术
//    if (self.passiveEvoke) {
//        if (self.delegate && [self.delegate respondsToSelector:@selector(TOSOrderViewControllerSendFailText:)]) {
//            if ([self.param objectForKey:@"failContent"]) {
//                [self.delegate TOSOrderViewControllerSendFailText:self.param[@"failContent"]];
//            }
//            else {
//                [self.delegate TOSOrderViewControllerSendFailText:@""];
//            }
//        }
//    }
//}

#pragma mark - lazy

- (UIView *)bgView {
    if (!_bgView) {
        _bgView = [[UIView alloc] initWithFrame:(CGRectZero)];
        _bgView.layer.maskedCorners = kCALayerMinXMinYCorner | kCALayerMaxXMinYCorner;
        _bgView.layer.masksToBounds = YES;
        _bgView.layer.cornerRadius = TOSKitCustomInfo.shareCustomInfo.orderDrawer.drawerCorner;
        _bgView.clipsToBounds = YES;
        _bgView.backgroundColor = TOSKitCustomInfo.shareCustomInfo.orderDrawer.listBackGroundColor;
        _bgView.userInteractionEnabled = YES;
        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(bgTapTouch)];
        [_bgView addGestureRecognizer:tap];
        
    }
    return _bgView;
}


- (UILabel *)titleView {
    if (!_titleView) {
        _titleView = [[UILabel alloc] initWithFrame:(CGRectZero)];
        _titleView.textColor = [UIColor colorWithHexString:@"#262626"];
        _titleView.font = [UIFont fontWithName:@"PingFangSC-Medium" size:16.0f];
        _titleView.textAlignment = NSTextAlignmentCenter;
        
        //        _titleView.text = @"请选择您要查询的订单";
    }
    return _titleView;
}

- (UIButton *)closeBtn {
    if (!_closeBtn) {
        _closeBtn = [[UIButton alloc] initWithFrame:(CGRectZero)];
        [_closeBtn setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@/%@", FRAMEWORKS_BUNDLE_PATH, @"TOSSatisfaction_Close"]] forState:(UIControlStateNormal)];
        [_closeBtn addTarget:self action:@selector(closeTouch) forControlEvents:(UIControlEventTouchUpInside)];
        [_closeBtn setEnlargeEdge:10.0f];
        
    }
    return _closeBtn;
}


- (UIScrollView *)contentScrollView {
    if (!_contentScrollView) {
        _contentScrollView = [[UIScrollView alloc] initWithFrame:(CGRectZero)];
        _contentScrollView.pagingEnabled = YES;
        _contentScrollView.delegate = self;
        
        
    }
    return _contentScrollView;
}


/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */





@end
