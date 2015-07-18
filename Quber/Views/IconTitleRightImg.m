//
//  IconTitleRightImg.m
//
//
//  Created by Kevin Zhang on 1/2/15.
//  Copyright (c) 2015 Kevin Zhang. All rights reserved.
//

#import "IconTitleRightImg.h"

@implementation IconTitleRightImg

-(id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    self.rightImgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"sideArrow"]];
    [self addSubview:self.rightImgView];
    return self;
}

-(void)layoutSubviews {
    [super layoutSubviews];
    [self.rightImgView vcenterInParent];
    [self.rightImgView alignParentRightWithMarghin:PagePadding];
}

@end
