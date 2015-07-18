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
//  UIColor+String.h
//
//  Created by Kevin Zhang on 11/3/14.
//

#import <UIKit/UIKit.h>

@interface UIColor (String)

+(UIColor*) colorFromString:(NSString*) colorStr;
+(UIColor*)colorFromRGB:(int) rgbValue;
+(UIColor*)colorFromRGBA:(int) rgbaValue;
+(UIColor*)mainColor;
+(UIColor*)bgColor;
+(UIColor*)mainHighlightColor;

+ (UIImage *)gradientImageWithR0:(CGFloat)r0 g0:(CGFloat)g0 b0:(CGFloat)b0 a0:(CGFloat)a0 r1:(CGFloat)r1 g1:(CGFloat)g1 b1:(CGFloat)b1 a1:(CGFloat)a1 size:(CGSize)size;
+ (UIColor *)gradientColorWithR0:(CGFloat)r0 g0:(CGFloat)g0 b0:(CGFloat)b0 a0:(CGFloat)a0 r1:(CGFloat)r1 g1:(CGFloat)g1 b1:(CGFloat)b1 a1:(CGFloat)a1 size:(CGSize)size;

@end
