//
//  NSButton.m
//
//
//  Created by Kevin Zhang on 11/18/14.
//  Copyright (c) 2014 Kevin Zhang. All rights reserved.
//

#import "NSButton.h"

@interface NSButton()


@end

@implementation NSButton

-(id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:(frame.size.width<0.0001 ? CGRectMake(PagePadding, 0, FullWidthExcludePadding, 44*[UIView scale]) : frame)];
    self.layer.cornerRadius = self.height/2.;
//    [self.layer setBorderColor:[[UIColor colorFromString:@"nsred"] CGColor]];
//    [self.layer setBorderWidth:2];
    [self book];
    [self setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
    [self setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
    self.backgroundColor = [UIColor mainColor];
    return self;
}

//-(void)setHighlighted:(BOOL)highlighted {
//    [super setHighlighted:highlighted];
//    if (highlighted) {
//        self.backgroundColor = [UIColor mainHighlightColor];
//    }
//    else {
//        self.backgroundColor = [UIColor mainColor];
//    }
//}

-(void)setHeight:(CGFloat)height {
    [super setHeight:height];
    self.layer.cornerRadius = height / 2.0;
}
@end


@implementation NSButtonLarge

-(id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:CGRectMake(0, 0, 300*[UIView scale], 40*[UIView scale])];
    [self setFontSize:17];
    return self;
}

@end


@implementation NSButtonSmall

-(id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:CGRectMake(0, 0, 300*[UIView scale], 30*[UIView scale])];
//    [self.layer setBorderWidth:1];
    [self setFontSize:12];
    return self;
}

@end


