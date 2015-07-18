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
//  UIImage+Cat.m
//
//
//  Created by jijunyuan on 15/1/25.
//  Copyright (c) 2015年 Kevin Zhang. All rights reserved.
//

#import "UIImage+Cat.h"
#import <objc/runtime.h>
#import "LanguageFile.h"

@implementation UIImage (Cat)
+ (void)load
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Method methodOri = class_getClassMethod([UIImage class], @selector(imageNamed:));
        Method methodCurr = class_getClassMethod([UIImage class], @selector(imageName_swizzle:));
        method_exchangeImplementations(methodOri, methodCurr);
    });
}

- (UIImage *)imageName_swizzle:(NSString *)imageName
{
    NSString* translated = imageName;
    translated = [LanguageFile translate:imageName];
    return [self imageName_swizzle:translated];
}

- (UIImage *)scaleToSize:(CGSize)newSize {
    //UIGraphicsBeginImageContext(newSize);
    // In next line, pass 0.0 to use the current device's pixel scaling factor (and thus account for Retina resolution).
    // Pass 1.0 to force exact pixel size.
    UIGraphicsBeginImageContextWithOptions(newSize, NO, 0.0);
    [self drawInRect:CGRectMake(0, 0, newSize.width, newSize.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

-(NSData*) compress {
    int kMaxUploadSize = 150000;
    CGFloat compression = 0.9f;
    CGFloat maxCompression = 0.1f;
    NSData *imageData = UIImageJPEGRepresentation(self, compression);
    
    while ([imageData length] > kMaxUploadSize && compression > maxCompression)
    {
        compression -= 0.10;
        imageData = UIImageJPEGRepresentation(self, compression);
    }
    
    return imageData;
}

+(UIImage*)star:(NSNumber *)total reviews:(NSNumber *)reviews {
    float rating = total.floatValue/reviews.floatValue;
    int irat = rating * 10;
    irat = irat / 5;
    irat = irat * 5;
    rating = irat / 10.;
    NSString* star = [NSString stringWithFormat:@"yelp-stars-%.1f", rating];
    return [UIImage imageNamed:star];
}

+(UIImage*)star:(NSNumber *)star {
    return [self star:star reviews:[NSNumber numberWithInt:1]];
}
@end
