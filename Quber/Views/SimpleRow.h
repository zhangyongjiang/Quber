//
//  SimpleRow.h
//
//
//  Created by Kevin Zhang on 12/31/14.
//  Copyright (c) 2014 Kevin Zhang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SimpleRow : NSObject

@property(strong,nonatomic)NSString* text;
@property(strong,nonatomic)NSString* accessory;

-(id)initWithText:(NSString*)text andAccessory:(NSString*)accessory;

@end
