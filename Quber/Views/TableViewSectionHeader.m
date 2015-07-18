//
//  TableViewSectionHeaderLabel.m
//
//
//  Created by Kevin Zhang on 11/19/14.
//  Copyright (c) 2014 Kevin Zhang. All rights reserved.
//

#import "TableViewSectionHeader.h"


@implementation TableViewSectionHeader

-(id)init {
    self = [super initWithFrame:CGRectMake(0, 0, [UIView screenWidth], 63)];
    [self setup];
    return self;
}

-(id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    [self setup];
    return self;
}

-(void)setup {
    self.backgroundColor = [UIColor colorFromString:@"nsbg"];
    Line* line = [[Line alloc] init];
    [self addSubview:line];
    [line alignParentBottomWithMarghin:0];
//    self.layer.borderColor = FormBorderColor.CGColor;
//    self.layer.borderWidth = 0.5;
}

@end

@implementation TableViewSectionHeaderLabel

-(void)setup {
    [super setup];
    self.label = [[FitLabel alloc] init];
    [self.label styleTableViewSection];
    [self addSubview:self.label];
    self.label.uppercase = YES;
    self.label.text = @"TableViewSectionHeaderLabel";
    self.label.x = 15 * [UIView scale];
    [self.label alignParentBottomWithMarghin:10];
}

@end
