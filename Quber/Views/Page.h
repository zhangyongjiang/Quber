//
//  Page.h
//
//
//  Created by Kevin Zhang on 11/16/14.
//  Copyright (c) 2014 Kevin Zhang. All rights reserved.
//

#import "BaseView.h"
#import "FitLabel.h"
#import "NSButton.h"

@interface Page : BaseView

-(void)setEmptyPageText:(NSString*)text;
-(void)setEmptyPageView:(UIView*)view;
-(void)reload;
-(void)beginRefresh;
-(void)endRefresh;
-(void)show:(NSString*)name width:(CGFloat)imgw height:(CGFloat)imgh x:(CGFloat)x y:(CGFloat)y  toView:(UIView*)view;

-(NSButton*)createActionButton:(NSString*)title image:(NSString*)imgname bgcolr:(UIColor*)color;

@end




