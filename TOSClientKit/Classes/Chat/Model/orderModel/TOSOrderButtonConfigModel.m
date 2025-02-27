//
//  TOSOrderButtonConfigModel.m
//  TOSClientKit
//
//  Created by 李成 on 2024/11/5.
//  Copyright © 2024 YanBo. All rights reserved.
//

#import "TOSOrderButtonConfigModel.h"

@implementation TOSOrderButtonConfigModel

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"type" : @"type"};
}

- (BOOL)modelCustomTransformFromDictionary:(NSDictionary *)dic {
    NSString *typeString = dic[@"type"];
    if ([typeString isKindOfClass:[NSString class]]) {
        if ([typeString isEqualToString:@"sendCard"]) {
            self.type = OrderButtonConfigTypeSendCard;
        } else if ([typeString isEqualToString:@"sendContent"]) {
            self.type = OrderButtonConfigTypeSendContent;
        } else {
            self.type = OrderButtonConfigTypeLink;
        }
    }
    return YES;
}


- (NSDictionary *)dictionaryRepresentation {
    NSString *typeString = @"";
    if (self.type == OrderButtonConfigTypeSendCard) {
        typeString = @"sendCard";
    } else if (self.type == OrderButtonConfigTypeSendContent) {
        typeString = @"sendContent";
    } else {
        typeString = @"link";
    }
    return @{
        @"text": self.text?:@"",
        @"content": self.content?:@"",
        @"linkUrl": self.linkUrl?:@"",
        @"style": self.style?:@{},
        @"type": typeString,
    };
}

@end


@implementation TOSOrderBottomButtonConfigModel

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"type" : @"type"};
}

- (BOOL)modelCustomTransformFromDictionary:(NSDictionary *)dic {
    NSString *typeString = dic[@"type"];
    if ([typeString isKindOfClass:[NSString class]]) {
        if ([typeString isEqualToString:@"sendCard"]) {
            self.type = OrderButtonConfigTypeSendCard;
        } else if ([typeString isEqualToString:@"sendContent"]) {
            self.type = OrderButtonConfigTypeSendContent;
        } else {
            self.type = OrderButtonConfigTypeLink;
        }
    }
    return YES;
}

- (NSDictionary *)dictionaryRepresentation {
    NSString *typeString = @"";
    if (self.type == OrderButtonConfigTypeSendCard) {
        typeString = @"sendCard";
    } else if (self.type == OrderButtonConfigTypeSendContent) {
        typeString = @"sendContent";
    } else {
        typeString = @"link";
    }
    return @{
        @"text": self.text?:@"",
        @"content": self.content?:@"",
        @"linkUrl": self.linkUrl?:@"",
        @"style": self.style?:@{},
        @"type": typeString,
        @"target": self.target?:@"",
    };
}

@end
