//
//  KDRatingView.h
//  KDRatingView
//
//  Created by Kedar Desai on 04/03/14.
//  Copyright (c) 2014 Kedar Desai. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KDRatingView : UIView
{
    UIImageView *star1, *star2, *star3, *star4, *star5;
}

@property(assign,nonatomic)NSUInteger totalValue;
@property(assign,nonatomic)CGFloat ratingValue;

-(id)initWithFrame:(CGRect)frame andTotalValue:(NSUInteger)totalValue;

@end
