//
//  IconTitleSummaryCell.m
//
//
//  Created by Kevin Zhang on 11/18/14.
//  Copyright (c) 2014 Kevin Zhang. All rights reserved.
//

#import "IconTitleSummaryCell.h"

@implementation IconTitleSummaryCell


-(id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    
    self.backgroundColor = [UIColor whiteColor];
    self.iconImgView = [[UIImageView alloc] initWithScaledFrame:CGRectMake(0, 0, 30, 30)];
    self.iconImgView.image = [UIImage imageNamed:@"socialEmail"];
    [self addSubview:self.iconImgView];
    
    self.titleLabel = [[FitLabel alloc] init];
    self.titleLabel.text = @"some title text";
    [self.titleLabel h4];
    [self addSubview:self.titleLabel];
    
    self.summaryLabel = [[FitLabel alloc] init];
    self.summaryLabel.text = @"some summary text";
    [self.summaryLabel h4];
    self.summaryLabel.numberOfLines = 1;
    [self addSubview:self.summaryLabel];
    return self;
}

-(void)layoutSubviews {
    [self.iconImgView vcenterInParent];
    self.iconImgView.x = PagePadding;
    [self vcenterMargin:7*[UIView scale] forSubviews:self.titleLabel, self.summaryLabel, nil];
    [self.titleLabel rightOfView:self.iconImgView withMargin:20*[UIView scale]];
    [self.summaryLabel rightOfView:self.iconImgView withMargin:20*[UIView scale]];
}

@end
