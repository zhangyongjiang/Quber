//
//  Line.m
//
//
//  Created by Kevin Zhang on 3/6/15.
//  Copyright (c) 2015 Kevin Zhang. All rights reserved.
//

#import "Line.h"

@implementation Line

-(id)init {
    self = [super initWithFrame:CGRectMake(0, 0, [UIView screenWidth], 0.5)];
    self.backgroundColor = FormBorderColor;
//    self.backgroundColor = [UIColor clearColor];
    return self;
}

@end
