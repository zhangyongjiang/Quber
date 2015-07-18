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
//  Created by Kevin Zhang on 10/24/14.
//

#import <UIKit/UIKit.h>

@interface UIView (Autolayout)

-(void)autoLayout:(UIView*)subview width:(CGFloat)width height:(CGFloat)height;
-(void)autoLayout:(UIView*)subview width:(CGFloat)width;
-(void)autoLayout:(UIView*)subview height:(CGFloat)height;
-(void)autoLayout:(UIView*)subview widthPercent:(CGFloat)percent;
-(void)autoLayout:(UIView*)subview heightPercent:(CGFloat)precent;
-(void)autoLayout:(UIView*)subview widthPercentOfParentHeight:(CGFloat)percent;
-(void)autoLayout:(UIView*)subview heightPercentOfParentWidth:(CGFloat)percent;

-(void)autoLayout:(UIView*)subview marginBottom:(CGFloat)margin;
-(void)autoLayout:(UIView*)subview marginRight:(CGFloat)margin;
-(void)autoLayout:(UIView*)subview marginLeft:(CGFloat)margin;
-(void)autoLayout:(UIView*)subview marginTop:(CGFloat)margin;

-(void)autoLayout:(UIView*)subview percentTop:(CGFloat)percent;

-(void)autoLayout:(UIView*)subview belowView:(UIView*)sibling margin:(CGFloat)margin;
-(void)autoLayout:(UIView*)subview onTheRightOfView:(UIView*)sibling margin:(CGFloat)margin;
-(void)autoLayout:(UIView*)subview aboveView:(UIView*)sibling margin:(CGFloat)margin;
-(void)autoLayout:(UIView*)subview onTheLeftOfView:(UIView*)sibling margin:(CGFloat)margin;

-(void)autoLayout:(UIView*)subview xFlow:(NSArray*)subviews margin:(CGFloat)margin;
-(void)autoLayout:(UIView*)subview xFlow:(NSArray*)subviews margin:(CGFloat)margin firstMargin:(CGFloat)firstMargin;
-(void)autoLayout:(UIView*)subview yFlow:(NSArray*)subviews margin:(CGFloat)margin;
-(void)autoLayout:(UIView*)subview yFlow:(NSArray*)subviews margin:(CGFloat)margin firstMargin:(CGFloat)firstMargin;

-(void)autoLayoutSubviews:(NSArray*)subviews marginBottom:(CGFloat)margin;
-(void)autoLayoutSubviews:(NSArray*)subviews marginRight:(CGFloat)margin;
-(void)autoLayoutSubviews:(NSArray*)subviews marginLeft:(CGFloat)margin;
-(void)autoLayoutSubviews:(NSArray*)subviews marginTop:(CGFloat)margin;
-(void)autoLayoutSubviews:(NSArray*)subviews belowView:(UIView*)sibling margin:(CGFloat)margin;
-(void)autoLayoutSubviews:(NSArray*)subviews onTheRightOfView:(UIView*)sibling margin:(CGFloat)margin;
-(void)autoLayoutSubviews:(NSArray*)subviews aboveView:(UIView*)sibling margin:(CGFloat)margin;
-(void)autoLayoutSubviews:(NSArray*)subviews onTheLeftOfView:(UIView*)sibling margin:(CGFloat)margin;
-(void)autoLayoutXCenter:(NSArray*)subviews;
-(void)autoLayoutYCenter:(NSArray*)subviews;
-(void)autoLayoutXCenterFlow:(NSArray*)subviews margin:(CGFloat)margin;
-(void)autoLayoutYCenterFlow:(NSArray*)subviews margin:(CGFloat)margin;
-(void)autoLayoutXFlow:(NSArray*)subviews margin:(CGFloat)margin left:(CGFloat)marginLeft;
-(void)autoLayoutYFlow:(NSArray*)subviews margin:(CGFloat)margin top:(CGFloat)marginTop;

-(CGRect)rectOfSubviews;
-(CGRect)topSpaceRect;
-(CGRect)leftSpaceRect;
-(CGRect)bottomSpaceRect;
-(CGRect)rightSpaceRect;
-(UIView*)fillTop;
-(UIView*)fillLeft;
-(UIView*)fillRight;
-(UIView*)fillBottom;

-(NSString*)nameOfView;
-(void) movetoNextSubview;
@end
