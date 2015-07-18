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
//  UIView+Position.m
//
//  Created by Kevin Zhang on 10/27/14.
//  Copyright (c) 2014 Kevin Zhang. All rights reserved.
//

#import <objc/runtime.h>
#import "UIView+Position.h"
#import "NSObject+Attach.h"

static NSCharacterSet* NumberCharSet;
static NSCharacterSet* AlphaCharSet;
static CGFloat iscale;

@interface DDBlockActionWrapper : NSObject
@property (nonatomic, copy) void (^blockAction)(void);
- (void) invokeBlock:(id)sender;
@end

@implementation DDBlockActionWrapper
- (void) invokeBlock:(id)sender {
    [self blockAction]();
}
@end

@implementation UIView (Position)

+ (void)load
{
    static dispatch_once_t onceToken;
    
    NumberCharSet = [NSCharacterSet characterSetWithCharactersInString:@"1234567890."];
    AlphaCharSet = [NumberCharSet invertedSet];
    
    dispatch_once(&onceToken, ^{
//        method_exchangeImplementations(class_getInstanceMethod([UIView class], @selector(initWithFrame_swizzle:)), class_getInstanceMethod([self class], @selector(initWithFrame:)));
    });
    
    iscale = [UIScreen mainScreen].bounds.size.width / 320.f;
}

-(id)initWithScaledFrame:(CGRect)frame {
    frame.origin.x = frame.origin.x * iscale;
    frame.origin.y = frame.origin.y * iscale;
    frame.size.width = frame.size.width * iscale;
    frame.size.height = frame.size.height * iscale;
    self = [self initWithFrame:frame];
    return self;
}

- (void)belowView:(UIView *)v withMargin:(CGFloat) margin
{
    CGRect thisFrame = self.frame;
    CGRect frame = v.frame;
    thisFrame.origin.y = frame.origin.y + frame.size.height + margin;
    self.frame = thisFrame;
}

- (void)aboveView:(UIView *)v withMargin:(CGFloat) margin
{
    CGRect thisFrame = self.frame;
    CGRect frame = v.frame;
    thisFrame.origin.y = frame.origin.y - thisFrame.size.height - margin;
    self.frame = thisFrame;
}

+ (void)top2bottomWithMargin:(CGFloat)margin views:(UIView*)view,...
{
    UIView *prev = nil;
    va_list args;
    va_start(args, view);
    for (UIView *arg = view; arg != nil; arg = va_arg(args, UIView*))
    {
        if(!prev) {
            prev = view;
            continue;
        }
        [arg belowView:prev withMargin:margin];
        prev = arg;
    }
    va_end(args);
}

- (void)addSubviews:(UIView *)view, ...
{
    va_list args;
    va_start(args, view);
    for (UIView *arg = view; arg != nil; arg = va_arg(args, UIView*))
    {
        [self addSubview:arg];
    }
    va_end(args);
}

+ (CGRect)rectForViews:(NSArray *)views
{
    CGFloat x0, y0, x1, y1;
    x0 = y0 = -1000000;
    x1 = y1 = 1000000;
    
    for (UIView * view in views) {
        if (view.hidden) {
            continue;
        }
        CGRect frame = view.frame;
        if (x0 < -99999) {
            x0 = frame.origin.x;
            y0 = frame.origin.y;
            x1 = frame.origin.x + frame.size.width;
            y1 = frame.origin.y + frame.size.height;
            continue;
        }
        if (frame.origin.x < x0) {
            x0 = frame.origin.x;
        }
        if (frame.origin.y < y0) {
            y0 = frame.origin.y;
        }
        if(frame.origin.x + frame.size.width > x1)
            x1 = frame.origin.x + frame.size.width;
        if(frame.origin.y + frame.size.height > y1)
            y1 = frame.origin.y + frame.size.height;
    }
    
    CGRect rect = CGRectMake(x0, y0, x1-x0, y1-y0);
    return rect;
}

+(UIView *)groupOfViews:(NSArray *)views
{
    CGRect rect = [UIView rectForViews:views];
    UIView *parent = [[UIView alloc] initWithFrame:rect];
    for (UIView * view in views) {
        [view removeFromSuperview];
        CGRect frame = view.frame;
        frame.origin.x = frame.origin.x - rect.origin.x;
        frame.origin.y = frame.origin.y - rect.origin.y;
        view.frame = frame;
        [parent addSubview:view];
    }
    return parent;
}

+(UIView*)maskViews:(NSArray *)views withBorderWidth:(CGFloat)width borderColor:(UIColor*)color radius:(CGFloat)radius {
    UIView* containerView = [UIView groupOfViews:views];
    containerView.clipsToBounds = YES;
    containerView.layer.cornerRadius = radius;
    containerView.layer.borderWidth = width;
    containerView.layer.borderColor = color.CGColor;
    containerView.backgroundColor = color;
    return containerView;
}

-(void)alignParentBottomWithMarghin:(CGFloat)margin
{
    CGRect pframe = self.superview.frame;
    CGRect frame = self.frame;
    frame.origin.y = pframe.size.height - frame.size.height - margin;
    self.frame = frame;
}

-(void)alignParentLeftWithMarghin:(CGFloat)margin
{
    CGRect frame = self.frame;
    frame.origin.x = margin;
    self.frame = frame;
}


-(void)rightOfView:(UIView *)v withMargin:(CGFloat)margin
{
    if(!v) return;
    self.x = v.x + v.width + margin;
}

-(void)alignParentRightWithMarghin:(CGFloat)margin
{
    if (self.superview) {
        CGRect pframe = self.superview.frame;
        CGRect frame = self.frame;
        frame.origin.x = pframe.size.width - frame.size.width - margin;
        self.frame = frame;
    }
}

-(void)alignParentTopWithMarghin:(CGFloat)margin
{
    if (self.superview) {
        CGRect frame = self.frame;
        frame.origin.y = margin;
        self.frame = frame;
    }
}

-(CGFloat)height {
    return self.frame.size.height;
}

-(CGFloat)width {
    return self.frame.size.width;
}

-(CGFloat)x {
    return self.frame.origin.x;
}

-(void)setX:(CGFloat)x {
    CGRect f = self.frame;
    f.origin.x = x;
    self.frame = f;
}

-(CGFloat)bottom {
    return self.y + self.height;
}

-(void)setBottom:(CGFloat)bottom {
    self.y = bottom - self.height;
}

-(CGFloat)right {
    return self.x + self.width;
}

-(void)setRight:(CGFloat)right {
    self.x = right - self.width;
}

-(void)setXcenter:(CGFloat)xcenter {
    self.x = xcenter - self.width/2.;
}

-(CGFloat)xcenter {
    return self.x + self.width / 2.;
}

-(CGFloat)ycenter {
    return self.y + self.height / 2.;
}

-(void)setYcenter:(CGFloat)ycenter {
    self.y = ycenter - self.height / 2.;
}

-(void)setScaledHeight:(CGFloat)height {
    self.height = height * iscale;
}
-(void)setScaledWidth:(CGFloat)width {
    self.width = width * iscale;
}
-(void)setScaledX:(CGFloat)x {
    self.x = x  * iscale;
}
-(void)setScaledY:(CGFloat)y {
    self.y = y * iscale;
}

-(void)setY:(CGFloat)y
{
    CGRect f = self.frame;
    f.origin.y = y;
    self.frame = f;
}

-(void)setWidth:(CGFloat)width
{
    CGRect f = self.frame;
    f.size.width = width;
    self.frame = f;
}

-(void)setHeight:(CGFloat)height
{
    CGRect f = self.frame;
    f.size.height = height;
    self.frame = f;
}

-(CGFloat)y {
    return self.frame.origin.y;
}

-(void)fitParentWidthWithMargin:(CGFloat)margin
{
    if (self.superview) {
        CGFloat pw = self.superview.width;
        self.frame = CGRectMake(margin, self.y, pw-margin*2, self.height);
    }
}

-(void)fitParentHeightWithMargin:(CGFloat)margin
{
    if (self.superview) {
        CGFloat ph = self.superview.height;
        self.frame = CGRectMake(self.x, margin, self.width, ph - margin * 2);
    }
}

- (void)centerInParent
{
    [self hcenterInParent];
    [self vcenterInParent];
}

- (void)hcenterInParent
{
    if (self.superview) {
        self.x = self.superview.width / 2.0 - self.width / 2.0;
    }
}

- (void)vcenterInParent
{
    if (self.superview) {
        self.y = self.superview.height / 2.0 - self.height / 2.0;
    }
}

- (void)extendToParentRightWithMargin:(CGFloat) margin
{
    if (self.superview) {
        CGFloat neww = self.superview.width - self.x - margin;
        self.width = neww;
    }
}

- (void)extendToParentBottomWithMargin:(CGFloat) margin
{
    if (self.superview) {
        CGFloat newh = self.superview.height - self.y - margin;
        self.height = newh;
    }
}

- (void)extendToParentLeftWithMargin:(CGFloat) margin
{
    if (self.superview) {
        CGFloat neww = self.x + self.width - margin;
        self.width = neww;
        self.x = margin;
    }
}

-(void)fitParentWithMargin:(CGFloat)margin
{
    [self fitParentHeightWithMargin:margin];
    [self fitParentWidthWithMargin:margin];
}

-(void)leftOfView:(UIView *)v withMargin:(CGFloat)margin
{
    if(!v) return;
    CGFloat delta = v.x - (self.x + self.width + margin);
    self.x = self.x + delta;
}

-(void)hcenterSubviews
{
    for (UIView *child in self.subviews) {
        child.x = (self.width - child.width)/2.0;
    }
}

-(void)vcenterSubviews
{
    for (UIView *child in self.subviews) {
        child.y = (self.height - child.height) / 2.0;
    }
}

-(void)vcenterMargin:(CGFloat)margin forSubviews:(UIView *)view, ... {
    CGFloat total = 0;
    int cnt = 0;
    va_list args;
    
    va_start(args, view);
    for (UIView *arg = view; arg != nil; arg = va_arg(args, UIView*))
    {
        total += arg.height;
        cnt ++;
    }
    va_end(args);
    
    CGFloat y = (self.height - total - (cnt -1) * margin) / 2.0;
    va_start(args, view);
    for (UIView *arg = view; arg != nil; arg = va_arg(args, UIView*))
    {
        arg.y = y;
        y = y + arg.height + margin;
    }
    va_end(args);
}

-(void)hcenterMargin:(CGFloat)margin forSubviews:(UIView *)view, ... {
    CGFloat total = 0;
    int cnt = 0;
    va_list args;
    
    va_start(args, view);
    for (UIView *arg = view; arg != nil; arg = va_arg(args, UIView*))
    {
        total += arg.width;
        cnt ++;
    }
    va_end(args);
    
    CGFloat x = (self.width - total - (cnt -1) * margin) / 2.0;
    va_start(args, view);
    for (UIView *arg = view; arg != nil; arg = va_arg(args, UIView*))
    {
        arg.x = x;
        x = x + arg.width + margin;
    }
    va_end(args);
}

-(void)hcenterMargin:(CGFloat)margin forSubviewArray:(NSArray *)views {
    CGFloat total = 0;
    int cnt = 0;
    
    for (UIView* view in views) {
        total += view.width;
        cnt ++;
    }
    
    
    CGFloat x = (self.width - total - (cnt -1) * margin) / 2.0;
    for (UIView* view in views) {
        view.x = x;
        x = x + view.width + margin;
    }
}

-(void)hcenterSubviewArray:(NSArray *)views {
    CGFloat total = 0;
    int cnt = 0;
    
    for (UIView* view in views) {
        total += view.width;
        cnt ++;
    }
    
    CGFloat margin = (self.width - total) / (cnt + 1);
    CGFloat x = (self.width - total - (cnt -1) * margin) / 2.0;
    for (UIView* view in views) {
        view.x = x;
        x = x + view.width + margin;
    }
}

-(void)vcenterMargin:(CGFloat)margin forSubviewArray:(NSArray *)views {
    CGFloat total = 0;
    int cnt = 0;
    
    for (UIView* view in views) {
        total += view.height;
        cnt ++;
    }
    
    
    CGFloat y = (self.height - total - (cnt -1) * margin) / 2.0;
    for (UIView* view in views) {
        view.y = y;
        y = y + view.height + margin;
    }
}

-(void)valignWith:(UIView *)view
{
    self.y = view.y + view.height/2 - self.height/2;
}

-(void)halignWith:(UIView *)view
{
    self.x = view.x + view.width/2 - self.width/2;
}

-(id)clone
{
    NSData *archivedViewData = [NSKeyedArchiver archivedDataWithRootObject: self];
    return [NSKeyedUnarchiver unarchiveObjectWithData:archivedViewData];
}

-(void) movetoNextSubview
{
    UIView *current = nil;
    for (UIView *child in self.subviews) {
        if([child isFirstResponder]) {
            current = child;
            break;
        }
    }
    
    if(current == nil) {
        for (UIView *child in self.subviews) {
            if(![child isKindOfClass:[UITextField class]]) {
                continue;
            }
            if(child.hidden) {
                continue;
            }
            if(current == nil) {
                current = child;
                continue;
            }
            if (child.y < current.y) {
                current = child;
                continue;
            }
            if (child.x < current.x) {
                current = child;
                continue;
            }
        }
        [current becomeFirstResponder];
        return;
    }
    
    UIView *next = nil;
    for (UIView *child in self.subviews) {
        if(![child isKindOfClass:[UITextField class]]) {
            continue;
        }
        if(child == current)
            continue;
        CGFloat diff = child.y - current.y;
        if(diff < 0) diff = -diff;
        if (diff < 0.01) {
            if (child.x < current.x) {
                continue;
            }
        }
        if (child.y < current.y) {
            continue;
        }
        if(child.hidden) {
            continue;
        }
        if(next == nil) {
            next = child;
            continue;
        }
        
        diff = (child.y - current.y) - (next.y - current.y);
        if(diff < 0) diff = -diff;
        if(diff < 0.01) {
            if(child.x < current.x)
                continue;
            if(child.x - current.x < next.x - current.x) {
                next = child;
                continue;
            }
        }
        else {
            if(child.y - current.y < next.y - current.y) {
                next = child;
                continue;
            }
        }
    }
    [next becomeFirstResponder];
}

-(CGRect)rectForSubviews
{
    return [UIView rectForViews:self.subviews];
}

+(CGFloat)scale
{
    return iscale;
//    return  [UIScreen mainScreen].bounds.size.width / 320.0;
}

+(CGFloat)screenWidth
{
    return  [UIScreen mainScreen].bounds.size.width;
}

+(CGFloat)screenHeight
{
    return  [UIScreen mainScreen].bounds.size.height;
}

-(NSNumber*)numberFromString:(NSString*)strNum {
    if(!strNum || strNum.length==0) return nil;
    strNum = [strNum stringByReplacingOccurrencesOfString:@" " withString:@""];
    strNum = [strNum stringByReplacingOccurrencesOfString:@"*" withString:@""];
    
    if ([strNum hasSuffix:@"screen-width"]) {
        strNum = [strNum substringToIndex:strNum.length-12];
        if(strNum.length == 0)
            return [NSNumber numberWithFloat:[UIView screenWidth]];
        else
            return [NSNumber numberWithFloat:(strNum.floatValue * [UIView screenWidth])];
    }
    
    if ([strNum hasSuffix:@"screen-height"]) {
        strNum = [strNum substringToIndex:strNum.length-13];
        if(strNum.length == 0)
            return [NSNumber numberWithFloat:[UIView screenHeight]];
        else
            return [NSNumber numberWithFloat:(strNum.floatValue * [UIView screenHeight]) ];
    }
    
    if ([strNum hasSuffix:@"parent-width"]) {
        if (!self.superview) {
            return nil;
        }
        strNum = [strNum substringToIndex:strNum.length-12];
        if(strNum.length == 0) {
            CGFloat w = self.superview.width;
            return [NSNumber numberWithFloat:w];
        }
        else {
            return [NSNumber numberWithFloat:strNum.floatValue * self.superview.width];
        }
    }
    
    if ([strNum hasSuffix:@"parent-height"]) {
        if (!self.superview) {
            return nil;
        }
        strNum = [strNum substringToIndex:strNum.length-13];
        if(strNum.length == 0)
            return [NSNumber numberWithFloat:self.superview.height];
        else
            return [NSNumber numberWithFloat:(strNum.floatValue * self.superview.height)];
    }
    
    if ([strNum hasSuffix:@"px"]) {
        strNum = [strNum substringToIndex:(strNum.length-2)];
    }
    
    if ([strNum hasSuffix:@"!"]) {
        strNum = [strNum substringToIndex:(strNum.length-1)];
        return [NSNumber numberWithFloat:[strNum floatValue]];
    }
    else {
        NSRange range = [strNum rangeOfCharacterFromSet:AlphaCharSet];
        if (range.location != NSNotFound) {
            @throw([NSException exceptionWithName:@"InvalidData" reason:strNum userInfo:nil]);
        }
        return [NSNumber numberWithFloat:([strNum floatValue] * iscale)];
    }
}

+ (UIImage *)imageWithImage:(UIImage *)image scaledToSize:(CGSize)newSize {
    UIGraphicsBeginImageContextWithOptions(newSize, NO, 0.0);
    [image drawInRect:CGRectMake(0, 0, newSize.width, newSize.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

-(void)setBackgroundImage:(NSString *)name {
    UIImage* img = [UIImage imageNamed:name];
    img = [UIView imageWithImage:img scaledToSize:CGSizeMake(self.width, self.height)];
    self.backgroundColor = [UIColor colorWithPatternImage:img];
}

+(void)setLeftMargin:(CGFloat)margin views:(UIView *)view, ... {
    va_list args;
    va_start(args, view);
    for (UIView *arg = view; arg != nil; arg = va_arg(args, UIView*))
    {
        arg.x = margin;
    }
    va_end(args);
}

+(void)hcenterViews:(UIView *)view, ... {
    va_list args;
    va_start(args, view);
    for (UIView *arg = view; arg != nil; arg = va_arg(args, UIView*))
    {
        [arg hcenterInParent];
    }
    va_end(args);
}

+(void)vcenterViews:(UIView *)view, ... {
    va_list args;
    va_start(args, view);
    for (UIView *arg = view; arg != nil; arg = va_arg(args, UIView*))
    {
        [arg vcenterInParent];
    }
    va_end(args);
}

-(void)addSubviewH:(UIView *)view margin:(CGFloat)margin {
    if ([self.subviews count]==0) {
        [self addSubview:view];
        return;
    }
    CGRect rect = [self rectOfSubviews];
    view.x = rect.origin.x + rect.size.width + margin;
    [self addSubview:view];
}

-(void)addSubviewV:(UIView *)view margin:(CGFloat)margin {
    if ([self.subviews count]==0) {
        [self addSubview:view];
        return;
    }
    CGRect rect = [self rectOfSubviews];
    view.y = rect.origin.y + rect.size.height + margin;
    [self addSubview:view];
}

-(BOOL)isSameViewOrChildOf:(UIView *)superView {
    if (self == superView) {
        return YES;
    }
    UIView* view = self;
    while (view) {
        if (view.superview == superView) {
            return YES;
        }
        view = view.superview;
    }
    return NO;
}

-(void)addTarget:(id)target action:(SEL)action {
    self.userInteractionEnabled = YES;
    UITapGestureRecognizer* gr = [[UITapGestureRecognizer alloc] initWithTarget:target action:action];
    [self addGestureRecognizer:gr];
}

-(void)addEventHandler:(void (^)(void))handler {
    DDBlockActionWrapper * target = [[DDBlockActionWrapper alloc] init];
    [target setBlockAction:handler];
    [self addTarget:target action:@selector(invokeBlock:)];
    [self attachObject:target forKey:@"eventHandler"];
}

- (void)alignLeftWithView:(UIView*)view{
    self.x = view.x;
}

- (void)alignRightWithView:(UIView*)view {
    self.x = view.x + view.width - self.width;
}

- (void)alignTopWithView:(UIView*)view {
    self.y = view.y;
}

- (void)alignBottomWithView:(UIView*)view {
    self.y = view.y + view.height - self.height;
}

-(void) setRoundingCorners:(UIRectCorner)corners withRadius:(CGFloat)radius
{
    UIBezierPath* rounded = [UIBezierPath bezierPathWithRoundedRect:self.bounds byRoundingCorners:corners cornerRadii:CGSizeMake(radius, radius)];
    
    CAShapeLayer* shape = [[CAShapeLayer alloc] init];
    [shape setPath:rounded.CGPath];
    
    self.layer.mask = shape;
}

-(void)setTopCornersWithRadius:(CGFloat)radius {
    [self setRoundingCorners:UIRectCornerTopLeft|UIRectCornerTopRight withRadius:radius];
}

-(void)setBottomCornersWithRadius:(CGFloat)radius {
    [self setRoundingCorners:UIRectCornerBottomLeft|UIRectCornerBottomRight withRadius:radius];
}

-(void)setEventDelegate:(id<UIViewEventDelegate>)delegate {
    [self attachObject:delegate forKey:@"UIViewEventDelegate"];
}

-(void)fireEvent:(NSString *)name data:(NSObject *)data {
    id<UIViewEventDelegate> delegate = [self attachedObjectForKey:@"UIViewEventDelegate"];
    if (delegate) {
        [delegate handleEvent:name fromSource:self data:data];
    }
    else {
        [self.superview fireEvent:name data:data];
    }
}

- (UIImage *)toImage {
    UIGraphicsBeginImageContextWithOptions(self.bounds.size, NO, [[UIScreen mainScreen] scale]);
    [[self layer] renderInContext: UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}
@end
