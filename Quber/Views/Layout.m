//
//  Layout.m
//
//
//  Created by Kevin Zhang on 11/16/14.
//  Copyright (c) 2014 Kevin Zhang. All rights reserved.
//

#import "Layout.h"

static NSCharacterSet* NumberCharSet;
static NSCharacterSet* AlphaCharSet;
static NSDictionary* dict;

@interface Layout()
@end

@implementation Layout

+ (void)load
{
    NumberCharSet = [NSCharacterSet characterSetWithCharactersInString:@"1234567890."];
    AlphaCharSet = [NumberCharSet invertedSet];

    NSString *path = [[NSBundle mainBundle] pathForResource: @"Layout" ofType: @"plist"];
    dict = [NSDictionary dictionaryWithContentsOfFile: path];
}

+(NSString*)value:(NSString*)key {
    id obj = [dict objectForKey:key];
    return obj;
}

+(NSString*)value:(NSString*)key forClass:(Class)cls {
    NSString* newkey = [NSString stringWithFormat:@"%@.%@",[self simpleClsName:cls], key];
    return [self value:newkey];
}

+(CGFloat)number:(NSString *)key {
    NSString* value = [self value:key];
    if([value hasSuffix:@"!"])
        return [value substringToIndex:value.length-1].floatValue;
    else
        return value.floatValue;
}

+(CGFloat)number:(NSString *)key forClass:(Class)cls {
    NSString* value = [self value:key forClass:cls];
    if([value hasSuffix:@"!"])
        return [value substringToIndex:value.length-1].floatValue;
    else
        return value.floatValue;
}

+(NSString*) simpleClsName:(Class)cls {
    NSString* name = NSStringFromClass(cls);
    NSRange r = [name rangeOfString:@"."];
    if(r.location == NSNotFound) {
        return name;
    }
    return [name substringFromIndex:r.location+1];
}

@end


