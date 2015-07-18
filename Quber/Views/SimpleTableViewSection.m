//
//  SimpleTableViewSection.m
//
//
//  Created by Kevin Zhang on 12/31/14.
//  Copyright (c) 2014 Kevin Zhang. All rights reserved.
//

#import "SimpleTableViewSection.h"

@implementation SimpleTableViewSection

-(id)initWithHeader:(NSString *)headerText andRows:(NSString *)rowText, ... {
    self = [super init];
    self.headerText = headerText;
    
    self.rows = [[NSMutableArray alloc] init];
    
    va_list args;
    va_start(args, rowText);
    for (NSString *arg = rowText; arg != nil; arg = va_arg(args, NSString*))
    {
        [self.rows addObject:arg];
    }
    va_end(args);
    return self;
}

@end
