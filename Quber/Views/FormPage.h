//
//  FormPage.h
//
//
//  Created by Kevin Zhang on 1/6/15.
//  Copyright (c) 2015 Kevin Zhang. All rights reserved.
//

#import "Page.h"

#define FieldHeaderMargin   14*[UIView scale]

@interface FormPage : Page

@property(strong, nonatomic)UIScrollView* scrollView;
@property(strong, nonatomic)FitLabel* headerLabel;

-(UIView*)maskViews:(NSArray*) views;

@end
