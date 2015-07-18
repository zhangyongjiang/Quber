//
//  FormTextField.h
//
//
//  Created by Kevin Zhang on 11/17/14.
//  Copyright (c) 2014 Kevin Zhang. All rights reserved.
//

#import "UITextField+Style.h"

@interface FormTextField : UITextFieldWithPadding

@end

@interface PasswordField : FormTextField

@end

@interface FullWidthField : FormTextField

-(id)initWithPlaceHolder:(NSString*)placeHolder;

@end

@interface FullWidthTextFieldWithLabel : UIView

@property(strong, nonatomic)NSString* text;
@property(strong, nonatomic)FormTextField* textField;

-(id)initWithLabel:(NSString*)label;

@end

@interface FullWidthPasswordFieldWithLabel : FullWidthTextFieldWithLabel

@end

