//
//  NSScrollView.m
//
//
//  Created by Kevin Zhang on 2/5/15.
//  Copyright (c) 2015 Kevin Zhang. All rights reserved.
//

#import "NSScrollView.h"

@implementation NSScrollView

-(void)addSubview:(UIView *)view {
    [super addSubview:view];
    CGRect rect = [self rectForSubviews];
    self.contentSize = CGSizeMake(self.width, rect.size.height);
}

@end
