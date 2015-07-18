//
//  NSPickerView.m
//
//
//  Created by Kevin Zhang on 2/16/15.
//  Copyright (c) 2015 Kevin Zhang. All rights reserved.
//

#import "NSPickerView.h"

@implementation NSPickerView

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    NSInteger current = [self selectedRowInComponent:0];
    [super touchesBegan:touches withEvent:event];
    if (current == [self selectedRowInComponent:0]) {
        [self selectRow:current inComponent:0 animated:NO];
    }
}

@end
