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
//  UITextField+Style.h
//
//
//  Created by Kevin Zhang on 11/16/14.
//  Copyright (c) 2014 Kevin Zhang. All rights reserved.
//

#import <UIKit/UIKit.h>

#define HideKeyboardViewHeight 30

extern UITextField* gCurrentTextField;

@interface UITextField (Style)

-(void) h1 ;
-(void) h2 ;
-(void) h3 ;
-(void) h4 ;
-(void) h5 ;
-(void) book ;
-(void) medium ;
-(void) black3 ;
-(void) gray5 ;
-(void) gray8 ;
-(void) nsred ;
-(void) nsdarkred ;
-(void) white ;
-(void)styleContent;

@property(assign,nonatomic)BOOL readOnly;

@end

@interface UITextFieldWithPadding : UITextField <UITextFieldDelegate>
@property(assign, nonatomic)CGFloat padding;
@property(assign, nonatomic)UIColor* placeholderColor;
@end

@interface NSUITextView : UITextView

@property(strong,nonatomic)NSString* placeholder;

@end
