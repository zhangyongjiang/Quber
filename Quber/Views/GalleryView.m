//
//  GalleryView.m
//
//
//  Created by Kevin Zhang on 1/1/15.
//  Copyright (c) 2015 Kevin Zhang. All rights reserved.
//

#import "GalleryView.h"
#import "UIImage+ImageEffects.h"

@interface GalleryView()

@property(strong,nonatomic)NSMutableArray* imgViews;

@end

@implementation GalleryView

-(id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    
    self.scrollView = [[UIScrollView alloc] initWithFrame:frame];
    [self addSubview:self.scrollView];
    self.scrollView.pagingEnabled = true;
    self.scrollView.scrollsToTop = false;
    self.scrollView.showsHorizontalScrollIndicator = false;
    self.scrollView.showsVerticalScrollIndicator = false;
    self.scrollView.delegate = self;
    
    self.pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, frame.size.height*0.8, frame.size.width, 50*[UIView scale])];
    self.pageControl.pageIndicatorTintColor = [UIColor grayColor];
    self.pageControl.currentPageIndicatorTintColor = [UIColor colorFromString:@"nsred"];

    [self addSubview:self.pageControl];
    
    return self;
}

-(void)setImgs:(NSArray *)imgs {
    _imgs = imgs;
    self.scrollView.contentSize = CGSizeMake(self.width * imgs.count, self.height);
    for (UIView* imgView in self.imgViews) {
        [imgView removeFromSuperview];
    }
    self.imgViews = [[NSMutableArray alloc] init];
    for (int i=0; i<imgs.count; i++) {
        CGFloat x = i * self.width;
        UIImageView* imgView = [[UIImageView alloc] initWithFrame:CGRectMake(x, 0, self.width, self.height)];
        imgView.clipsToBounds = YES;
        [self.imgViews addObject:imgView];
        imgView.contentMode = UIViewContentModeScaleAspectFill;
        __weak id weakSelf = self;
        [imgView setImageWithPath:[self.imgs objectAtIndex:i] placeholderImage:nil success:^(UIImage *image, UIImageView* view) {
            GalleryView* s = (GalleryView*)weakSelf;
            if (s.tintColor) {
                UIImage* newImg = [image applyBlurWithRadius:5 tintColor:s.tintColor saturationDeltaFactor:1.8 maskImage:nil];
                view.image = newImg;
            }
        }];
        [self.scrollView addSubview:imgView];
        [imgView addTarget:self action:@selector(imgClicked:)];
    }
    [self showPage:0];
    
    self.pageControl.numberOfPages = imgs.count;
    [self bringSubviewToFront:self.pageControl];
    if (imgs.count<2) {
        self.pageControl.hidden = YES;
    }
}

-(void)imgClicked:(UIGestureRecognizer *)gestureRecognizer {
//    UIImageView* view = gestureRecognizer.view;
//    ImageViewController* controller = [[ImageViewController alloc] init];
//    controller.image = view.image;
//    [[NSNotificationCenter defaultCenter] presentControllerNotification:controller fromView:self];
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView {
    // disable vertical scroll
    [scrollView setContentOffset: CGPointMake(scrollView.contentOffset.x, 0)];
    
    CGFloat pageWidth = self.scrollView.frame.size.width;
    int page = floor((self.scrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
    [self showPage:page];
}

-(void)showPage:(int)index {
    if (index<0 || index >= self.imgs.count) {
        return;
    }
    self.pageControl.currentPage = index;
}
@end
