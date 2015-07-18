//
//  LabelWithTitle.m
//
//
//  Created by Kevin Zhang on 1/17/15.
//  Copyright (c) 2015 Kevin Zhang. All rights reserved.
//

#import "LabelWithTitle.h"

@interface LabelWithTitle()

@property(strong,nonatomic)UILabel* labelTitle;
@property(strong,nonatomic)UILabel* labelContent;

@end

@implementation LabelWithTitle

-(id)initWithTitle:(NSString *)title {
    self = [super initWithFrame:CGRectMake(0, 0, [UIView screenWidth], 100)];
    self.backgroundColor = [UIColor whiteColor];
    self.clipsToBounds = YES;
    self.fitHeight = YES;

    self.labelTitle = [[FitLabel alloc] initWithFrame:CGRectMake(PagePadding, PagePadding, self.width, 20)];
    [self.labelTitle styleTableViewRowLabel];
    self.labelTitle.text = title;
    [self addSubview:self.labelTitle];
    
    self.labelContent = [[UILabel alloc] initWithFrame:CGRectMake(PagePadding, self.labelTitle.bottom+PagePadding/2, self.width-PagePadding*2, self.height - self.labelTitle.bottom - PagePadding/2)];
    [self.labelContent styleTableViewRowContent];
    self.labelContent.lineBreakMode = NSLineBreakByWordWrapping;
    self.labelContent.numberOfLines = 0;
    [self addSubview:self.labelContent];
    
    return self;
}

-(void)setText:(NSString *)text {
    [self.labelContent setText:text withLineSpacing:4];

    if(self.fitHeight) {
        [self.labelContent fitHeight];
    }
    if (self.labelContent.bottom+2>self.height) {
        self.labelContent.height = self.height - self.labelContent.y - PagePadding;
    }
}

@end
