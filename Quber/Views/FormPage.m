//
//  FormPage.m
//
//
//  Created by Kevin Zhang on 1/6/15.
//  Copyright (c) 2015 Kevin Zhang. All rights reserved.
//

#import "FormPage.h"

#define HeaderLabelTopMargin    32

@interface FormPage() <UITextFieldDelegate>

@end

@implementation FormPage

-(id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    self.scrollView = [[UIScrollView alloc] initWithFrame:frame];
    [self.scrollView addTarget:self action:@selector(scrollViewTouched)];
    [self addSubview:self.scrollView];
    
    self.headerLabel = [[FitLabel alloc] init];
    [self.headerLabel h1];[self.headerLabel white];[self.headerLabel medium];
    [self.scrollView addSubview:self.headerLabel];
    return self;
}

-(void)scrollViewTouched {
    [self hideKeyboardForView:self.scrollView];
}

-(BOOL)hideKeyboardForView:(UIView*)view {
    if ([view isKindOfClass:[UIResponder class]]) {
        UIResponder* field = (UIResponder*)view;
        if ([field isFirstResponder]) {
            [field resignFirstResponder];
            return YES;
        }
    }
    for (UIView* subv in view.subviews) {
        BOOL firstResponder = [self hideKeyboardForView:subv];
        if (firstResponder) {
            return YES;
        }
    }
    return NO;
}

-(void)layoutSubviews {
    [super layoutSubviews];
    [self.headerLabel hcenterInParent];
    [self.headerLabel alignParentTopWithMarghin:HeaderLabelTopMargin];
    NSMutableArray* array = [FormPage searchTextField:self];
    for (UIView* view in array) {
        UITextField* tf = view;
        tf.delegate = self;
    }
}

-(UIView*)maskViews:(NSArray *)views {
    return [UIView maskViews:views withBorderWidth:FormBorderWidth borderColor:FormBorderColor radius:CornerRadius];
}

-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    [[NSNotificationCenter defaultCenter] postNotificationName:NotificationTextFieldFocused object:self];
    gCurrentTextField = textField;
    return YES;
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    UIView* view = textField;
    while (view) {
        UIView* parent = view.superview;
        if ([parent isKindOfClass:[Page class]] || [parent isKindOfClass:[UIScrollView class]]) {
            NSMutableArray* array = [FormPage searchTextField:parent];
            BOOL foundme = NO;
            for (UITextField* tf in array) {
                if (!foundme) {
                    if (tf == textField) {
                        foundme = YES;
                    }
                }
                else {
                    [tf becomeFirstResponder];
                    return YES;
                }
            }
            return YES;
        }
        view = parent;
    }
    return YES;
}

+(NSMutableArray*)searchTextField:(UIView*)view {
    NSMutableArray* array = [[NSMutableArray alloc] init];
    [self searchTextField:view toArray:array];
    return array;
}

+(void)searchTextField:(UIView*)view toArray:(NSMutableArray*)array {
    if ([view isKindOfClass:[UITextField class]]) {
        [array addObject:view];
        return;
    }
    for (UIView* child in view.subviews) {
        [self searchTextField:child toArray:array];
    }
}

-(UITextField*)searchTextField:(UIView*)view {
    if ([view isKindOfClass:[UITextField class]]) {
        return (UITextField*)view;
    }
    for (UIView* child in view.subviews) {
        UITextField* tf = [self searchTextField:child];
        if (tf) {
            return tf;
        }
    }
    return nil;
}
@end
