//
//  CustomFileTableViewCell.m
//  TOSClientKitDemo
//
//  Created by 李成 on 2024/10/8.
//  Copyright © 2024 YanBo. All rights reserved.
//

#import "CustomFileTableViewCell.h"
#import <TOSClientKit/TOSKit.h>
#import <TOSClientKit/ICMessageTopTimeView.h>
#import <MobileCoreServices/MobileCoreServices.h>


@interface CustomFileTableViewCell ()<NSURLConnectionDataDelegate, UIDocumentInteractionControllerDelegate>


// 菊花视图所在的view
@property (nonatomic, strong) UIActivityIndicatorView *activityView;

// 重新发送
@property (nonatomic, strong) UIButton *retryButton;

// 顶部中间时间线
@property (nonatomic, strong) ICMessageTopTimeView *messageTopTimeView;

/// 已读、未读
@property (nonatomic, strong) UILabel *readLabel;

/// 昵称
@property (nonatomic, strong) UILabel                * nickLabel;

/// 头像
@property (nonatomic, strong) UIImageView                * avatarView;

/// 背景
@property (nonatomic, strong) UIImageView                * bubbleView;

/// 文件图标
@property (nonatomic, strong) UIImageView                * iconView;

/// 标题
@property (nonatomic, strong) UILabel                * titleView;

/// 文件路径
@property (nonatomic, copy) NSString                * fileUrl;

/** 文件数据 */
@property (nonatomic, strong) NSMutableData *fileData;
/** 文件的总长度 */
@property (nonatomic, assign) NSInteger contentLength;


@property (nonatomic, weak) UIViewController *controller;

/// 文档查看（文档、图片、视频）
@property (nonatomic, strong) UIDocumentInteractionController *documentController;



@end



@implementation CustomFileTableViewCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self.contentView addSubview:self.retryButton];
        [self.contentView addSubview:self.activityView];
        [self.contentView addSubview:self.messageTopTimeView];
        [self.contentView addSubview:self.nickLabel];
        [self.contentView addSubview:self.avatarView];
        [self.contentView addSubview:self.bubbleView];
        [self.bubbleView addSubview:self.iconView];
        [self.bubbleView addSubview:self.titleView];
        
        
        
    }
    return self;
}




- (CGFloat)cellHeight {
    if (self.model.message.showTime) {
        return 110.0;
    }
    return 90.0f;
}

- (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString {
    if (jsonString == nil) {
        return nil;
    }
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                        options:NSJSONReadingMutableContainers
                                                          error:&err];
    if(err) {
        NSLog(@"json解析失败3：%@ json:%@",err,jsonString);
        return nil;
    }
    return dic;
}

/// 判断文件是否存在
- (BOOL)fileWhetherItExists:(NSString *)file withFileName:(NSString *)fileName {
    /// 获取Documents目录路径
    NSString *path = [[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"File"];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    /// 判断是否存在该路径
    BOOL isDirExist = [fileManager fileExistsAtPath:path];
    /// 没有需要创建文件路径
    if (!isDirExist) {
        BOOL isCreatDir = [fileManager createDirectoryAtPath:path withIntermediateDirectories:YES attributes:nil error:nil];
        if (!isCreatDir) {
            //ICLog(@"create folder failed");
            NSLog(@"创建文件夹失败！");
        }
    }
    NSString * downloadPath = [path stringByAppendingPathComponent:[NSString stringWithFormat:@"%@", fileName]];
    self.model.mediaPath = downloadPath;
    if ([fileManager fileExistsAtPath:downloadPath]) {
        return YES;
    }
    return NO;
}

- (NSString *)mimeTypeForFileAtPath:(NSString *)path{
    if (![[[NSFileManager alloc] init] fileExistsAtPath:path]) {
        NSLog(@"mimeTypeForFileAtPath 默认 application/octet-stream");
        return @"application/octet-stream";
//        return nil;
    }
    CFStringRef UTI = UTTypeCreatePreferredIdentifierForTag(kUTTagClassFilenameExtension, (__bridge CFStringRef)[path pathExtension], NULL);
    CFStringRef MIMEType = UTTypeCopyPreferredTagWithClass (UTI, kUTTagClassMIMEType);
    CFRelease(UTI);
    if (!MIMEType) {
        return @"application/octet-stream";
    }
    NSLog(@"mimeTypeForFileAtPath = %@",(__bridge NSString *)(MIMEType));
    return (__bridge NSString *)(MIMEType);
}

/// 重新发送
- (void)retryButtonClick:(UIButton *)btn {
    /// 更改消息状态
    self.model.message.deliveryState = ICMessageDeliveryState_Delivering;
    /// 更新UI
    self.retryButton.hidden = YES;
    [self.activityView startAnimating];
    
    NSString * fileTypeStr = [self mimeTypeForFileAtPath:self.model.mediaPath];
    
    NSString *fileNameString = self.titleView.text;
    
    NSString *fileUrl = [self filePathWithFileName:[NSString stringWithFormat:@"timLocalFileApp_%@.%@",[self currentRecordFileName],[self.model.mediaPath pathExtension]]];
    NSLog(@"file URL === %@", fileUrl);
    NSData *fileData = [NSData dataWithContentsOfFile:self.model.mediaPath];
    @WeakObj(self);
    [[OnlineMessageSendManager sharedOnlineMessageSendManager] sendFileMessageWithFileData:fileData fileType:fileTypeStr fileName:fileNameString success:^(NSString * _Nonnull messageId) {
        @StrongObj(self);
        self.model.message.deliveryState = ICMessageDeliveryState_Delivered;
        dispatch_async(dispatch_get_main_queue(), ^{
            @StrongObj(self);
            self.activityView.hidden = YES;
            [self.activityView stopAnimating];
        });
        
    } error:^(TIMConnectErrorCode errCode, NSString * _Nonnull errorDes) {
        self.model.message.deliveryState = ICMessageDeliveryState_Failure;
        @StrongObj(self);
        dispatch_async(dispatch_get_main_queue(), ^{
            @StrongObj(self);
            self.retryButton.hidden = NO;
            self.activityView.hidden = YES;
            [self.activityView stopAnimating];
        });
        
        long long sizeLimitM = [[OnlineDataSave shareOnlineDataSave] getAppSettingFileSize].longLongValue /1024/1024;
        NSString * strShow = [NSString stringWithFormat:@"文件过大，请发送小于%lldM文件",sizeLimitM];
        
//        [MBProgressHUD showMBErrorView:strShow];
        
        
    }];
    
}

- (NSString *)filePathWithFileName:(NSString *)fileName
{
    NSString *path = [self createPathWithChildPath:@"File"];
    return [path stringByAppendingPathComponent:[NSString stringWithFormat:@"%@",fileName]];
}

- (NSString *)createPathWithChildPath:(NSString *)childPath
{
    NSString *path = [[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:childPath];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL isDirExist = [fileManager fileExistsAtPath:path];
    if (!isDirExist) {
        BOOL isCreatDir = [fileManager createDirectoryAtPath:path withIntermediateDirectories:YES attributes:nil error:nil];
        if (!isCreatDir) {
            NSLog(@"create folder failed");
            return nil;
        }
    }
    return path;
}

- (NSString *)currentRecordFileName
{
    NSTimeInterval timeInterval = [[NSDate date] timeIntervalSince1970];
    NSString *fileName = [NSString stringWithFormat:@"%ld",(long)timeInterval];
    return fileName;
}


- (void)bubbleClicked:(UITapGestureRecognizer *)sender {
    
    if (![self.fileUrl hasPrefix:@"http"]) {
        [self fileDocumentReadWithFilePath:self.model.mediaPath target:[self getCurrentViewController]];
        return;
    }
    
    NSDictionary * contentDic = [self dictionaryWithJsonString:self.model.message.content];
    if (!contentDic) {
        return;
    }
    NSString * fileName = @"";
    if ([contentDic by_ObjectForKey:@"fileName"]) {
        fileName = contentDic[@"fileName"];
    }
    else {
        fileName = @"文件";
    }
    
    if ([self fileWhetherItExists:self.fileUrl withFileName:fileName]) {
        /// 已下载，做跳转逻辑
        NSLog(@"已下载，做跳转逻辑");
        [self fileDocumentReadWithFilePath:self.model.mediaPath target:[self getCurrentViewController]];
    }
    else {
        if (self.contentLength > 0 && self.fileData != nil) {
//            [MBProgressHUD showMBErrorView:@"文件下载中"];
            return;
        }
        /// 开始下载
        NSURL *url = [NSURL URLWithString:self.fileUrl];
        [NSURLConnection connectionWithRequest:[NSURLRequest requestWithURL:url] delegate:self];
        NSLog(@"开始下载");
//        [MBProgressHUD showMBErrorView:@"文件开始下载"];
        
    }
    
    
}

- (void)fileDocumentReadWithFilePath:(NSString *)filePath target:(id)target {
    if (filePath && target) {
        NSURL *url;
        if ([filePath isKindOfClass:[NSURL class]]) {
            url = (NSURL *)filePath;
            NSLog(@"处理后的url：%@", url.absoluteString);
        }
        else {
            url = [NSURL fileURLWithPath:filePath];
        }
        self.controller = target;
        if (self.documentController == nil) {
            self.documentController = [UIDocumentInteractionController interactionControllerWithURL:url];
            self.documentController.delegate = self;
            [self.documentController presentPreviewAnimated:YES];
        }
    }
}

- (UIViewController *)getCurrentViewController {
    UIWindow *window = [[UIApplication sharedApplication].delegate window];
    UIViewController *topViewController = [window rootViewController];
    while (true) {
        if (topViewController.presentedViewController) {
            topViewController = topViewController.presentedViewController;
        }
        else if ([topViewController isKindOfClass:[UINavigationController class]] && [(UINavigationController*)topViewController topViewController]) {
            
            topViewController = [(UINavigationController *)topViewController topViewController];
        }
        else if ([topViewController isKindOfClass:[UITabBarController class]]) {
            
            UITabBarController *tab = (UITabBarController *)topViewController;
            topViewController = tab.selectedViewController;
        } else {
            break;
        }
    }
    return topViewController;
}

- (void)loadImageWithUrl:(NSString *)urlString
             placeholder:(UIImage *)placeholder
               imageView:(UIImageView *)imageView
               cacheType:(BOOL)cacheType {
    // 获取默认的图片管理器
    YYWebImageManager *manager = [YYWebImageManager sharedManager];
    
    // 创建 URL
    NSURL *url = [NSURL URLWithString:urlString];
    
    // 尝试从缓存中获取图片
    UIImage *cachedImage;
    if (cacheType) {
        cachedImage = [manager.cache getImageForKey:urlString withType:YYImageCacheTypeAll];
    } else {
        cachedImage = [manager.cache getImageForKey:url.path withType:YYImageCacheTypeAll];
    }
    
    if (cachedImage) {
        imageView.image = cachedImage;
    } else {
        if (cacheType) {
            [imageView setImageWithURL:url
                           placeholder:placeholder
                               options:YYWebImageOptionSetImageWithFadeAnimation
                            completion:nil];
        } else {
            __block NSString *path = url.path;
            __block UIImageView *imageViewBlock = imageView;
            [imageView setImageWithURL:url
                           placeholder:placeholder
                               options:YYWebImageOptionAvoidSetImage | YYWebImageOptionSetImageWithFadeAnimation
                            completion:^(UIImage * _Nullable image, NSURL * _Nullable url, YYWebImageFromType from, YYWebImageStage stage, NSError * _Nullable error) {
                if (image && !error) {
                    // 将下载的图片缓存到自定义 Key 下
                    [[YYImageCache sharedCache] setImage:image forKey:path];
                    imageViewBlock.image = image;
                }
            }];
        }
    }
}

#pragma mark - <NSURLConnectionDataDelegate>
- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSHTTPURLResponse *)response
{
    self.contentLength = [response.allHeaderFields[@"Content-Length"] integerValue];
    self.fileData = [NSMutableData data];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [self.fileData appendData:data];
    CGFloat progress = 1.0 * self.fileData.length / self.contentLength;
    NSLog(@"已下载：%.2f%%", (progress) * 100);
//    self.progressView.progress = progress;
    
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    NSLog(@"下载完毕 ：+++++ %@", self.model.mediaPath);
    
    NSLog(@"self.fileUrl 下载完毕 %@",self.fileUrl);
    
    /// 将文件写入沙盒中
    NSError * error = nil;
    BOOL write = [self.fileData writeToFile:self.model.mediaPath options:(NSAtomicWrite) error:&error];
    if (write) {
        NSLog(@"写入成功");
//        self.fileData = nil;
//        [MBProgressHUD showMBErrorView:[NSString stringWithFormat:@"文件下载完成：%@", self.model.mediaPath]];
    }
    else {
        NSLog(@"写入失败 ： %@", error);
        self.fileData = nil;
        self.contentLength = 0;
//        [MBProgressHUD showMBErrorView:@"文件下载失败"];
    }
    
}

#pragma mark - UIDocumentInteractionControllerDelegate
- (UIViewController *)documentInteractionControllerViewControllerForPreview:(UIDocumentInteractionController *)controller {
    return self.controller;
}

- (UIView *)documentInteractionControllerViewForPreview:(UIDocumentInteractionController *)controller {
    return self.controller.view;
}

- (CGRect)documentInteractionControllerRectForPreview:(UIDocumentInteractionController *)controller {
    return self.controller.view.bounds;
}

// 点击预览窗口的“Done”(完成)按钮时调用
- (void)documentInteractionControllerDidEndPreview:(UIDocumentInteractionController *)_controller {
    self.documentController = nil;
}

#pragma mark - setter

- (void)setModel:(TIMMessageModel *)model {
    _model = model;
    @WeakObj(self)
    
    NSDictionary * contentDic = [self dictionaryWithJsonString:model.message.content];
    self.titleView.text = contentDic[@"fileName"];
    self.fileUrl = [model.urlPath stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSLog(@"文件的地址：%@", self.fileUrl);
    NSLog(@"文件系统的数据：%@", contentDic);
    CGFloat topHeight = 0.0;
    if (model.message.showTime) {
        topHeight = 20.0;
    }
    self.messageTopTimeView.frame = CGRectMake(0, 0, kScreenWidth, topHeight);
    
    if (model.isSender) {
        self.avatarView.frame = CGRectMake(kScreenWidth-40.0-TOSKitCustomInfo.shareCustomInfo.headMargin, topHeight, 40.0, 40.0);
        self.nickLabel.frame = CGRectMake(0, topHeight, kScreenWidth-CGRectGetWidth(self.avatarView.frame)-TOSKitCustomInfo.shareCustomInfo.headToBubble-TOSKitCustomInfo.shareCustomInfo.headMargin, 14.0f);
        
        self.bubbleView.frame = CGRectMake(CGRectGetMinX(self.avatarView.frame)-235.0-TOSKitCustomInfo.shareCustomInfo.headToBubble, CGRectGetMaxY(self.nickLabel.frame), 235.0, 70.0);
        
        [self setBubbleColor:YES];
        self.nickLabel.textAlignment = NSTextAlignmentRight;
        self.bubbleView.backgroundColor = [UIColor colorWithHexString:@"#E8E1FF"];
        [self.avatarView setImageURL:[NSURL URLWithString:@"https://img2.baidu.com/it/u=1229468480,2938819374&fm=253&fmt=auto&app=120&f=JPEG?w=500&h=500"]];
    }
    else {
        self.avatarView.frame = CGRectMake(TOSKitCustomInfo.shareCustomInfo.headMargin, topHeight, 40.0, 40.0);
        self.nickLabel.frame = CGRectMake(CGRectGetMaxX(self.avatarView.frame)+TOSKitCustomInfo.shareCustomInfo.headToBubble, topHeight, kScreenWidth-84.0, 14.0f);
        
        self.bubbleView.frame = CGRectMake(CGRectGetMaxX(self.avatarView.frame)+TOSKitCustomInfo.shareCustomInfo.headToBubble, CGRectGetMaxY(self.nickLabel.frame), 235.0, 70.0);
        [self setBubbleColor:NO];
        self.nickLabel.textAlignment = NSTextAlignmentLeft;
        self.bubbleView.backgroundColor = [UIColor colorWithHexString:@"#FFFFFF"];
    }
    
    self.iconView.frame = CGRectMake(16.0, 23.0, 22.0, 25.0);
    self.titleView.frame = CGRectMake(53.0, 24.0, 155.0, 23.0);
    
    __block UIImage *placeholder;
//    if ([TOSKitCustomInfo shareCustomInfo].enableLocalAvatar) {
        switch (model.message.senderType.integerValue) {
            case 1:     //座席
                placeholder = [TOSKitCustomInfo shareCustomInfo].customerServiceDefaultAvatar;
                break;
            case 2:     //访客
                placeholder = [TOSKitCustomInfo shareCustomInfo].visitorDefaultAvatar;
                break;
            case 3:     //系统
                placeholder = [TOSKitCustomInfo shareCustomInfo].systemDefaultAvatar;
                break;
            case 4:     //机器人
                placeholder = [TOSKitCustomInfo shareCustomInfo].robotDefaultAvatar;
                break;
            case 5:     //系统通知
                placeholder = [TOSKitCustomInfo shareCustomInfo].systemDefaultAvatar;
                break;
            default:
                placeholder = [TOSKitCustomInfo shareCustomInfo].systemDefaultAvatar;
                break;
        }
//    } else {
//        placeholder = [UIImage imageNamed:[NSString stringWithFormat:@"TOSClient.bundle/defaultAvatar_transparent"]];
//    }
    
    if ([model.message.from isEqualToString:[[OnlineDataSave shareOnlineDataSave] getVisitorId]]) {//访客端
        
        self.nickLabel.text = [[OnlineDataSave shareOnlineDataSave] getVisitorName];
        // 配置是否显示访客端昵称
        if (![TOSKitCustomInfo shareCustomInfo].Chat_visitorName_show) {
            self.nickLabel.text = @"";
        }
    } else {//坐席端
        
        [[OnlineRequestManager sharedCustomerManager] getClientInfoWithSender:model.message.from
                                                                   senderType:[NSString stringWithFormat:@"%@",model.message.senderType] complete:^(OnlineClientInfoModel *completeModel, TIMConnectErrorCode errCode, NSString *errorDes) {
            @StrongObj(self)
            if (errCode == TIM_API_REQUEST_SUCCESSFUL) {
                
                if (completeModel.avatar.length > 0) {
                    // 加载头像
                    [self loadImageWithUrl:completeModel.avatar
                               placeholder:placeholder
                                 imageView:self.avatarView
                                 cacheType:NO];
                } else {
                    self.avatarView.image = placeholder;
                }
                
                if (completeModel.nickName.length > 0) {
                    //保存名称
                    self.nickLabel.text = completeModel.nickName;
                } else {
                    self.nickLabel.text = model.message.senderType.integerValue == 4 ? @"机器人" : @"客服";
                }
            } else {
                self.nickLabel.text = model.message.senderType.integerValue == 4 ? @"机器人" : @"客服";
                self.avatarView.image = placeholder;
            }
        }];
        
        // 配置是否显示坐席或机器人的昵称或工号
        if (![TOSKitCustomInfo shareCustomInfo].Chat_tosRobotName_show) {
            self.nickLabel.text = @"";
        }
    }

    
    [self.messageTopTimeView messageShowTimeLine:model.message.msgDate show:model.message.showTime];
    
    if (model.isSender) {    // 发送者
        dispatch_async(dispatch_get_main_queue(), ^{
            @StrongObj(self)
            self.activityView.frame = CGRectMake(CGRectGetMinX(self.bubbleView.frame)-30.0, CGRectGetMidY(self.bubbleView.frame), 20, 20);
            self.retryButton.frame = CGRectMake(CGRectGetMinX(self.bubbleView.frame)-30.0, CGRectGetMidY(self.bubbleView.frame), 20, 20);
            
        });
        switch (model.message.deliveryState) { // 发送状态
            case ICMessageDeliveryState_Delivering:
            {
                @WeakObj(self)
                dispatch_async(dispatch_get_main_queue(), ^{
                    @StrongObj(self)
                    [self.activityView startAnimating];
                });
                [self.activityView setHidden:NO];
                [self.retryButton setHidden:YES];
                
            }
                break;
            case ICMessageDeliveryState_Delivered:
            {
                @WeakObj(self)
                dispatch_async(dispatch_get_main_queue(), ^{
                    @StrongObj(self)
                    [self.activityView stopAnimating];
                });
                [self.activityView setHidden:YES];
                [self.retryButton setHidden:YES];
                
            }
                break;
            case ICMessageDeliveryState_Failure:
            case ICMessageDeliveryState_Failure_SensitiveWords:
            {
                [self.activityView stopAnimating];
                [self.activityView setHidden:YES];
                [self.retryButton setHidden:NO];
                self.readLabel.text = @"";
            }
                break;
            default:
                break;
        }
        
    }
    
}

- (void)setBubbleColor:(BOOL)isSender{
  
    /// 设置圆角弧度
    if (isSender) {
        _bubbleView.layer.cornerRadius = [TOSKitCustomInfo shareCustomInfo].senderBubble_cornerRadius;
        _bubbleView.image = [UIImage imageWithColor:[TOSKitCustomInfo shareCustomInfo].senderBubble_backGround];
        switch ([TOSKitCustomInfo shareCustomInfo].chatBubble_CornerType) {
            case BubbleCornerTypeLeft: {
                self.bubbleView.layer.maskedCorners = kCALayerMinXMinYCorner | kCALayerMinXMaxYCorner;
                break;
            }
            case BubbleCornerTypeLeftTop: {
                self.bubbleView.layer.maskedCorners = kCALayerMinXMinYCorner;
                break;
            }
            case BubbleCornerTypeLeftBottom: {
                self.bubbleView.layer.maskedCorners = kCALayerMinXMaxYCorner;
                break;
            }
            case BubbleCornerTypeRight: {
                self.bubbleView.layer.maskedCorners = kCALayerMaxXMinYCorner | kCALayerMaxXMaxYCorner;
                break;
            }
            case BubbleCornerTypeRightTop: {
                self.bubbleView.layer.maskedCorners = kCALayerMaxXMinYCorner;
                break;
            }
            case BubbleCornerTypeRightBottom: {
                self.bubbleView.layer.maskedCorners = kCALayerMaxXMaxYCorner;
                break;
            }
            case BubbleCornerTypeTop: {
                self.bubbleView.layer.maskedCorners = kCALayerMinXMinYCorner | kCALayerMaxXMinYCorner;
                break;
            }
            case BubbleCornerTypeBottom: {
                self.bubbleView.layer.maskedCorners = kCALayerMinXMaxYCorner | kCALayerMaxXMaxYCorner;
                break;
            }
            case BubbleCornerTypeNoLeftTop: {
                self.bubbleView.layer.maskedCorners = kCALayerMinXMaxYCorner | kCALayerMaxXMaxYCorner | kCALayerMaxXMinYCorner;
                break;
            }
            case BubbleCornerTypeNoRightTop: {
                self.bubbleView.layer.maskedCorners = kCALayerMinXMaxYCorner | kCALayerMaxXMaxYCorner | kCALayerMinXMinYCorner;
                break;
            }
            case BubbleCornerTypeNoLeftBottom: {
                self.bubbleView.layer.maskedCorners = kCALayerMinXMinYCorner | kCALayerMaxXMinYCorner | kCALayerMaxXMaxYCorner;
                break;
            }
            case BubbleCornerTypeNoRightBottom: {
                self.bubbleView.layer.maskedCorners = kCALayerMinXMinYCorner | kCALayerMaxXMinYCorner | kCALayerMinXMaxYCorner;
                break;
            }
            case BubbleCornerTypeNormal: {
                self.bubbleView.layer.cornerRadius = 0.0f;
                break;
            }
            
            default:
                break;
        }
    } else {
        _bubbleView.layer.cornerRadius = [TOSKitCustomInfo shareCustomInfo].receiveBubble_cornerRadius;
        _bubbleView.image = [UIImage imageWithColor:[TOSKitCustomInfo shareCustomInfo].receiveBubble_backGround];
        switch ([TOSKitCustomInfo shareCustomInfo].chatBubble_CornerType) {
            case BubbleCornerTypeLeft: {
                self.bubbleView.layer.maskedCorners = kCALayerMaxXMinYCorner | kCALayerMaxXMaxYCorner;
                break;
            }
            case BubbleCornerTypeLeftTop: {
                self.bubbleView.layer.maskedCorners = kCALayerMaxXMinYCorner;
                break;
            }
            case BubbleCornerTypeLeftBottom: {
                self.bubbleView.layer.maskedCorners = kCALayerMaxXMaxYCorner;
                break;
            }
            case BubbleCornerTypeRight: {
                self.bubbleView.layer.maskedCorners = kCALayerMinXMinYCorner | kCALayerMinXMaxYCorner;
                break;
            }
            case BubbleCornerTypeRightTop: {
                self.bubbleView.layer.maskedCorners = kCALayerMinXMinYCorner;
                break;
            }
            case BubbleCornerTypeRightBottom: {
                self.bubbleView.layer.maskedCorners = kCALayerMinXMaxYCorner;
                break;
            }
            case BubbleCornerTypeTop: {
                self.bubbleView.layer.maskedCorners = kCALayerMinXMinYCorner | kCALayerMaxXMinYCorner;
                break;
            }
            case BubbleCornerTypeBottom: {
                self.bubbleView.layer.maskedCorners = kCALayerMinXMaxYCorner | kCALayerMaxXMaxYCorner;
                break;
            }
            case BubbleCornerTypeNoLeftTop: {
                self.bubbleView.layer.maskedCorners = kCALayerMinXMaxYCorner | kCALayerMaxXMaxYCorner | kCALayerMinXMinYCorner;
                break;
            }
            case BubbleCornerTypeNoRightTop: {
                self.bubbleView.layer.maskedCorners = kCALayerMinXMaxYCorner | kCALayerMaxXMaxYCorner | kCALayerMaxXMinYCorner;
                break;
            }
            case BubbleCornerTypeNoLeftBottom: {
                self.bubbleView.layer.maskedCorners = kCALayerMinXMinYCorner | kCALayerMaxXMinYCorner | kCALayerMinXMaxYCorner;
                break;
            }
            case BubbleCornerTypeNoRightBottom: {
                self.bubbleView.layer.maskedCorners = kCALayerMinXMinYCorner | kCALayerMaxXMinYCorner | kCALayerMaxXMaxYCorner;
                break;
            }
            case BubbleCornerTypeNormal: {
                self.bubbleView.layer.cornerRadius = 0.0f;
                break;
            }
            default:
                break;
        }
    }
    _bubbleView.layer.masksToBounds = YES;
}

#pragma mark - lazy

-(ICMessageTopTimeView *)messageTopTimeView{
    if (_messageTopTimeView == nil) {
        _messageTopTimeView = [[ICMessageTopTimeView alloc] init];
    }
    return _messageTopTimeView;
}


- (UIActivityIndicatorView *)activityView {
    if (_activityView == nil) {
        _activityView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    }
    return _activityView;
}

- (UIButton *)retryButton {
    if (_retryButton == nil) {
        _retryButton = [[UIButton alloc] init];
        /// 是否显示标题
        if ([TOSKitCustomInfo shareCustomInfo].resendButton.currentTitle) {
            [_retryButton setTitle:[TOSKitCustomInfo shareCustomInfo].resendButton.titleLabel.text forState:(UIControlStateNormal)];
            _retryButton.titleLabel.font = [TOSKitCustomInfo shareCustomInfo].resendButton.titleLabel.font;
        }
        /// 是否设置字体颜色
        if ([TOSKitCustomInfo shareCustomInfo].resendButton.currentTitleColor) {
            UIColor * textColor = [TOSKitCustomInfo shareCustomInfo].resendButton.currentTitleColor;
            [_retryButton setTitleColor:textColor forState:(UIControlStateNormal)];
        }
        
        /// 是否显示图片
        if ([TOSKitCustomInfo shareCustomInfo].resendButton.currentImage) {
            [_retryButton setImage:[TOSKitCustomInfo shareCustomInfo].resendButton.currentImage forState:UIControlStateNormal];
        }
        /// 是否显示背景图片
        if ([TOSKitCustomInfo shareCustomInfo].resendButton.currentBackgroundImage) {
            [_retryButton setBackgroundImage:[TOSKitCustomInfo shareCustomInfo].resendButton.currentBackgroundImage forState:(UIControlStateNormal)];
        }
        if ([TOSKitCustomInfo shareCustomInfo].resendButton.currentImage && [TOSKitCustomInfo shareCustomInfo].resendButton.currentTitle) {
            _retryButton.imageEdgeInsets = [TOSKitCustomInfo shareCustomInfo].resendButton.imageEdgeInsets;
            _retryButton.titleEdgeInsets = [TOSKitCustomInfo shareCustomInfo].resendButton.titleEdgeInsets;
        }
        
        _retryButton.layer.cornerRadius = [TOSKitCustomInfo shareCustomInfo].resendButton.layer.cornerRadius;
        _retryButton.layer.borderColor = [TOSKitCustomInfo shareCustomInfo].resendButton.layer.borderColor;
        _retryButton.layer.borderWidth = [TOSKitCustomInfo shareCustomInfo].resendButton.layer.borderWidth;
        
//        _retryButton.backgroundColor = UIColor.orangeColor;
        [_retryButton addTarget:self action:@selector(retryButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _retryButton;
}

- (UILabel *)nickLabel {
    if (!_nickLabel) {
        _nickLabel = [[UILabel alloc] initWithFrame:(CGRectZero)];
        _nickLabel.font = [UIFont systemFontOfSize:12.0f];
        _nickLabel.text = @"张三";
        
    }
    return _nickLabel;
}

- (UIImageView *)avatarView {
    if (!_avatarView) {
        _avatarView = [[UIImageView alloc] initWithFrame:(CGRectZero)];
        _avatarView.layer.cornerRadius = 20.0f;
        _avatarView.layer.masksToBounds = YES;
        _avatarView.backgroundColor = [UIColor orangeColor];
        _avatarView.userInteractionEnabled = YES;
        
    }
    return _avatarView;
}

- (UIView *)bubbleView {
    if (!_bubbleView) {
        _bubbleView = [[UIImageView alloc] initWithFrame:(CGRectZero)];
        _bubbleView.backgroundColor = [UIColor colorWithHexString:@"#E8E1FF"];
        _bubbleView.userInteractionEnabled = YES;
        
        UITapGestureRecognizer *longGes = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(bubbleClicked:)];
        [_bubbleView addGestureRecognizer:longGes];
        
        
    }
    return _bubbleView;
}

- (UIImageView *)iconView {
    if (!_iconView) {
        _iconView = [[UIImageView alloc] initWithFrame:(CGRectZero)];
        _iconView.image = [UIImage imageNamed:@"custom_File"];
        
    }
    return _iconView;
}

- (UILabel *)titleView {
    if (!_titleView) {
        _titleView = [[UILabel alloc] initWithFrame:(CGRectZero)];
        _titleView.textColor = [UIColor colorWithHexString:@"#141223"];
        _titleView.lineBreakMode = NSLineBreakByTruncatingMiddle;
        
    }
    return _titleView;
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
