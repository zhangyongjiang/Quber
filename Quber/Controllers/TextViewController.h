//
//  TextViewController.h
//
//
//  Created by Kevin Zhang on 2/17/15.
//  Copyright (c) 2015 Kevin Zhang. All rights reserved.
//

#import "BaseViewController.h"

@interface TextViewController : BaseViewController

@property(strong,nonatomic)NSString* text;
@property(strong,nonatomic)NSString* imgPath;
@property(strong,nonatomic)UIScrollView* scrollView;

+(BOOL)isHtmlString:(NSString*)str;

@end
