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
//  UIButton+Style.h
//
//
//  Created by Kevin Zhang on 11/19/14.
//  Copyright (c) 2014 Kevin Zhang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (Style)

-(void) h1 ;
-(void) h2 ;
-(void) h3 ;
-(void) h4 ;
-(void) h5 ;
-(void) book ;
-(void) medium ;
-(void) black0 ;
-(void) black3 ;
-(void) gray5 ;
-(void) gray8 ;
-(void) nsred ;
-(void) nsdarkred ;
-(void) white ;
-(void) setFontSize:(CGFloat)size;
-(void) setTitle:(NSString*)title;

- (void)centerVerticallyWithPadding:(float)padding;
- (void)centerVertically;

-(void)styleCounter;
-(void)styleOriginalPrice;
-(void)styleSalePrice;
-(void)styleSalePriceBig;
-(void)styleContentBold;
-(void)styleContent;
-(void)styleTime;
-(void)styleName;
-(void)styleMenuItem;
-(void)styleTableViewSection;
-(void)styleTableViewRowContent;
-(void)styleTableViewRowInactiveContent;
-(void)styleTableViewRowTag;
-(void)styleTableViewRowLabel;
-(void)styleSmallTag;
-(void)styleBook17;


@end
