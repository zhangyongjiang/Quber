//
//  RadioButtonGroup.h
//
//
//  Created by Kevin Zhang on 2/20/15.
//  Copyright (c) 2015 Kevin Zhang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RadioButton.h"

#define RadioButtonHeight   20

@interface RadioButtonGroup : UIView

@property(strong,nonatomic)NSString* selected;

-(id)initWithFrame:(CGRect)frame andLabels:(NSArray *)labels andColumnsPerRow:(int)columns;

@end
