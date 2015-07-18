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

#import "UILabel+Cat.h"
#import "NSObject+Attach.h"
#import "NSObject+Event.h"
#import <objc/runtime.h>
#import "LanguageFile.h"

@implementation UILabel (Cat)

+ (void)load
{
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        method_exchangeImplementations(class_getInstanceMethod([UILabel class], @selector(setText_swizzle:)), class_getInstanceMethod([self class], @selector(setText:)));
        method_exchangeImplementations(class_getInstanceMethod([UILabel class], @selector(setAttributedText_swizzle:)), class_getInstanceMethod([self class], @selector(setAttributedText:)));
        method_exchangeImplementations(class_getInstanceMethod([UILabel class], @selector(drawTextInRect_swizzle:)), class_getInstanceMethod([self class], @selector(drawTextInRect:)));
    });
}

-(void)setAttributedText_swizzle:(NSAttributedString *)attributedText {
    NSMutableAttributedString *newString = [[NSMutableAttributedString alloc] initWithAttributedString:attributedText];
    [LanguageFile translateMutableString:newString.mutableString];
    [self setAttributedText_swizzle:newString];
    if(self.fit) {
        [self sizeToFit];
    }
    
    if (self.vcenter) {
        [self vcenter];
    }
}

-(NSString*)eventName {
    NSString* name = [super eventName];
    return name ? name : self.text;
}

-(void) h1 {
    self.font = [UIFont fontWithName:@"GothamRounded-Book" size: 20];
    self.textColor = [UIColor blackColor];
}
-(void) h2 {
    self.font = [UIFont fontWithName:@"GothamRounded-Book" size: 17];
    self.textColor = [UIColor colorFromRGB:0x303030];
}
-(void) h3 {
    self.font = [UIFont fontWithName:@"GothamRounded-Medium" size: 13];
    self.textColor = [UIColor blackColor];
}
-(void) h4 {
    self.font = [UIFont fontWithName:@"GothamRounded-Book" size: 13];
    self.textColor = [UIColor blackColor];
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

-(void) black0 {
    self.textColor = [UIColor colorFromRGB:0];
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

-(void)setText_swizzle:(NSString *)text {
//    if (text) {
//        self.nontranslatedText = text;
//    }
    NSMutableDictionary* td = [[NSThread currentThread] threadDictionary];
    if ([td objectForKey:@"UITextField"]) {
        [self setText_swizzle:text];
    }
    else {
        NSString* translated = text;
        translated = [LanguageFile translate:text];
        if (self.uppercase) {
            [self setText_swizzle:[translated uppercaseString]];
        }
        else {
            [self setText_swizzle:translated];
        }
    }
    
    if(self.fit) {
        [self sizeToFit];
    }
    
    if (self.vcenter) {
        [self vcenter];
    }
}

-(BOOL)uppercase {
    NSNumber* num = [self attachedObjectForKey:@"UILabel.uppercase"];
    return num ? num.boolValue : NO;
}

-(void)setUppercase:(BOOL)uppercase {
    [self attachObject:[NSNumber numberWithBool:uppercase] forKey:@"UILabel.uppercase"];
}

-(BOOL)vcenter {
    NSNumber* num = [self attachedObjectForKey:@"UILabel.vcenter"];
    return num ? num.boolValue : NO;
}

-(void)setVcenter:(BOOL)vcenter {
    [self attachObject:[NSNumber numberWithBool:vcenter] forKey:@"UILabel.vcenter"];
}

-(BOOL)fit {
    NSNumber* num = [self attachedObjectForKey:@"UILabel.fit"];
    return num ? num.boolValue : NO;
}

-(void)setFit:(BOOL)fit {
    [self attachObject:[NSNumber numberWithBool:fit] forKey:@"UILabel.fit"];
}

-(void)setPaddingLeft:(CGFloat)paddingLeft {
    [self attachObject:[NSNumber numberWithFloat:paddingLeft] forKey:@"UILable-PaddingLeft"];
}

-(CGFloat)paddingLeft {
    NSNumber* value = [self attachedObjectForKey:@"UILable-PaddingLeft"];
    if (value) {
        return value.floatValue;
    } else {
        return 0;
    }
}

-(void)setPaddingTop:(CGFloat)paddingTop {
    [self attachObject:[NSNumber numberWithFloat:paddingTop] forKey:@"UILable-PaddingTop"];
}

-(CGFloat)paddingTop {
    NSNumber* value = [self attachedObjectForKey:@"UILable-PaddingTop"];
    if (value) {
        return value.floatValue;
    } else {
        return 0;
    }
}

- (void)drawTextInRect_swizzle:(CGRect)rect {
    CGFloat paddingLeft = self.paddingLeft;
    CGFloat paddingTop = self.paddingTop;
    UIEdgeInsets insets = {paddingTop, paddingLeft, 0, paddingLeft};
    [self drawTextInRect_swizzle:UIEdgeInsetsInsetRect(rect, insets)];
}

-(void)fitHeight {
    CGSize size = [self sizeThatFits:CGSizeMake(self.width, CGFLOAT_MAX)];
    self.height = size.height;
}

+ (CGSize)heightForText:(NSString *)text havingWidth:(CGFloat)widthValue andFont:(UIFont *)font {
    CGSize size = CGSizeZero;
    if (text) {
        //iOS 7
        NSMutableParagraphStyle *paragrahStyle = [[NSMutableParagraphStyle alloc] init];
        [paragrahStyle setLineSpacing:4];

        CGRect frame = [text boundingRectWithSize:CGSizeMake(widthValue, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{ NSFontAttributeName:font, NSParagraphStyleAttributeName:paragrahStyle } context:nil];
        size = CGSizeMake(frame.size.width, frame.size.height + 1);
    }
    return size;
}

-(void)styleCounter {
    self.font = [UIFont fontWithName:@"GothamRounded-Book" size: 12];
    self.textColor = [UIColor colorFromRGB:0x303030];
}

-(void)styleOriginalPrice {
    self.font = [UIFont fontWithName:@"GothamRounded-Book" size: 12];
    self.textColor = [UIColor colorFromRGB:0x999999];
}

-(void)styleSalePrice {
    self.font = [UIFont fontWithName:@"GothamRounded-Book" size: 13];
    self.textColor = [UIColor colorFromString:@"nsred"];
}

-(void)styleSalePriceBig {
    self.font = [UIFont fontWithName:@"GothamRounded-Book" size: 17];
    self.textColor = [UIColor colorFromString:@"nsred"];
}

-(void)styleContentBold {
    self.font = [UIFont fontWithName:@"GothamRounded-Medium" size: 13];
    self.textColor = [UIColor blackColor];
}

-(void)styleContent {
    self.font = [UIFont fontWithName:@"GothamRounded-Book" size: 13];
    self.textColor = [UIColor colorFromRGB:0x505050];
}

-(void)styleTime {
    self.font = [UIFont fontWithName:@"GothamRounded-Book" size: 11];
    self.textColor = [UIColor colorFromRGB:0x808080];
}

-(void)styleName {
    self.font = [UIFont fontWithName:@"GothamRounded-Medium" size: 21];
    self.textColor = [UIColor colorFromRGB:0xffffff];
}

-(void)styleNameSmall {
    self.font = [UIFont fontWithName:@"GothamRounded-Book" size: 12];
    self.textColor = [UIColor colorFromRGB:0x000000];
}

-(void)styleMenuItem {
    self.font = [UIFont fontWithName:@"GothamRounded-Book" size: 15];
    self.textColor = [UIColor colorFromRGB:0x000000];
}

-(void)styleTableViewSection {
    self.font = [UIFont fontWithName:@"GothamRounded-Book" size: 13];
    self.textColor = [UIColor colorFromRGB:0x505050];
}

-(void)styleTableViewRowContent {
    self.font = [UIFont fontWithName:@"GothamRounded-Book" size: 14];
    self.textColor = [UIColor colorFromRGB:0x303030];
}

-(void)styleTableViewRowInactiveContent {
    self.font = [UIFont fontWithName:@"GothamRounded-Book" size: 15];
    self.textColor = [UIColor colorFromRGB:0x808080];
}

-(void)styleTableViewRowTag {
    self.font = [UIFont fontWithName:@"GothamRounded-Book" size: 12];
    self.textColor = [UIColor colorFromRGB:0x808080];
}

-(void)styleTableViewRowTagWhite {
    self.font = [UIFont fontWithName:@"GothamRounded-Book" size: 12];
    self.textColor = [UIColor whiteColor];
}

-(void)styleSmallTag {
    self.font = [UIFont fontWithName:@"GothamRounded-Book" size: 11];
    self.textColor = [UIColor whiteColor];
}

-(void)styleTableViewRowLabel {
    self.font = [UIFont fontWithName:@"GothamRounded-Medium" size: 14];
    self.textColor = [UIColor colorFromRGB:0x000000];
}

-(void)setAttributedText:(NSString *)text hightlight:(NSString *)substr withColor:(UIColor *)color {
    NSRange range = [text rangeOfString:substr];
    NSMutableAttributedString * string = [[NSMutableAttributedString alloc] initWithString:text];
    [string addAttribute:NSForegroundColorAttributeName value:color range:range];
    self.attributedText = string;
}

-(void)setText:(NSString *)text withLineSpacing:(CGFloat)lineSpacing {
    if(!text)return;
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc]initWithString:text];
    NSMutableParagraphStyle *paragrahStyle = [[NSMutableParagraphStyle alloc] init];
    [paragrahStyle setLineSpacing:4];
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragrahStyle range:NSMakeRange(0, [text length])];
    self.attributedText = attributedString;
}

-(void)setText:(NSString *)text withLineSpacing:(CGFloat)lineSpacing andAlignment:(NSTextAlignment)alignment{
    if(!text)return;
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc]initWithString:text];
    NSMutableParagraphStyle *paragrahStyle = [[NSMutableParagraphStyle alloc] init];
    [paragrahStyle setLineSpacing:4];
    [paragrahStyle setAlignment:alignment];
    [paragrahStyle setLineBreakMode:NSLineBreakByTruncatingTail];
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragrahStyle range:NSMakeRange(0, [text length])];
    self.attributedText = attributedString;
}
@end
