//
//  SimpleTableViewSection.h
//
//
//  Created by Kevin Zhang on 12/31/14.
//  Copyright (c) 2014 Kevin Zhang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SimpleTableViewSection : NSObject

@property(strong,nonatomic)NSString* headerText;
@property(strong,nonatomic)NSMutableArray* rows;

-(id)initWithHeader:(NSString*)headerText andRows:(NSString*)rowText,...;

@end
