//
//  SimpleTableViewData.m
//
//
//  Created by Kevin Zhang on 12/31/14.
//  Copyright (c) 2014 Kevin Zhang. All rights reserved.
//

#import "SimpleTableViewData.h"

@implementation SimpleTableViewData

-(id)initWithSections:(SimpleTableViewSection *)section, ... {
    self = [super init];
    self.sections = [[NSMutableArray alloc] init];
    va_list args;
    va_start(args, section);
    for (SimpleTableViewSection *arg = section; arg != nil; arg = va_arg(args, SimpleTableViewSection*))
    {
        [self.sections addObject:arg];
    }
    va_end(args);
    return self;
}

@end

