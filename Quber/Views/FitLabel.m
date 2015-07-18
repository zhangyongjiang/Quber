//
//  FitLabel.m
//
//  Created by Kevin Zhang on 10/24/14.
//

#import "FitLabel.h"

@implementation FitLabel

-(id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    return self;
}

-(void)setText:(NSString *)text
{
    [super setText:text];
    [self sizeToFit];
}

-(void)setFont:(UIFont *)font
{
    [super setFont:font];
    [self sizeToFit];
}

-(void)setAttributedText:(NSAttributedString *)attributedText {
    [super setAttributedText:attributedText];
    [self sizeToFit];
}
@end
