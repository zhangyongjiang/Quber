//
//  EmptyPage.m
//
//
//  Created by Kevin Zhang on 2/9/15.
//  Copyright (c) 2015 Kevin Zhang. All rights reserved.
//

#import "EmptyPage.h"

@implementation EmptyPage

-(id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    
    self.imgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 164, [UIView screenWidth], 80)];
    self.imgView.contentMode = UIViewContentModeCenter;
    [self addSubview:self.imgView];
    
    self.label = [[UILabel alloc] initWithFrame:CGRectMake(0, 269, [UIView screenWidth], 50  )];
    [self.label h2];
    self.label.textAlignment = NSTextAlignmentCenter;
    [self addSubview:self.label];
    
    return self;
}
@end
