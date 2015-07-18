/*
 * Licensed to the Apache Software Foundation (ASF) under one or more
 * contributor license agreements.  See the NOTICE file distributed with
 * this work for additional information regarding copyright ownership.
 * The ASF licenses this file to You under the Apache License, Version 2.0
 * (the "License"); you may not use this file except in compliance with
 * the License.  You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

//
//  UIView+Position.h
//
//  Created by Kevin Zhang on 10/27/14.
//  Copyright (c) 2014 Kevin Zhang. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol UIViewEventDelegate <NSObject>

-(void)handleEvent:(NSString*)name fromSource:(UIView*)view data:(NSObject*)data;

@end

@interface UIView (Position)
@property (assign, nonatomic)CGFloat height;
@property (assign, nonatomic)CGFloat width;
@property (assign, nonatomic)CGFloat x;
@property (assign, nonatomic)CGFloat y;
@property (assign, nonatomic)CGFloat bottom;
@property (assign, nonatomic)CGFloat right;
@property (assign, nonatomic)CGFloat xcenter;
@property (assign, nonatomic)CGFloat ycenter;

+ (CGFloat)scale;
+ (CGFloat)screenWidth;
+ (CGFloat)screenHeight;
+ (void)top2bottomWithMargin:(CGFloat)margin views:(UIView*)view,...;
+ (void)setLeftMargin:(CGFloat)margin views:(UIView*)view,...;
+ (void)hcenterViews:(UIView*)view,...;
+ (void)vcenterViews:(UIView*)view,...;
+ (CGRect)rectForViews:(NSArray *)views;
+ (UIView *)groupOfViews:(NSArray *)views;
+ (UIView*)maskViews:(NSArray *)views withBorderWidth:(CGFloat)width borderColor:(UIColor*)color radius:(CGFloat)radius;

- (id)initWithScaledFrame:(CGRect)frame;
- (void)setScaledWidth:(CGFloat)width;
- (void)setScaledHeight:(CGFloat)height;
- (void)setScaledX:(CGFloat)x;
- (void)setScaledY:(CGFloat)y;

- (void)belowView:(UIView *)v withMargin:(CGFloat) margin;
- (void)aboveView:(UIView *)v withMargin:(CGFloat) margin;
- (void)leftOfView:(UIView *)v withMargin:(CGFloat) margin;
- (void)rightOfView:(UIView *)v withMargin:(CGFloat) margin;

- (void)alignLeftWithView:(UIView*)view;
- (void)alignRightWithView:(UIView*)view;
- (void)alignTopWithView:(UIView*)view;
- (void)alignBottomWithView:(UIView*)view ;

- (void)alignParentLeftWithMarghin:(CGFloat) margin;
- (void)alignParentRightWithMarghin:(CGFloat) margin;
- (void)alignParentTopWithMarghin:(CGFloat) margin;
- (void)alignParentBottomWithMarghin:(CGFloat) margin;

- (void)fitParentWidthWithMargin:(CGFloat) margin;
- (void)fitParentHeightWithMargin:(CGFloat) margin;
- (void)fitParentWithMargin:(CGFloat) margin;
- (void)centerInParent;
- (void)hcenterInParent;
- (void)vcenterInParent;
- (void)extendToParentRightWithMargin:(CGFloat) margin;
- (void)extendToParentLeftWithMargin:(CGFloat) margin;
- (void)extendToParentBottomWithMargin:(CGFloat) margin;
- (void)hcenterSubviews;
- (void)vcenterSubviews;
- (void)vcenterMargin:(CGFloat)margin forSubviews:(UIView*)view,...;
- (void)hcenterMargin:(CGFloat)margin forSubviews:(UIView *)view, ...;
- (void)vcenterMargin:(CGFloat)margin forSubviewArray:(NSArray*)view;
- (void)hcenterMargin:(CGFloat)margin forSubviewArray:(NSArray*)view;
- (void)hcenterSubviewArray:(NSArray*)view;

- (void)valignWith:(UIView *)view;
- (void)halignWith:(UIView *)view;

- (void) movetoNextSubview;
- (CGRect)rectForSubviews;
- (void)addSubviewV:(UIView *)view margin:(CGFloat)margin;
- (void)addSubviewH:(UIView *)view margin:(CGFloat)margin;
- (void)addSubviews:(UIView*)view,...;

- (void)setBackgroundImage:(NSString*)name;
- (BOOL)isSameViewOrChildOf:(UIView*)superView;
- (void)addTarget:(id)target action:(SEL)action;
- (void)addEventHandler:(void(^)(void))handler;

-(void) setRoundingCorners:(UIRectCorner)corners withRadius:(CGFloat)radius;
-(void) setTopCornersWithRadius:(CGFloat)radius;
-(void) setBottomCornersWithRadius:(CGFloat)radius;

- (void) setEventDelegate:(id<UIViewEventDelegate>) delegate;
- (void) fireEvent:(NSString*)name data:(NSObject*)data;

- (UIImage *)toImage;
@end
