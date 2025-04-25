//
//  ICChatBoxMoreViewItem.m
//  XZ_WeChat
//
//  Created by 赵言 on 16/3/14.
//  Copyright © 2016年 gxz All rights reserved.
//

#import "ICChatBoxMoreViewItem.h"
#import "TIMMasonry.h"
#import "UIView+SDExtension.h"
#import "TIMConstants.h"
#import "kitUtils.h"
#import <TOSClientKit/TOSKitCustomInfo.h>
#import <TOSClientLib/OnlineRequestManager.h>
#import "TIMYYKit.h"
#import "UIButton+TIMEnlargeEdge.h"

@interface ICChatBoxMoreViewItem ()

@property (nonatomic, strong) UIButton *button;
@property (nonatomic, strong) UILabel *titleLabel;

@end

@implementation ICChatBoxMoreViewItem

/**
 *  创建一个ICChatBoxMoreViewItem
 *
 *  @param title     item的标题
 *  @param imageName item的图片
 *  @param index     item的唯一标识
 *  @return item
 */
+ (ICChatBoxMoreViewItem *)createChatBoxMoreItemWithTitle:(NSString *)title
                                                imageName:(NSString *)imageName
                                                    index:(NSInteger)index
                                                     type:(TOSChatBoxExtendBoardType)type {
    ICChatBoxMoreViewItem *item = [[ICChatBoxMoreViewItem alloc] init];
    item.title = title;
    item.imageName = imageName;
    item.index = index;
    item.type = type;
    return item;
}

/**
 *  创建一个ICChatBoxMoreViewItem
 *
 *  @param title     item的标题
 *  @param imageURL item的网络地址
 *  @param index     item的唯一标识
 *  @return item
 */
+ (ICChatBoxMoreViewItem *)createChatBoxMoreItemWithTitle:(NSString *)title
                                                 imageURL:(NSString *)imageURL
                                                    index:(NSInteger)index
                                                     type:(TOSChatBoxExtendBoardType)type {
    ICChatBoxMoreViewItem *item = [[ICChatBoxMoreViewItem alloc] init];
    item.title = title;
    item.imageURL = imageURL;
    item.index = index;
    item.type = type;
    return item;
}

- (id) initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self addSubview:self.button];
        [self addSubview:self.titleLabel];
    }
    return self;
}

- (void) setFrame:(CGRect)frame
{
    [super setFrame:frame];
    
    float w = 56;//59;
    [self.button setFrame:CGRectMake((self.tosSD_width - w) / 2, 0, w, w)];
    [self.titleLabel setFrame:CGRectMake(-5, self.button.tosSD_height + 12.f, self.tosSD_width + 20.f, 15)];
    self.titleLabel.tosSD_centerX = self.tosSD_width/2;
}

#pragma mark - Public Method

- (void)addTarget:(id)target action:(SEL)action forControlEvents:(UIControlEvents)controlEvents
{
    [self.button addTarget:target action:action forControlEvents:controlEvents];
}

- (void) setTag:(NSInteger)tag
{
    [super setTag:tag];
    [self.button setTag:tag];
}

#pragma mark - Setter

- (void)setTitle:(NSString *)title {
    [self.titleLabel setText:title];
}

- (NSString *)title {
    return _titleLabel.text;
}

- (void) setImageName:(NSString *)imageName
{
    _imageName = imageName;
    
    [self.button setImage:[[UIImage imageNamed:imageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];

}


- (void)setImageURL:(NSString *)imageURL {
    _imageURL = imageURL;
    
    /// 判断传递过来的是否是资源的网络地址，如果不是需要通过接口获取真实的资源地址。
    if ([imageURL hasPrefix:@"http"]) {
//        NSLog(@"直接进行图片加载操作！！！");
        [self.button setImageWithURL:[NSURL URLWithString:imageURL] forState:(UIControlStateNormal) options:(YYWebImageOptionProgressive)];
    }
    else {
        /// 需要进行二次请求获取资源的真实地址
//        NSLog(@"需要进行二次请求获取资源的真实地址");
        __weak typeof(self) weakSelf = self;
        [[OnlineRequestManager sharedCustomerManager] getIconUrl:imageURL withSuccess:^(NSString * _Nonnull url) {
            __strong typeof(weakSelf) strongSelf = weakSelf;
            if (url.length) {
                [strongSelf.button setImageWithURL:[NSURL URLWithString:url] forState:(UIControlStateNormal) options:(YYWebImageOptionProgressive)];
            }
        } withFailure:^(TIMConnectErrorCode errCode, NSString * _Nonnull errorDes) {
            
        }];
    }
    
    
}

#pragma mark - Getter

- (UIButton *) button
{
    if (_button == nil) {
        _button = [[UIButton alloc] init];
        [_button.layer setMasksToBounds:YES];
        [_button.layer setCornerRadius:[TOSKitCustomInfo shareCustomInfo].chatBox_more_itemCornerRadius];
        [_button setBackgroundColor:[TOSKitCustomInfo shareCustomInfo].chatBox_more_itemBackgroundColor];
        _button.imageEdgeInsets = [TOSKitCustomInfo shareCustomInfo].chatBox_more_itemImageEdgeInsets;
        _button.debounceInterval = 0.5;
        
    }
    return _button;
}

- (UILabel *) titleLabel
{
    if (_titleLabel == nil) {
        _titleLabel = [[UILabel alloc] init];
        [_titleLabel setFont:[UIFont fontWithName:@"PingFangSC-Regular" size:14.f]];
//        [_titleLabel setTextColor:TOSHexColor(0x595959)];
        [_titleLabel setTextColor:[TOSKitCustomInfo shareCustomInfo].chatBox_more_itemTextColor];
        [_titleLabel setTextAlignment:NSTextAlignmentCenter];
    }
    return _titleLabel;
}
    
@end
