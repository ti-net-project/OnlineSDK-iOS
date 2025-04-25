//
//  TOSOrderListViewController.m
//  TOSClientKit
//
//  Created by 李成 on 2025/1/6.
//  Copyright © 2025 YanBo. All rights reserved.
//

#import "TOSOrderListViewController.h"
#import "TIMConstants.h"
#import "TIMYYKit.h"
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

@interface TOSOrderListViewController ()<TOSOrderSearchViewDelegate, UITableViewDelegate, UITableViewDataSource, TOSOrderListTableViewCellDelegate, TOSMenuPopAlertDelegate>


/// 搜索
@property (nonatomic, strong) TOSOrderSearchView                * searchView;

/// 列表
@property (nonatomic, strong) UITableView                * tableView;

/// 无数据的占位图
@property (nonatomic, strong) TOSOrderNoDataView                * noDataView;

/// 列表数据源
@property (nonatomic, strong) NSMutableArray<TOSOrderListModel *>                * dataSource;

/// 请求的页码
@property (nonatomic, assign) NSInteger                currentIndex;

/// 加载动画
@property (nonatomic, strong) UIImageView                * loadImageView;

@end

@implementation TOSOrderListViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    /// 作为子控制器，也需要设置navigation的样式，但是不需要
    [self makeNavigationControllerCompletelyTransparent];
    
}

- (void)makeNavigationControllerCompletelyTransparent {

    /// 设置整个 UINavigationController.view 的背景透明
    self.navigationController.view.backgroundColor = [UIColor clearColor];
    
    /// iOS 15+ 导航栏外观设置
    if (@available(iOS 15.0, *)) {
        UINavigationBarAppearance *appearance = [[UINavigationBarAppearance alloc] init];
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

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = UIColor.clearColor;
    
    
    [self.view addSubview:self.searchView];
    [self.view addSubview:self.noDataView];
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.loadImageView];
    
    NSLog(@"viewDidLoad页面加载");
    
    if (self.searchPlaceholder.length) {
        self.searchView.placeholder = self.searchPlaceholder;
    }
    
    CGFloat searchViewHeight = 0.0f;
    if (self.showSearch) {
        searchViewHeight = 36.0f;
    }
    [self.searchView mas_TIMmakeTIMConstraints:^(TIMMASConstraintMaker *make) {
        make.left.right.mas_TIMequalTo(0);
        make.height.mas_TIMequalTo(searchViewHeight);
        make.top.equalTo(self.view.mas_TIMtop).offset(16.0f);
    }];
    
    [self.tableView mas_TIMmakeTIMConstraints:^(TIMMASConstraintMaker *make) {
        make.left.right.mas_TIMequalTo(0);
        make.top.equalTo(self.searchView.mas_TIMbottom).offset(self.showSearch? 4.0f : 0.0f);
        make.bottom.mas_TIMequalTo(0.0f);
    }];
    
    [self.noDataView mas_TIMmakeTIMConstraints:^(TIMMASConstraintMaker *make) {
        make.left.right.mas_TIMequalTo(0);
        make.height.mas_TIMequalTo(200.0f);
        make.top.equalTo(self.searchView.mas_TIMbottom).offset(120.0f);
    }];
    
    [self.loadImageView mas_TIMmakeTIMConstraints:^(TIMMASConstraintMaker *make) {
        make.width.height.mas_TIMequalTo(50.0f);
        make.centerX.equalTo(self.view.mas_TIMcenterX);
        make.centerY.equalTo(self.view.mas_TIMcenterY);
    }];
    
    
    __weak typeof(self) weakself = self;
    self.tableView.tos_header = [TIMRefreshNormalHeader headerWithRefreshingBlock:^{
        __strong typeof(weakself) strongself = weakself;
        strongself.currentIndex = 1;
        [strongself loadDataSourceSearch:@""];
    }];
    
    TIMRefreshAutoStateFooter * footer = [TIMRefreshAutoStateFooter footerWithRefreshingBlock:^{
        __strong typeof(weakself) strongself = weakself;
        strongself.currentIndex++;
        [strongself loadDataSourceSearch:@""];
    }];
    footer.stateLabel.textColor = [UIColor colorWithHexString:@"#BFBFBF"];
    footer.stateLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:12.0f];
    [footer setTitle:@"没有更多数据了~" forState:(TIMRefreshStateNoMoreData)];
    
    self.tableView.tos_footer = footer;
    
    /// 加载数据
//    [self loadDataSourceSearch:@""];
    
    
}

/// 加载数据
- (void)loadDataSourceSearch:(NSString *)search {
    NSMutableDictionary * params = [NSMutableDictionary dictionary];

    TOSSDKConfigModel * model = [TOSSDKConfigModel yy_modelWithJSON:[[OnlineDataSave shareOnlineDataSave] getAppSetting]];
    if (!model.appWindowSetting.enable) {
        self.tableView.hidden = YES;
        self.noDataView.hidden = NO;
        [WHToast showMessage:@"订单参数异常" duration:2.0 finishHandler:nil];
        return;
    }
    if (self.tableView.hidden) {
        self.tableView.hidden = NO;
        self.noDataView.hidden = YES;
    }


    /// 开始处理接口入参
    if (self.param) {
        if ([self.param allKeys].count) {
            if ([self.param objectForKey:@"url"]) {
                [params setValue:self.param[@"url"] forKey:@"url"];
            }
            if ([self.param objectForKey:@"param"]) {
                [params setValue:self.param[@"param"] forKey:@"param"];
//                [params setValue:@"contactType=11&visitorId=47001861" forKey:@"param"];
            }
            if ([self.param objectForKey:@"requestMethod"]) {
                [params setValue:self.param[@"requestMethod"] forKey:@"requestMethod"];
            }
            if ([self.param objectForKey:@"token"]) {
                [params setValue:self.param[@"token"] forKey:@"token"];
            }
            if ([self.param objectForKey:@"contentType"]) {
                [params setValue:self.param[@"contentType"] forKey:@"contentType"];
            }
            /// 搜索数据
            if (search.length) {
                [params setValue:search forKey:@"content"];
            }
            else {
                if ([self.param objectForKey:@"content"]) {
                    [params setValue:self.param[@"content"] forKey:@"content"];
                }
            }
        }
    }
    
    if ([self.categoryStr isNotBlank]) {
        /// 分类
        [params setValue:self.categoryStr forKey:@"category"];
    }

//    NSLog(@"当前抽屉的请求参数：%@", params);
    if (params.count == 0) {
        [WHToast showMessage:@"订单列表需要有效的鉴权参数" duration:2.0 finishHandler:nil];
        return;
    }

    if (self.loadImageView.hidden) {
        self.loadImageView.hidden = NO;
    }

    __weak typeof(self) weakself = self;
    /// 请求订单列表接口
    [[OnlineRequestManager sharedCustomerManager] getOrderDrawerListWithMainUniqueId:@"" withParams:params withPageIndex:self.currentIndex withPageSize:10 withSuccess:^(NSArray * _Nonnull orderList) {
        __strong typeof(weakself) strongself = weakself;
        strongself.loadImageView.hidden = YES;
        /// 当前请求是第一页时，需要清空本地缓存的数据源数组
        if (strongself.currentIndex == 1) {
            [strongself.dataSource removeAllObjects];
        }
        /// 返回的数组是否有值
        if (orderList.count) {
            strongself.tableView.hidden = NO;
            strongself.noDataView.hidden = YES;
            NSArray * array = [NSArray yy_modelArrayWithClass:[TOSOrderListModel class] json:orderList];
//            NSLog(@"转换的model数组数量：%ld", array.count);
            [strongself.dataSource addObjectsFromArray:array];
            [strongself.tableView reloadData];
//            NSLog(@"刷新列表 :  %ld", self.dataSource.count);
        }
        else {
            /// 返回的数组没有值时，需要判断当前列表是否有值，
            if (strongself.dataSource.count < 1) {
                strongself.tableView.hidden = YES;
                strongself.noDataView.hidden = NO;
            }
        }
        [strongself.tableView.tos_header endRefreshing];
        [strongself.tableView.tos_footer endRefreshing];
        if (orderList.count != 10) {
            [strongself.tableView.tos_footer endRefreshingWithNoMoreData];
        }
    } withFailure:^(TIMConnectErrorCode errCode, NSString * _Nonnull errorDes) {
        __strong typeof(weakself) strongself = weakself;
        strongself.tableView.hidden = YES;
        strongself.noDataView.hidden = NO;
        strongself.loadImageView.hidden = YES;
        [WHToast showMessage:errorDes duration:2.0 finishHandler:nil];
    }];


}


#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TOSOrderListTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"TOSOrderListTableViewCell"];
    if (!cell) {
        cell = [[TOSOrderListTableViewCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:@"TOSOrderListTableViewCell"];
    }
    cell.model = self.dataSource[indexPath.row];
    cell.delegate = self;
    cell.tag = indexPath.row;
    return cell;
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    TOSOrderListModel * model = self.dataSource[indexPath.row];
    /// 顶部的高度
    CGFloat topHeight = 60.0f;
    /// 商品的高度
    CGFloat itemTotalHeight = 0.0f;
    /// 底部按钮的高度
    CGFloat bottomBtnHeight = model.functionHeight;
    if (![model.title isNotBlank] && ![model.status isNotBlank] && ![model.logo isNotBlank] && ![model.time isNotBlank]) {
        topHeight = 0.0f;
    }
    for (NSInteger i = 0; i < model.productList.count; i++) {
        TOSOrderListProductModel * productModel = model.productList[i];
        CGFloat itemHeight = 88.0f;
        if (productModel.buttonConfigList.count>0) {
            itemHeight += productModel.totalFunctionHeight;
        }
        itemTotalHeight += itemHeight;
    }
    /// 底部自定义参数的高度
    CGFloat bottomCustomHeight = model.bottomCustomHeight;
//    NSLog(@"bottomCustomHeight 的值：%lf", bottomCustomHeight);
    return 12.0f+topHeight+itemTotalHeight+bottomBtnHeight+bottomCustomHeight;
}


#pragma mark - TOSMenuPopAlertDelegate

- (void)TOSMenuPopAlertDidSelect:(NSInteger)index withSourceIndex:(NSInteger)sourceIndex withStartIndex:(NSInteger)startIndex {
    
    TOSOrderListModel * model = self.dataSource[sourceIndex];
    NSArray<TOSOrderButtonConfigModel*> * moreSource = [model.buttonConfigList subarrayWithRange:(NSMakeRange(startIndex, model.buttonConfigList.count-startIndex))];
    TOSOrderButtonConfigModel * btnModel = moreSource[index];
    
    [self orderBtnSelected:btnModel withOrderModel:model withProductModel:nil withType:(TOSOrderModelTypeOrder)];
    
    
}

/// 订单按钮的点击后续跳转逻辑。
- (void)orderBtnSelected:(TOSOrderButtonConfigModel *)btnModel withOrderModel:(TOSOrderListModel *)orderModel withProductModel:(TOSOrderListProductModel *)productModel withType:(TOSOrderModelType)type {
    /// 点击了功能按钮进行发送文本/订单/链接等操作，需要把被动唤起的属性置为null，说明用户进行了操作，不需要再发送失败话术了。
    self.passiveEvoke = NO;
//    NSLog(@"点击的是：%@", btnModel.text);
    switch (btnModel.type) {
        case OrderButtonConfigTypeSendCard: {
//            NSLog(@"发送卡片");
            if (self.delegate && [self.delegate respondsToSelector:@selector(TOSOrderListViewControllerSendCard:withProductModel:withType:)]) {
                [self.delegate TOSOrderListViewControllerSendCard:orderModel withProductModel:productModel withType:type];
                
            }
            break;
        }
        case OrderButtonConfigTypeSendContent: {
//            NSLog(@"发送文本:%@", btnModel.content);
            if (self.delegate && [self.delegate respondsToSelector:@selector(TOSOrderListViewControllerSendContent:withCard:)]) {
                [self.delegate TOSOrderListViewControllerSendContent:btnModel.content withCard:orderModel];
                
            }
            break;
        }
        case OrderButtonConfigTypeLink: {
//            NSLog(@"链接跳转:%@", btnModel.linkUrl);
            if (self.delegate && [self.delegate respondsToSelector:@selector(TOSOrderListViewControllerSendLink:withCard:)]) {
                [self.delegate TOSOrderListViewControllerSendLink:btnModel.linkUrl withCard:orderModel];
            }
            break;
        }
        default:
            break;
    }
    
}

#pragma mark - TOSOrderListTableViewCellDelegate

/// 功能按钮的点击
/// - Parameters:
///   - index: 点击的是第几个功能按钮
///   - model: 对应的订单model
- (void)TOSOrderListTableViewCellFunctionClick:(NSInteger)index withModel:(TOSOrderListModel *)model {
    
    TOSOrderButtonConfigModel * btnModel = model.buttonConfigList[index];
    
    [self orderBtnSelected:btnModel withOrderModel:model withProductModel:nil withType:(TOSOrderModelTypeOrder)];
    
    
}

/// 功能按钮的更多点击
/// - Parameters:
///   - index: 需要展示的功能按钮的索引
///   - model: 对应的订单model
- (void)TOSOrderListTableViewCellFunctionMoreClick:(NSInteger)index withModel:(TOSOrderListModel *)model withRect:(CGRect)rect {
    
    /// 根据model获取数组下标
    NSUInteger idx = [self.dataSource indexOfObject:model];
    /// 获取更多弹窗需要展示的数据源
    NSArray<TOSOrderButtonConfigModel*> * moreSource = [model.buttonConfigList subarrayWithRange:(NSMakeRange(index, model.buttonConfigList.count-index))];
    
//    NSLog(@"需要展示的更多数据：%ld", moreSource.count);
    /// 把数据转成弹窗的model
    NSMutableArray<TOSCustomMenuItem *> * menuArray = [NSMutableArray array];
    for (TOSOrderButtonConfigModel * itemModel in moreSource) {
        TOSCustomMenuItem * menuItem = [[TOSCustomMenuItem alloc] init];
        menuItem.title = itemModel.text;
        [menuArray addObject:menuItem];
    }
    /// 弹窗的配置类
    TOSMenuConfiguration * config = [[TOSMenuConfiguration alloc] init];
    
    /// 弹窗
    TOSMenuPopAlert * alert = [[TOSMenuPopAlert alloc] initWithRect:CGRectMake(CGRectGetMinX(rect), CGRectGetMinY(rect), 60.0, 50.0f) withData:menuArray withConfig:config withIndex:idx withRangeStartIndex:index];
    alert.delegate = self;
    [alert showWindow];
    
    
}

/// 功能按钮的点击
/// - Parameters:
///   - index: 底部右下角的按钮点击，这个对于逻辑没有作用
///   - model: 对应的订单model
- (void)TOSOrderListTableViewCellBottomFunctionClick:(NSInteger)index withModel:(TOSOrderListModel *)model {
    /// 点击了功能按钮进行发送文本/订单/链接等操作，需要把被动唤起的属性置为null，说明用户进行了操作，不需要再发送失败话术了。
    self.passiveEvoke = NO;
    TOSOrderBottomButtonConfigModel * btnModel = model.bottomButtonConfig;
    
    switch (btnModel.type) {
        case OrderButtonConfigTypeSendCard: {
            
            if (self.delegate && [self.delegate respondsToSelector:@selector(TOSOrderListViewControllerSendCard:withProductModel:withType:)]) {
//                [self.delegate TOSOrderViewControllerSendCard:model withProductModel:nil withType:TOSOrderModelTypeOrder];
                [self.delegate TOSOrderListViewControllerSendCard:model withProductModel:nil withType:TOSOrderModelTypeOrder];
                
            }
            break;
        }
        case OrderButtonConfigTypeSendContent: {
            
            if (self.delegate && [self.delegate respondsToSelector:@selector(TOSOrderListViewControllerSendContent:withCard:)]) {
                [self.delegate TOSOrderListViewControllerSendContent:btnModel.content withCard:model];
//                [self closeTouch];
            }
            break;
        }
        case OrderButtonConfigTypeLink: {
            
            if (self.delegate && [self.delegate respondsToSelector:@selector(TOSOrderListViewControllerSendLink:withCard:)]) {
                [self.delegate TOSOrderListViewControllerSendLink:btnModel.linkUrl withCard:model];
//                [self closeTouch];
            }
            break;
        }
        default:
            break;
    }
}

/// 商品的功能按钮的点击
/// - Parameters:
///   - index: 点击商品的哪个功能按钮
///   - model: 订单model
///   - productModel: 商品model
- (void)TOSOrderListTableViewCellProductFunctionClick:(NSInteger)index withModel:(TOSOrderListModel *)model withProductModel:(TOSOrderListProductModel *)productModel {
    
    TOSOrderButtonConfigModel * btnModel = productModel.buttonConfigList[index];
    
    [self orderBtnSelected:btnModel withOrderModel:model withProductModel:productModel withType:(TOSOrderModelTypeProduct)];
    
    
}

/// 自定义参数的更多按钮点击。（展开/收起）
/// - Parameter model: 对应的订单model
- (void)TOSOrderListTableViewCellCustomMoreClick:(TOSOrderListModel *)model withIndex:(NSInteger)index {
//    model.showMore = !model.showMore;
//    NSLog(@"当前的索引为：%ld", index);
    [self.dataSource replaceObjectAtIndex:index withObject:model];
    [self.tableView reloadData];
    
}

/// 订单中商品卡片的整体点击
/// - Parameters:
///   - productModel: 商品的model
///   - model: 商品所在的订单的model
- (void)TOSOrderListTableViewCellProductModel:(TOSOrderListProductModel *)productModel withModel:(TOSOrderListModel *)model {
    
//    NSDictionary * productDict = [productModel yy_modelToJSONObject];
//    NSLog(@"点击的商品信息：%@", productDict);
//
//    NSLog(@"点击的商品所对应的订单信息：%@", [model yy_modelToJSONObject]);
//    [self dismissViewControllerAnimated:YES completion:nil];
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(TOSOrderListViewControllerTouchProductCard:withOrderModel:)]) {
        [self.delegate TOSOrderListViewControllerTouchProductCard:productModel withOrderModel:model];
    }
    
}


#pragma mark - TOSOrderSearchViewDelegate

- (void)TOSOrderSearchViewClickSearch:(NSString *)text {
//    NSLog(@"传递过来的文本内容：%@", text);
    
    self.currentIndex = 1;
    [self loadDataSourceSearch:text];
    
}


#pragma mark - lazy

- (NSMutableArray<TOSOrderListModel *> *)dataSource {
    if (!_dataSource) {
        _dataSource = [NSMutableArray array];
    }
    return _dataSource;
}


- (TOSOrderSearchView *)searchView {
    if (!_searchView) {
        _searchView = [[TOSOrderSearchView alloc] initWithFrame:(CGRectZero)];
        _searchView.delegate = self;
        _searchView.clipsToBounds = YES;

    }
    return _searchView;
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:(CGRectZero)];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = UIColor.clearColor;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.userInteractionEnabled = YES;

    }
    return _tableView;
}

- (TOSOrderNoDataView *)noDataView {
    if (!_noDataView) {
        _noDataView = [[TOSOrderNoDataView alloc] initWithFrame:(CGRectZero)];
        _noDataView.hidden = YES;

    }
    return _noDataView;
}


- (UIImageView *)loadImageView {
    if (!_loadImageView) {
        _loadImageView = [[UIImageView alloc] initWithFrame:(CGRectZero)];
        // 加载loading
        NSString *imagePath = [[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"%@/%@",FRAMEWORKS_BUNDLE_PATH,@"loading"] ofType:kGIFTimageType];
        NSData *imageData = [NSData dataWithContentsOfFile:imagePath];
        _loadImageView.image = [UIImage imageWithData:imageData];
        _loadImageView.hidden = YES;
    }
    return _loadImageView;
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
