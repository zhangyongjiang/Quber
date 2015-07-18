//
//  IconTitleSummaryCell.m
//
//
//  Created by Kevin Zhang on 11/18/14.
//  Copyright (c) 2014 Kevin Zhang. All rights reserved.
//

#import "IconTitleCell.h"

@implementation IconTitleCell

-(id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    
    self.backgroundColor = [UIColor whiteColor];
    self.iconImgView = [[UIImageView alloc] initWithScaledFrame:CGRectMake(0, 0, 30*[UIView scale], 30*[UIView scale])];
    self.iconImgView.image = [UIImage imageNamed:@"socialEmail"];
    [self addSubview:self.iconImgView];
    
    self.titleLabel = [[FitLabel alloc] init];
    self.titleLabel.text = @"some title text";
    [self.titleLabel h3];
    [self addSubview:self.titleLabel];
    
    return self;
}

-(void)layoutSubviews {
    [super layoutSubviews];
    [self.iconImgView vcenterInParent];
    self.iconImgView.x =  PagePadding;
    [self.titleLabel rightOfView:self.iconImgView withMargin:20*[UIView scale]];
    [self.titleLabel vcenterInParent];
}

@end
