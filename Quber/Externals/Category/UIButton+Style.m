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
//  UIButton+Style.m
//
//
//  Created by Kevin Zhang on 11/19/14.
//  Copyright (c) 2014 Kevin Zhang. All rights reserved.
//

#import "UIButton+Style.h"

@implementation UIButton (Style)

-(void) h1 {
    UIFont* font = self.titleLabel.font;
    font = [font fontWithSize:24];   
    self.titleLabel.font = font;
}
-(void) h2 {
    UIFont* font = self.titleLabel.font;
    font = [font fontWithSize:20];
    self.titleLabel.font = font;
}
-(void) h3 {
    UIFont* font = self.titleLabel.font;
    font = [font fontWithSize:15];
    self.titleLabel.font = font;
}
-(void) h4 {
    UIFont* font = self.titleLabel.font;
    font = [font fontWithSize:14];
    self.titleLabel.font = font;
}
-(void) h5 {
    UIFont* font = self.titleLabel.font;
    font = [font fontWithSize:13];
    self.titleLabel.font = font;
}
-(void) book {
    UIFont* font = [UIFont fontWithName:@"GothamRounded-Book" size: self.titleLabel.font.pointSize];
    self.titleLabel.font = font;
}
-(void) medium {
    self.titleLabel.font = [UIFont fontWithName:@"GothamRounded-Medium" size: self.titleLabel.font.pointSize];
}

-(void) white {
    [self setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
}

-(void) black0 {
    [self setTitleColor:[UIColor colorFromRGB:0] forState:UIControlStateNormal];
}

-(void) black3 {
    [self setTitleColor:[UIColor colorFromRGB:0x333333] forState:UIControlStateNormal];
}

-(void) gray5 {
    [self setTitleColor:[UIColor colorFromRGB:0x555555] forState:UIControlStateNormal];
}

-(void) gray8 {
    [self setTitleColor:[UIColor colorFromRGB:0x888888] forState:UIControlStateNormal];
}

-(void) nsred {
    [self setTitleColor:[UIColor colorFromRGB:0xdf1663] forState:UIControlStateNormal];
}

-(void) nsdarkred {
    [self setTitleColor:[UIColor colorFromRGB:0x4e0722] forState:UIControlStateNormal];
}

-(void)styleSmallTag {
    self.titleLabel.font = [UIFont fontWithName:@"GothamRounded-Book" size: 10];
    [self setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
}

-(void)styleCounter {
    self.titleLabel.font = [UIFont fontWithName:@"GothamRounded-Book" size: 12];
    [self setTitleColor:[UIColor colorFromRGB:0x303030] forState:UIControlStateNormal];
}

-(void)styleOriginalPrice {
    self.titleLabel.font = [UIFont fontWithName:@"GothamRounded-Book" size: 12];
    [self setTitleColor:[UIColor colorFromRGB:0x999999] forState:UIControlStateNormal];
}

-(void)styleSalePrice {
    self.titleLabel.font = [UIFont fontWithName:@"GothamRounded-Medium" size: 12];
    [self setTitleColor:[UIColor colorFromString:@"nsred"] forState:UIControlStateNormal];
}

-(void)styleSalePriceBig {
    self.titleLabel.font = [UIFont fontWithName:@"GothamRounded-Book" size: 15];
    [self setTitleColor:[UIColor colorFromString:@"nsred"] forState:UIControlStateNormal];
}

-(void)styleContentBold {
    self.titleLabel.font = [UIFont fontWithName:@"GothamRounded-Medium" size: 13];
    [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
}

-(void)styleContent {
    self.titleLabel.font = [UIFont fontWithName:@"GothamRounded-Book" size: 13];
    [self setTitleColor:[UIColor colorFromRGB:0x505050] forState:UIControlStateNormal];
}

-(void)styleTime {
    self.titleLabel.font = [UIFont fontWithName:@"GothamRounded-Book" size: 11];
    [self setTitleColor:[UIColor colorFromRGB:0x808080] forState:UIControlStateNormal];
}

-(void)styleName {
    self.titleLabel.font = [UIFont fontWithName:@"GothamRounded-Medium" size: 17];
    [self setTitleColor:[UIColor colorFromRGB:0xffffff] forState:UIControlStateNormal];
}

-(void)styleBook17 {
    self.titleLabel.font = [UIFont fontWithName:@"GothamRounded-Book" size: 17];
    [self setTitleColor:[UIColor colorFromRGB:0xffffff] forState:UIControlStateNormal];
}

-(void)styleMenuItem {
    self.titleLabel.font = [UIFont fontWithName:@"GothamRounded-Book" size: 15];
    [self setTitleColor:[UIColor colorFromRGB:0xffffff] forState:UIControlStateNormal];
}

-(void)styleTableViewSection {
    self.titleLabel.font = [UIFont fontWithName:@"GothamRounded-Book" size: 13];
    [self setTitleColor:[UIColor colorFromRGB:0x505050] forState:UIControlStateNormal];
}

-(void)styleTableViewRowContent {
    self.titleLabel.font = [UIFont fontWithName:@"GothamRounded-Book" size: 14];
    [self setTitleColor:[UIColor colorFromRGB:0x303030] forState:UIControlStateNormal];
}

-(void)styleTableViewRowInactiveContent {
    self.titleLabel.font = [UIFont fontWithName:@"GothamRounded-Book" size: 15];
    [self setTitleColor:[UIColor colorFromRGB:0x808080] forState:UIControlStateNormal];
}

-(void)styleTableViewRowTag {
    self.titleLabel.font = [UIFont fontWithName:@"GothamRounded-Book" size: 12];
    [self setTitleColor:[UIColor colorFromRGB:0x808080] forState:UIControlStateNormal];
}

-(void)styleTableViewRowLabel {
    self.titleLabel.font = [UIFont fontWithName:@"GothamRounded-Medium" size: 14];
    [self setTitleColor:[UIColor colorFromRGB:0x000000] forState:UIControlStateNormal];
}

-(void)setFontSize:(CGFloat)size {
    UIFont* font = self.titleLabel.font;
    font = [font fontWithSize:size];
    self.titleLabel.font = font;
}

-(NSString*)eventName {
    NSString* name = [super eventName];
    return name ? name : self.currentTitle;
}

-(void)setTitle:(NSString *)title {
    [self setTitle:title forState:UIControlStateNormal];
}

- (void)centerVerticallyWithPadding:(float)padding {
    CGSize imageSize = self.imageView.frame.size;
    CGSize titleSize = self.titleLabel.frame.size;
    
    CGFloat totalHeight = (imageSize.height + titleSize.height + padding);
    
    self.imageEdgeInsets = UIEdgeInsetsMake(- (totalHeight - imageSize.height),
                                            0.0f,
                                            0.0f,
                                            - titleSize.width);
    
    self.titleEdgeInsets = UIEdgeInsetsMake(0.0f,
                                            - imageSize.width,
                                            - (totalHeight - titleSize.height),
                                            0.0f);
    
}

- (void)centerVertically {
    const CGFloat kDefaultPadding = 6.0f;
    
    [self centerVerticallyWithPadding:kDefaultPadding];
}
@end
