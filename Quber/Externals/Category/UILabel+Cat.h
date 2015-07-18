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
//
//
//  Created by Kevin Zhang on 11/16/14.
//  Copyright (c) 2014 Kevin Zhang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (Cat)

@property(assign, nonatomic)BOOL uppercase;
@property(assign, nonatomic)BOOL vcenter;
@property(assign, nonatomic)BOOL fit;
@property(assign, nonatomic)CGFloat paddingLeft;
@property(assign, nonatomic)CGFloat paddingTop;

-(void) h1 ;
-(void) h2 ;
-(void) h3 ;
-(void) h4 ;
-(void) book ;
-(void) medium ;
-(void) black0 ;
-(void) black3 ;
-(void) gray5 ;
-(void) gray8 ;
-(void) nsred ;
-(void) nsdarkred ;
-(void) white ;
-(void) fitHeight;
-(void) setAttributedText:(NSString*)text hightlight:(NSString*)substr withColor:(UIColor*)color;

-(void) styleCounter;
-(void) styleOriginalPrice;
-(void) styleSalePrice;
-(void) styleSalePriceBig;
-(void) styleContentBold;
-(void) styleContent;
-(void) styleTime;
-(void) styleName;
-(void) styleMenuItem;
-(void) styleTableViewSection;
-(void) styleTableViewRowContent;
-(void) styleTableViewRowInactiveContent;
-(void) styleTableViewRowTag;
-(void)styleTableViewRowLabel;
-(void)styleTableViewRowTagWhite;
-(void)styleNameSmall;
-(void)styleSmallTag;

- (void)setText:(NSString *)text withLineSpacing:(CGFloat)lineSpacing;
-(void)setText:(NSString *)text withLineSpacing:(CGFloat)lineSpacing andAlignment:(NSTextAlignment)alignment;

+ (CGSize)heightForText:(NSString *)text havingWidth:(CGFloat)widthValue andFont:(UIFont *)font;


@end
