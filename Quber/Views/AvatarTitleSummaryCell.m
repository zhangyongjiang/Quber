//
//  avatarTitleSummaryCell.m
//
//
//  Created by Kevin Zhang on 11/18/14.
//  Copyright (c) 2014 Kevin Zhang. All rights reserved.
//

#import "AvatarTitleSummaryCell.h"

@implementation AvatarTitleSummaryCell


-(id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    self.backgroundColor = [UIColor whiteColor];
    self.avatarImgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 45, 45)];
    self.avatarImgView.image = [UIImage imageNamed:@"avatarDefault"];
    self.avatarImgView.layer.cornerRadius = 22.5;
    self.avatarImgView.layer.masksToBounds = YES;
    [self addSubview:self.avatarImgView];
    
    self.titleLabel = [[FitLabel alloc] init];
    self.titleLabel.text = @"some title text";
    [self.titleLabel styleTableViewRowLabel];
    [self addSubview:self.titleLabel];
    
    self.summaryLabel = [[FitLabel alloc] init];
    self.summaryLabel.text = @"some summary text";
    [self.summaryLabel styleTableViewRowTag];
    [self addSubview:self.summaryLabel];
    return self;
}

-(void)layoutSubviews {
    [self.avatarImgView vcenterInParent];
    self.avatarImgView.x = PagePadding;
    [self vcenterMargin:7*[UIView scale] forSubviews:self.titleLabel, self.summaryLabel, nil];
    [self.titleLabel rightOfView:self.avatarImgView withMargin:20*[UIView scale]];
    [self.summaryLabel rightOfView:self.avatarImgView withMargin:20*[UIView scale]];
}

@end
