//
//  LogoImageView.m
//
//
//  Created by Kevin Zhang on 11/16/14.
//  Copyright (c) 2014 Kevin Zhang. All rights reserved.
//

#import "LogoImageView.h"

@implementation LogoImageView

-(id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    self.image = [UIImage imageNamed:@"logo_slogan"];
    self.contentMode = UIViewContentModeCenter;
    return self;
}
@end
