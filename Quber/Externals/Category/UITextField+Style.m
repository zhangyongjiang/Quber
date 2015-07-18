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
//  UITextField+Style.m
//
//
//  Created by Kevin Zhang on 11/16/14.
//  Copyright (c) 2014 Kevin Zhang. All rights reserved.
//

#import "UITextField+Style.h"
#import "NSObject+Attach.h"
#import <objc/runtime.h>
#import "LanguageFile.h"

UITextField* gCurrentTextField;

@implementation UITextField (Style)
+ (void)load
{
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        method_exchangeImplementations(class_getInstanceMethod([UITextField class], @selector(setText_swizzle:)), class_getInstanceMethod([self class], @selector(setText:)));
        method_exchangeImplementations(class_getInstanceMethod([UITextField class], @selector(setPlaceholder_swizzle:)), class_getInstanceMethod([self class], @selector(setPlaceholder:)));
        method_exchangeImplementations(class_getInstanceMethod([UITextField class], @selector(initWithFrame_swizzle:)), class_getInstanceMethod([self class], @selector(initWithFrame:)));
    });
}

-(id)initWithFrame_swizzle:(CGRect)frame {
    self = [self initWithFrame_swizzle:frame];
    self.clearButtonMode = UITextFieldViewModeWhileEditing;
    return self;
}

-(void)setReadOnly:(BOOL)readOnly {
    [self attachObject:[NSNumber numberWithBool:readOnly] forKey:@"UITextField.readOnly"];
}

-(BOOL)readOnly {
    NSNumber* num = [self attachedObjectForKey:@"UITextField.readOnly"];
    if (!num || !num.boolValue) {
        return NO;
    }
    else
        return YES;
}


-(void)setText_swizzle:(NSString *)text {
    NSMutableDictionary* td = [[NSThread currentThread] threadDictionary];
    [td setObject:@"UITextField" forKey:@"UITextField"];
    [self setText_swizzle:text];
    [td removeObjectForKey:@"UITextField"];
}

-(void)setPlaceholder_swizzle:(NSString *)placeholder {
    NSString* translated = [LanguageFile translate:placeholder];
    [self setPlaceholder_swizzle:translated];
}

-(void) h1 {
    UIFont* font = self.font;
    font = [font fontWithSize:24];
    self.font = font;
}
-(void) h2 {
    UIFont* font = self.font;
    font = [font fontWithSize:17];
    self.font = font;
}
-(void) h3 {
    UIFont* font = self.font;
    font = [font fontWithSize:15];
    self.font = font;
}
-(void) h4 {
    UIFont* font = self.font;
    font = [font fontWithSize:14];
    self.font = font;
}
-(void) h5 {
    UIFont* font = self.font;
    font = [font fontWithSize:13];
    self.font = font;
}
-(void) book {
    self.font = [UIFont fontWithName:@"GothamRounded-Book" size: self.font.pointSize];
}
-(void) medium {
    self.font = [UIFont fontWithName:@"GothamRounded-Medium" size: self.font.pointSize];
}

-(void) white {
    self.textColor = [UIColor whiteColor];
}

-(void) black3 {
    self.textColor = [UIColor colorFromRGB:0x333333];
}

-(void) gray5 {
    self.textColor = [UIColor colorFromRGB:0x555555];
}

-(void) gray8 {
    self.textColor = [UIColor colorFromRGB:0x888888];
}

-(void) nsred {
    self.textColor = [UIColor colorFromRGB:0xdf1663];
}

-(void) nsdarkred {
    self.textColor = [UIColor colorFromRGB:0x4e0722];
}

-(void)styleContent {
    self.font = [UIFont fontWithName:@"GothamRounded-Book" size: 13];
    self.textColor = [UIColor colorFromRGB:0x505050];
}
@end

@implementation UITextFieldWithPadding

-(id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    self.padding = PagePadding;
    self.keyboardType = UIKeyboardTypeEmailAddress;
    
    UIButton* btn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 40, 0)];
    btn.clipsToBounds = YES;
    btn.backgroundColor = [UIColor grayColor];
    [btn setTitle:@"Hide Keyboard" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(textFieldClicked) forControlEvents:UIControlEventTouchUpInside];
    self.inputAccessoryView = btn;
    
    return self;
}

- (CGRect)textRectForBounds:(CGRect)bounds {
    return CGRectInset(bounds, self.padding, 0);
}

- (CGRect)editingRectForBounds:(CGRect)bounds {
    return CGRectInset(bounds, self.padding, 0);
}

-(void)setPlaceholder:(NSString *)placeholder {
    if (self.placeholderColor) {
        placeholder = [LanguageFile translate:placeholder];
        self.attributedPlaceholder = [[NSAttributedString alloc] initWithString:placeholder attributes:@{NSForegroundColorAttributeName: self.placeholderColor}];
    }
    else {
        [super setPlaceholder:placeholder];
    }
}

-(void)textFieldClicked {
    [self resignFirstResponder];
}

@end


@interface NSUITextView() <UITextViewDelegate>

@end


@implementation NSUITextView

-(id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    
    self.font = [UIFont fontWithName:@"GothamRounded-Book" size: 13];
    
    UIButton* btn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 40, 0)];
    btn.clipsToBounds = YES;
    btn.backgroundColor = [UIColor grayColor];
    [btn setTitle:@"Hide Keyboard" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(textViewClicked) forControlEvents:UIControlEventTouchUpInside];
    self.inputAccessoryView = btn;
    
    self.delegate = self;
    self.textColor = [UIColor lightGrayColor];
    self.text = self.placeholder;

    return self;
}

-(void)textViewClicked {
    [self resignFirstResponder];
}

- (void)textViewDidBeginEditing:(UITextView *)textView
{
    NSUITextView* nsview = (NSUITextView*)textView;
    if (!textView.text || [textView.text isEqualToString:nsview.placeholder]) {
        [nsview setRawText:@""];
        textView.textColor = [UIColor blackColor];
    }
    [textView becomeFirstResponder];
}

- (void)textViewDidEndEditing:(UITextView *)textView
{
    if ([textView.text isEqualToString:@""]) {
        textView.text = self.placeholder;
        textView.textColor = [UIColor lightGrayColor];
    }
    [textView resignFirstResponder];
}

-(NSString*)text {
    NSString* t = [super text];
    if ([t isEqualToString:self.placeholder]) {
        return nil;
    }
    return t;
}

-(void)setRawText:(NSString *)text {
    [super setText:text];
}

-(void)setText:(NSString *)text {
    if (!text || text.length == 0) {
        [super setText:self.placeholder];
        self.textColor = [UIColor lightGrayColor];
    }
    else {
        [super setText:text];
        self.textColor = [UIColor blackColor];
    }
}

-(void)setPlaceholder:(NSString *)placeholder {
    _placeholder = placeholder;
    NSString* t = [super text];
    if (!t || t.length == 0) {
        self.text = placeholder;
        self.textColor = [UIColor lightGrayColor];
    }
}
@end
