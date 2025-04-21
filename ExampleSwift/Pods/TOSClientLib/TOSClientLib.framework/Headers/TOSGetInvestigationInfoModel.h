//
//  TOSGetInvestigationInfoModel.h
//  TOSClientLib
//
//  Created by 言 on 2022/8/30.
//  Copyright © 2022 YanBo. All rights reserved.
//

#import <TOSClientLib/TOSClientLib.h>

NS_ASSUME_NONNULL_BEGIN

@interface TOSGetInvestigationOptionsModel : TIMLibBaseModel

@property (nonatomic, copy) NSString *invitationInitiator;

@property (nonatomic, strong) NSArray <NSString *>*label;

@property (nonatomic, copy) NSString *name;
@property (nonatomic, strong) NSNumber *star;
@property (nonatomic, copy) NSString *starDesc;

@end

@interface TOSGetInvestigationInfoModel : TIMLibBaseModel

+ (instancetype)shareInvestigationInfoModel;

@property (nonatomic, strong) NSNumber *alreadyInvestigation;
@property (nonatomic, copy) NSString *appId;
@property (nonatomic, copy) NSString *appName;
@property (nonatomic, copy) NSString *chatStartTime;
@property (nonatomic, copy) NSString *clientName;
@property (nonatomic, copy) NSString *cno;
@property (nonatomic, copy) NSString *contactType;
@property (nonatomic, copy) NSString *description;
@property (nonatomic, strong) NSNumber *endTime;
@property (nonatomic, strong) NSNumber *enterpriseId;
@property (nonatomic, strong) NSNumber *hour;
@property (nonatomic, strong) NSNumber *invitationInitiator;
@property (nonatomic, strong) NSDictionary *join;
@property (nonatomic, strong) NSNumber *keys;
@property (nonatomic, strong) NSDictionary *label;
@property (nonatomic, copy) NSString *mainUniqueId;

@property (nonatomic, strong) NSArray <TOSGetInvestigationOptionsModel *>*options;

@property (nonatomic, copy) NSString *qname;
@property (nonatomic, copy) NSString *qno;
@property (nonatomic, copy) NSString *remark;
@property (nonatomic, copy) NSString *solve;
@property (nonatomic, strong) NSNumber *startTime;
@property (nonatomic, strong) NSNumber *totalDuration;
@property (nonatomic, copy) NSString *type;
@property (nonatomic, copy) NSString *uniqueId;
@property (nonatomic, copy) NSString *visitorId;
@property (nonatomic, copy) NSString *visitorName;

@end

NS_ASSUME_NONNULL_END
