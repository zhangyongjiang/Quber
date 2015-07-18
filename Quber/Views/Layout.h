//
//  Layout.h
//
//
//  Created by Kevin Zhang on 11/16/14.
//  Copyright (c) 2014 Kevin Zhang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Layout : NSObject

+(NSString*)value:(NSString*)key;
+(CGFloat)number:(NSString*)key;

+(NSString*)value:(NSString *)key forClass:(Class)cls;
+(CGFloat)number:(NSString *)key forClass:(Class)cls;

@end
