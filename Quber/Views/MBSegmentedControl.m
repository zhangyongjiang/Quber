//
//  MBSegmentedControl.m
//
//
//  Created by Kevin Zhang on 1/13/15.
//  Copyright (c) 2015 Kevin Zhang. All rights reserved.
//

#import "MBSegmentedControl.h"

@implementation MBSegmentedControl

-(id)initWithItems:(NSArray *)items {
    self = [super initWithItems:items];
    self.tintColor = [UIColor colorFromString:@"nsred"];
    UIFont *font = [UIFont fontWithName:@"GothamRounded-Book" size: 13];
    NSDictionary *attributes = [NSDictionary dictionaryWithObject:font
                                                           forKey:NSFontAttributeName];
    [self setTitleTextAttributes:attributes
                                   forState:UIControlStateNormal];
    return self;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    NSInteger current = self.selectedSegmentIndex;
    [super touchesBegan:touches withEvent:event];
    if (current == self.selectedSegmentIndex) {
        [self sendActionsForControlEvents:UIControlEventValueChanged];
    }
}

@end
