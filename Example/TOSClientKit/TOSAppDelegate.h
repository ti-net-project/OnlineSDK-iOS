//
//  TOSAppDelegate.h
//  TOSClientKit
//
//  Created by 赵言 on 02/26/2025.
//  Copyright (c) 2025 赵言. All rights reserved.
//

@import UIKit;
#import "MainTabBarController.h"

@interface TOSAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (nonatomic, retain) MainTabBarController *tabbarVC;

+ (TOSAppDelegate *)shareAppDelegate;

@end
