//
//  LabelWithNext.m
//
//
//  Created by Kevin Zhang on 1/18/15.
//  Copyright (c) 2015 Kevin Zhang. All rights reserved.
//

#import "LabelWithNext.h"

@interface LabelWithNext()


@end

@implementation LabelWithNext

-(id)init {
    self = [super initWithFrame:CGRectMake(0, 0, [UIView screenWidth], LabelLineHeight)];
    self.backgroundColor = [UIColor whiteColor];
    self.clipsToBounds = YES;
    
    self.label = [[FitLabel alloc] initWithFrame:CGRectMake(PagePadding, 0, 0, 0)];
    [self.label h3];
    [self addSubview:self.label];
    
    self.imgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"sideArrow"]];
    [self addSubview:self.imgView];
    [self.imgView alignParentRightWithMarghin:PagePadding];
    [self.imgView vcenterInParent];
    
    return self;
}

-(void)layoutSubviews {
    [super layoutSubviews];
    [self.label vcenterInParent];
}

-(void)setText:(NSString *)text {
    self.label.text = text;
}
@end
