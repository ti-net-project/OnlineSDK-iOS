//
//  TOSSDKConfigModel.m
//  TOSClientKit
//
//  Created by 李成 on 2024/11/20.
//  Copyright © 2024 YanBo. All rights reserved.
//

#import "TOSSDKConfigModel.h"

@implementation TOSSDKConfigModel

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{
        @"appWindowSetting" : [TOSAppWindowSetting class],
    };
}

@end

@implementation TOSAppWindowSetting

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{
        @"quickEntries" : [TOSQuickEntrieModel class],
        @"toolbarList" : [TOSToolbarItemModel class],
    };
}

@end


@implementation TOSQuickEntrieModel

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"type" : @"type"};
}

- (BOOL)modelCustomTransformFromDictionary:(NSDictionary *)dic {
    NSString *typeString = dic[@"type"];
    if ([typeString isKindOfClass:[NSString class]]) {
        if ([typeString isEqualToString:@"1"]) {
            self.type = TOSQuickEntrieTypeLink;
        } else if ([typeString isEqualToString:@"2"]) {
            self.type = TOSQuickEntrieTypeSatisfaction;
        } else if ([typeString isEqualToString:@"3"]) {
            self.type = TOSQuickEntrieTypeCloseChat;
        } else if ([typeString isEqualToString:@"4"]) {
            self.type = TOSQuickEntrieTypeSendText;
        } else if ([typeString isEqualToString:@"8"]) {
            self.type = TOSQuickEntrieTypeOrderCard;
        } else if ([typeString isEqualToString:@"9"]) {
            self.type = TOSQuickEntrieTypeTicketPlugin;
        } else if ([typeString isEqualToString:@"10"]) {
            self.type = TOSQuickEntrieTypeArtificial;
        } else if ([typeString isEqualToString:@"11"]) {
            self.type = TOSQuickEntrieTypeCustom;
        } else {
            self.type = TOSQuickEntrieTypeCustom;
        }
    }
    return YES;
}


@end


@implementation TOSToolbarItemModel

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"type" : @"type"};
}

- (BOOL)modelCustomTransformFromDictionary:(NSDictionary *)dic {
    NSString *typeString = dic[@"type"];
    if ([typeString isKindOfClass:[NSString class]]) {
        if ([typeString isEqualToString:@"1"]) {
            self.type = TOSToolbarItemEventTypePhoto;
        } else if ([typeString isEqualToString:@"2"]) {
            self.type = TOSToolbarItemEventTypeTakePicture;
        } else if ([typeString isEqualToString:@"3"]) {
            self.type = TOSToolbarItemEventTypeFile;
        } else if ([typeString isEqualToString:@"4"]) {
            self.type = TOSToolbarItemEventTypeSatisfaction;
        } else if ([typeString isEqualToString:@"5"]) {
            self.type = TOSToolbarItemEventTypeCloseChat;
        } else if ([typeString isEqualToString:@"6"]) {
            self.type = TOSToolbarItemEventTypeLink;
        } else if ([typeString isEqualToString:@"10"]) {
            self.type = TOSToolbarItemEventTypeOrderCard;
        } else if ([typeString isEqualToString:@"11"]) {
            self.type = TOSToolbarItemEventTypeArtificial;
        } else if ([typeString isEqualToString:@"12"]) {
            self.type = TOSToolbarItemEventTypeSendText;
        } else if ([typeString isEqualToString:@"13"]) {
            self.type = TOSToolbarItemEventTypeCustom;
        } else {
            self.type = TOSToolbarItemEventTypeCustom;
        }
    }
    return YES;
}

@end
