//
//  CoverView.m
//  Next Shopper
//
//  Created by Kevin Zhang on 10/12/14.
//  Copyright (c) 2014 Gaoshin. All rights reserved.
//

#import "CoverView.h"

@implementation CoverView

-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.6];
    self.userInteractionEnabled = YES;
    self.accessibilityLabel = @"CoverView";
    return self;
}
@end
