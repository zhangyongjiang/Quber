//
//  IconTitleRightText.m
//
//
//  Created by Kevin Zhang on 1/2/15.
//  Copyright (c) 2015 Kevin Zhang. All rights reserved.
//

#import "IconTitleRightText.h"

@implementation IconTitleRightText

-(id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    self.rightLabel = [[FitLabel alloc] initWithFrame:CGRectMake(frame.size.width*0.8, 0, frame.size.width*0.2, frame.size.height)];
    self.rightLabel.textAlignment = NSTextAlignmentRight;
    self.rightLabel.fit = YES;
    self.rightLabel.vcenter = YES;
    [self addSubview:self.rightLabel];
    return self;
}

@end
