//
//  KDRatingView.m
//  KDRatingView
//
//  Created by Kedar Desai on 04/03/14.
//  Copyright (c) 2014 Kedar Desai. All rights reserved.
//

#import "KDRatingView.h"

@interface KDRatingView()

@property(strong,nonatomic)NSMutableArray* views;

@end

@implementation KDRatingView

- (id)initWithFrame:(CGRect)frame andTotalValue:(NSUInteger)totalValue
{
    self = [super initWithFrame:frame];
    if (self) {
        self.totalValue = totalValue;
        self.ratingValue = 0;
        [self addTarget:self action:@selector(ratingClicked:)];
    }
    return self;
}

-(void)ratingClicked:(UITapGestureRecognizer*)ges {
    CGPoint location = [ges locationInView:ges.view];
    CGFloat unitWidth = self.width / self.totalValue;
    [self setRatingValue:location.x/unitWidth];
}

-(void)setRatingValue:(CGFloat)ratingValue {
    for (UIView* child in self.subviews) {
        [child removeFromSuperview];
    }
    
    _ratingValue = 0;
    
    NSUInteger xPos = 0;
    double tempRatingValue = ratingValue;
    for (NSUInteger currentStar=0; currentStar<self.totalValue; currentStar++) { // Looping for each star(imageView) in the KDRatingView
        
        UIImageView *starImageView = [[UIImageView alloc] initWithFrame:CGRectMake(xPos, 0, self.frame.size.width/self.totalValue, self.frame.size.height)];
        
        if (tempRatingValue-1>=0) {
            tempRatingValue--;
            // place one complete star
            [starImageView setImage:[UIImage imageNamed:@"full-star"]];
            _ratingValue += 1;
        } else {
            if ((tempRatingValue>=0)&&(tempRatingValue<0.25)) {
                [starImageView setImage:[UIImage imageNamed:@"grey-star"]];
                
            } else if ((tempRatingValue>=0.25)&&(tempRatingValue<0.50)) {
                [starImageView setImage:[UIImage imageNamed:@"half-star"]];
                _ratingValue += 0.5;
            } else  {
                [starImageView setImage:[UIImage imageNamed:@"full-star"]];
                _ratingValue += 1;
            }
            
            tempRatingValue=0;
        }
        
        // set tag starImageView which will allow to identify and differentiate it individually in calling class.
        // Add starImageView to view as a subView
        starImageView.tag = currentStar;
        [self addSubview:starImageView];
        
        // calculate new xPos and yPos
        xPos = xPos + starImageView.frame.size.width;
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
