//
//  OSRobotCombinationSpecialSubjectCell.m
//  TOSClientKit
//
//  Created by 言 on 2024/12/24.
//  Copyright © 2024 YanBo. All rights reserved.
//

#import "OSRobotCombinationSpecialSubjectCell.h"
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
#import "NSArray+TRTool.h"

@interface OSRobotCombinationSpecialSubjectCell ()

@property (nonatomic, strong) UIView *bottomView;
@property (nonatomic, strong) YYAnimatedImageView *icon;
@property (nonatomic, strong) UILabel *title;
@end

@implementation OSRobotCombinationSpecialSubjectCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        
        [self.contentView addSubview:self.bottomView];
        [self.contentView addSubview:self.icon];
        [self.contentView addSubview:self.title];
    }
    return self;
}

- (void)setWithModel:(CombinationMessage *)model
           indexPath:(NSUInteger)indexPath {
    CombinationDataModel *dataModel = [model.data by_ObjectAtIndex:indexPath];
    self.title.text = dataModel.cardName?:@"";
    
    self.bottomView.frame = CGRectMake(0, 0, self.contentView.tos_width, self.contentView.tos_height);
    if ([kitUtils isBlankString:self.title.text]) {
        self.icon.frame = CGRectMake(26.f, 8.f, 32.f, 32.f);
        self.icon.center = self.bottomView.center;
    } else {
        self.icon.frame = CGRectMake(26.f, 8.f, 32.f, 32.f);
    }
    self.title.frame = CGRectMake(13.f, self.icon.tos_bottom+8.f, 58.f, 22.f);
    
    NSString *path = @"";
    if (![dataModel.cardUrl hasPrefix:@"/"]) {
        path = @"/";
    }
    NSString * hostURL = @"";
    /// 上海
    if ([[[OnlineDataSave shareOnlineDataSave] getOnlineUrl] isEqualToString:@"https://chat-app-sh.clink.cn"]) {
        hostURL = @"https://webchat-sh.clink.cn";
    }
    /// 北京
    else if ([[[OnlineDataSave shareOnlineDataSave] getOnlineUrl] isEqualToString:@"https://chat-app-bj.clink.cn"]) {
        hostURL = @"https://webchat-bj.clink.cn";
    }/// 北京Test0
    else if ([[[OnlineDataSave shareOnlineDataSave] getOnlineUrl] isEqualToString:@"https://chat-app-bj-test0.clink.cn"]) {
        hostURL = @"https://webchat-bj-test0.clink.cn";
    }
    NSString *urlPath = [[NSString stringWithFormat:@"%@%@%@%@%@%@%@", hostURL, @"/api/bot_media?fileKey=",path,dataModel.cardUrl, @"&provider=", model.robotProvider, @"&isDownload=false&isThumbnail=true"] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    [self.icon setImageWithURL:[NSURL URLWithString:urlPath?:@""]
                   placeholder:[UIImage imageNamed:[NSString stringWithFormat:@"%@/%@",FRAMEWORKS_BUNDLE_PATH,@"im_photos"]]
                       options:YYWebImageOptionSetImageWithFadeAnimation
                      progress:nil
                     transform:^UIImage * _Nullable(UIImage * _Nonnull image, NSURL * _Nonnull url) {
        NSLog(@"image ===== %@, class ===== %@, url ==== %@",image,[image class],url);
        if ([image isKindOfClass:[YYImage class]]) {
            return image; // 动态图片
        }
        return image; // 静态图片
    }
                    completion:^(UIImage * _Nullable image, NSURL * _Nonnull url, YYWebImageFromType from, YYWebImageStage stage, NSError * _Nullable error) {
        NSLog(@"image =====-- %@, url ====-- %@, error ====-- %@",image,url,error);
    }];
}

#pragma mark - 初始化
- (UIView *)bottomView {
    if (!_bottomView) {
        _bottomView = [[UIView alloc] initWithFrame:CGRectZero];
        _bottomView.backgroundColor = [TOSKitCustomInfo shareCustomInfo].receiveBubble_backGround;
        _bottomView.layer.masksToBounds = YES;
        _bottomView.layer.cornerRadius = 8.0f;
    }
    return _bottomView;
}

- (YYAnimatedImageView *)icon {
    if (!_icon) {
        _icon = [[YYAnimatedImageView alloc] initWithFrame:CGRectZero];
    }
    return _icon;
}

- (UILabel *)title {
    if (!_title) {
        _title = [[UILabel alloc] initWithFrame:CGRectZero];
        _title.font = [UIFont fontWithName:@"PingFangSC-Regular" size:12.f];
        _title.textColor = TOSHexColor(0x595959);
        _title.numberOfLines = 1;
        _title.textAlignment = NSTextAlignmentCenter;
    }
    return _title;
}

@end
