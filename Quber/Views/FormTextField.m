//
//  FormTextField.m
//
//
//  Created by Kevin Zhang on 11/17/14.
//  Copyright (c) 2014 Kevin Zhang. All rights reserved.
//

#import "FormTextField.h"

@implementation FormTextField

-(id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    self.backgroundColor = [UIColor whiteColor];
    if (frame.size.width<0.01) {
        self.width = 100;
    }
    self.height = 44 * [UIView scale];
    [self styleContent];
    self.placeholderColor = [UIColor colorFromString:@"gray8"];
    
    UILabel* accessoryview = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, [UIView screenWidth], 30)];
    accessoryview.text = @"done";
    accessoryview.textColor = [UIColor lightTextColor];
    accessoryview.textAlignment = NSTextAlignmentRight;
    [accessoryview addTarget:self action:@selector(resignFirstResponder)];
    accessoryview.backgroundColor = [UIColor lightGrayColor];
    self.inputAccessoryView = accessoryview;

    return self;
}
@end

@implementation PasswordField

-(id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    self.secureTextEntry = YES;
    return self;
}

@end

@implementation FullWidthField

-(id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:CGRectMake(PagePadding, frame.origin.y, FullWidthExcludePadding, FormFieldHeight)];
    return self;
}

-(id)initWithPlaceHolder:(NSString*)placeHolder {
    self = [super initWithFrame:CGRectMake(PagePadding, 0, FullWidthExcludePadding, FormFieldHeight)];
    self.placeholder = placeHolder;
    return self;
}

@end

@interface FullWidthTextFieldWithLabel()

@property(strong, nonatomic)UILabel* label;

@end

@implementation FullWidthTextFieldWithLabel

-(id)initWithLabel:(NSString *)label {
    self = [super initWithFrame:CGRectMake(PagePadding, 0, FullWidthExcludePadding, FormFieldHeight)];
    self.backgroundColor = [UIColor whiteColor];
    
    CGFloat labelWidth = FullWidthExcludePadding * 0.4;
    CGFloat textFieldWidth = FullWidthExcludePadding - labelWidth;
    
    CGRect labelRect = CGRectMake(0, 0, labelWidth, FormFieldHeight);
    self.label = [[UILabel alloc] initWithFrame:labelRect];
    self.label.text = label;
    self.label.textAlignment = NSTextAlignmentRight;
    self.label.textColor = [UIColor colorFromString:@"gray8"];
    [self.label styleTableViewRowLabel];
    [self addSubview:self.label];
    
    CGRect textRect = CGRectMake(labelWidth, 0, textFieldWidth, FormFieldHeight);
    self.textField = [[FormTextField alloc] initWithFrame:textRect];
    [self addSubview:self.textField];
    
    return self;
}

-(NSString*)text {
    NSString* text = [self.textField.text trim];
    if(text.length == 0)
        return nil;
    return text;
}

-(void)setText:(NSString *)text {
    self.textField.text = text;
}

@end

@implementation FullWidthPasswordFieldWithLabel

-(id)initWithLabel:(NSString *)label {
    self = [super initWithLabel:label];
    self.textField.secureTextEntry = YES;
    return self;
}

@end

