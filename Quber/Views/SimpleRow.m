//
//  SimpleRow.m
//
//
//  Created by Kevin Zhang on 12/31/14.
//  Copyright (c) 2014 Kevin Zhang. All rights reserved.
//

#import "SimpleRow.h"

@implementation SimpleRow

-(id)initWithText:(NSString *)text andAccessory:(NSString *)accessory {
    self = [super init];
    self.text = text;
    self.accessory = accessory;
    return self;
}

@end
