//
//  LabelWithCaption.m
//
//
//  Created by Kevin Zhang on 1/17/15.
//  Copyright (c) 2015 Kevin Zhang. All rights reserved.
//

#import "LabelWithCaption.h"

@interface LabelWithCaption()

@property(strong,nonatomic)UILabel* labelCaption;
@property(strong,nonatomic)UILabel* labelText;

@end

@implementation LabelWithCaption

-(id)initWithCaption:(NSString *)caption {
    self = [super initWithFrame:CGRectMake(0, 0, [UIView screenWidth], LabelLineHeight)];
    self.backgroundColor = [UIColor whiteColor];
    
    self.labelCaption = [[FitLabel alloc] initWithFrame:CGRectMake(PagePadding, 0, 0, 0)];
    [self.labelCaption styleTableViewRowLabel];
    self.labelCaption.text = caption;
    [self addSubview:self.labelCaption];
    
    self.labelText = [[FitLabel alloc] initWithFrame:CGRectZero];
    [self.labelText styleTableViewRowContent];
    [self addSubview:self.labelText];
    
    return self;
}

-(void)layoutSubviews {
    [super layoutSubviews];
    [self.labelCaption vcenterInParent];
    [self.labelText vcenterInParent];
    [self.labelText alignParentRightWithMarghin:PagePadding];
}

-(void)setText:(NSString *)text {
    self.labelText.text = text;
}

@end
