//
//  GalleryView.h
//
//
//  Created by Kevin Zhang on 1/1/15.
//  Copyright (c) 2015 Kevin Zhang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GalleryView : UIView <UIScrollViewDelegate>

@property(strong,nonatomic)UIScrollView* scrollView;
@property(strong,nonatomic)UIPageControl* pageControl;
@property(strong,nonatomic)UIColor* tintColor;

@property(strong,nonatomic)NSArray* imgs;

-(id)initWithFrame:(CGRect)frame;

@end
