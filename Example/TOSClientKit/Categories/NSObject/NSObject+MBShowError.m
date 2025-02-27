//
//  NSObject+ShowError.m
//  SmartHome
//
//  Created by 赵言 on 2019/7/4.
//  Copyright © 2019 赵言. All rights reserved.
//

#import "NSObject+MBShowError.h"
//#import "MBProgressHUD+GeneralConfiguration.h"
#import "TOSAppDelegate.h"

@implementation NSObject (MBShowError)

//- (void)showMBErrorView:(NSString *)str {
//    if ([str isEqualToString:@"Access Denied"] || [str isEqualToString:@"OK"] || [str isEqualToString:@"ok"]) {
//        return;
//    }
//    dispatch_async(dispatch_get_main_queue(), ^{
//        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:[AppDelegate shareAppDelegate].window animated:YES];
//        hud.mode = MBProgressHUDModeText;
//        hud.margin = 10.f;
//        hud.detailsLabel.text = str;
//        hud.offset = CGPointMake(kWindowWidth/2 - hud.width/2, kWindowHeight/4);
//        [hud setupMBProgress];
//        [hud hideAnimated:YES afterDelay:2.f];
//    });
//}

- (void)showMBErrorView:(NSString *)str {
    if ([str isEqualToString:@"Access Denied"] || [str isEqualToString:@"OK"] || [str isEqualToString:@"ok"]) {
        return;
    }
    if (strcmp(dispatch_queue_get_label(DISPATCH_CURRENT_QUEUE_LABEL), dispatch_queue_get_label(dispatch_get_main_queue())) == 0) {
        [self showMBProgress:str];
    } else {
        dispatch_async(dispatch_get_main_queue(), ^{
            [self showMBProgress:str];
        });
    }
}

- (void)showMBProgress:(NSString *)str {
//    UIWindow *window = [UIApplication sharedApplication].windows.lastObject;
//    TIMMBProgressHUD *hud = [TIMMBProgressHUD showHUDAddedTo:window animated:YES];
//    TIMMBProgressHUD *hud = [TIMMBProgressHUD showHUDAddedTo:((AppDelegate*)[UIApplication sharedApplication].delegate).window animated:YES];
    UIWindow *window = ((TOSAppDelegate*)[[UIApplication sharedApplication] delegate]).window;
    NSArray *array = [[UIApplication sharedApplication] windows];
    if (array.count > 0) {
        window = [array objectAtIndex:0];
    }
//    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:window animated:YES];

//    [self setupMBProgress:hud];
//    hud.mode = MBProgressHUDModeText;
//    hud.margin = 10.f;
//    hud.detailsLabel.text = str?:@"";
//    hud.offset = CGPointMake(0, kWindowHeight/2 - kBottomBarHeight - 98.f);
////    if ([str isEqualToString: kMultiLoginErrorMessage]) {
////        hud.bezelView.color = TOSHexColor(0xEBEBEB);
////        hud.bezelView.layer.cornerRadius = 15;
////        hud.detailsLabel.textColor = [UIColor blackColor];
////    }else{
//        hud.bezelView.color = [UIColor blackColor];
//        hud.bezelView.layer.cornerRadius = 10;
//        hud.detailsLabel.textColor = [UIColor whiteColor];
////    }
//    [hud hideAnimated:YES afterDelay:2.f];
}

//- (void)setupMBProgress:(MBProgressHUD *)mb {
//    mb.contentColor = [UIColor whiteColor];
//    mb.bezelView.color = TOSHexColor(0x333333);
//    mb.bezelView.style = MBProgressHUDBackgroundStyleSolidColor;
//    mb.minShowTime = 0;
//    mb.userInteractionEnabled = NO;
//    mb.detailsLabel.font = [UIFont fontWithName:@"PingFangSC-Light" size:14.f];
//    mb.removeFromSuperViewOnHide = YES;
////    mb.bezelView.color = [UIColor blackColor];
////    mb.bezelView.layer.cornerRadius = 10;
////    mb.detailsLabel.textColor = [UIColor whiteColor];
//    mb.bezelView.color = TOSHexColor(0xEBEBEB);
//    mb.bezelView.layer.cornerRadius = 15;
//    mb.detailsLabel.textColor = [UIColor blackColor];
//
//}

@end
