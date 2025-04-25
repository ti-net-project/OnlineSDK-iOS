//
//  TOSSatisfactionSolveView.m
//  TOSClientKit
//
//  Created by 言 on 2023/9/28.
//  Copyright © 2023 YanBo. All rights reserved.
//

#import "TOSSatisfactionSolveView.h"
#import "TIMYYKit.h"
#import "TIMConstants.h"
#import "TOSSatisfactionModel.h"

@interface TOSSatisfactionSolveView ()

@property (nonatomic, strong) UILabel *title;

@property (nonatomic, strong) TIMYYAnimatedImageView *resolved;

@property (nonatomic, strong) TIMYYAnimatedImageView *unsolved;

@property (nonatomic, strong) TIMYYImage *resolveGray;
@property (nonatomic, strong) TIMYYImage *unsolvedGray;

@property (nonatomic, strong) UIView *line;

@end

@implementation TOSSatisfactionSolveView
- (void)setupSubviews {
    [super setupSubviews];
    
    self.backgroundColor = [UIColor clearColor];
    
    self.resolvedSelected = YES;
    [self addSubview:self.title];
    [self addSubview:self.resolved];
    [self addSubview:self.unsolved];
    
    [self addSubview:self.line];
}

- (void)defineLayout {
    [super defineLayout];
    
    if (self.contentModel.investigation.chatSatisSolveState.enabled.integerValue == 1) {
        self.title.frame = CGRectMake(16.f, 16.f, self.width_sd - 32.f, 22.f);
        self.resolved.frame = CGRectMake(42.f, 12.f + self.title.bottom_sd, 116.f, 40.f);
        self.unsolved.frame = CGRectMake(0.f, 12.f + self.title.bottom_sd, 116.f, 40.f);
        self.unsolved.right_sd = self.right_sd - 41.f;
        
        self.line.frame = CGRectMake(16.f, 16.f + self.resolved.bottom_sd, self.width_sd - 32.f, 0.5f);
    } else {
        self.title.frame = CGRectZero;
        self.resolved.frame = CGRectZero;
        self.unsolved.frame = CGRectZero;
        self.line.frame = CGRectZero;
    }
}

- (void)didClickCloseBtnAction:(UIButton *)sender {
    
}

#pragma mark - 懒加载
- (UILabel *)title {
    if (!_title) {
        _title = [[UILabel alloc] initWithFrame:(CGRectZero)];
        _title.text = @"您的问题是否得到解决";
        _title.textColor = TOSHexColor(0x262626);
        _title.textAlignment = NSTextAlignmentCenter;
        _title.font = [UIFont fontWithName:@"PingFangSC-Regular" size:14.f];
        _title.numberOfLines = 0;
    }
    return _title;
}

- (TIMYYAnimatedImageView *)resolved {
    if (!_resolved) {
        _resolved = [[TIMYYAnimatedImageView alloc] initWithFrame:CGRectMake(0.f, 12.f, 116.f, 40.f)];
        self.resolveGray = [TIMYYImage imageNamed:[NSString stringWithFormat:@"%@/%@",FRAMEWORKS_BUNDLE_PATH,@"TOSSatisfaction_resolve_gray.gif"]];
        _resolved.image = [TIMYYImage imageNamed:[NSString stringWithFormat:@"%@/%@",FRAMEWORKS_BUNDLE_PATH,@"TOSSatisfaction_resolve.gif"]];
        _resolved.autoPlayAnimatedImage = NO;
        _resolved.currentAnimatedImageIndex = 0;
        _resolved.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapResolvedAction:)];
        [_resolved addGestureRecognizer:tap];
    }
    return _resolved;
}

- (TIMYYAnimatedImageView *)unsolved {
    if (!_unsolved) {
        _unsolved = [[TIMYYAnimatedImageView alloc] initWithFrame:CGRectMake(0.f, 12.f, 116.f, 40.f)];
        self.unsolvedGray = [TIMYYImage imageNamed:[NSString stringWithFormat:@"%@/%@",FRAMEWORKS_BUNDLE_PATH,@"TOSSatisfaction_unsolved_gray.gif"]];
        _unsolved.image = self.unsolvedGray;
        _unsolved.autoPlayAnimatedImage = NO;
        _unsolved.currentAnimatedImageIndex = 0;
        _unsolved.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapUnsolvedAction:)];
        [_unsolved addGestureRecognizer:tap];
    }
    return _unsolved;
}

- (UIView *)line {
    if (!_line) {
        _line = [[UIView alloc] initWithFrame:CGRectZero];
        _line.backgroundColor = TOSHexAColor(0x000000, 0.1f);
    }
    return _line;
}

- (void)tapResolvedAction:(UITapGestureRecognizer *)sender {
    [self setupResolved:YES];
}

- (void)tapUnsolvedAction:(UITapGestureRecognizer *)sender {
    [self setupResolved:NO];
}

- (void)setupResolved:(BOOL)isSelectedResolved {
    if (isSelectedResolved) {
        self.resolvedSelected = YES;
        self.resolved.image = [TIMYYImage imageNamed:[NSString stringWithFormat:@"%@/%@",FRAMEWORKS_BUNDLE_PATH,@"TOSSatisfaction_resolve.gif"]];
        self.unsolved.image = self.unsolvedGray;
        
    } else {
        self.resolvedSelected = NO;
        self.resolved.image = self.resolveGray;
        self.unsolved.image = [TIMYYImage imageNamed:[NSString stringWithFormat:@"%@/%@",FRAMEWORKS_BUNDLE_PATH,@"TOSSatisfaction_unsolved.gif"]];
    }
    
    [self.resolved startAnimating];
    [self.unsolved startAnimating];
    @weakify(self)
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3.f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        @strongify(self)
        [self.resolved stopAnimating];
        [self.unsolved stopAnimating];
    });
}

@end
