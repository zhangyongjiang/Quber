//
//  AppConfiguration.m
//
//
//  Created by Kevin Zhang on 3/18/15.
//  Copyright (c) 2015 Kevin Zhang. All rights reserved.
//

#import "AppConfiguration.h"

static AppConfiguration* instance;

@interface AppConfiguration()

@property(strong,nonatomic)NSMutableDictionary* dict;

@end


@implementation AppConfiguration

+(void)load {
    instance = [[AppConfiguration alloc] initWithFile:@"configuration" andExt:@"txt"];
}

+(AppConfiguration*)getInstance {
    return instance;
}

-(id)initWithFile:(NSString*)name andExt:(NSString*)ext {
    self = [super init];
    
    self.dict = [[NSMutableDictionary alloc] init];
    NSString *content = [NSString stringWithContentsOfFile:[[NSBundle mainBundle] pathForResource:name ofType:ext] encoding:NSUTF8StringEncoding error:nil];
    NSArray* lines = [content componentsSeparatedByString:@"\n"];
    for (NSString* line in lines) {
        if ([line trim].length == 0 || [line hasPrefix:@"#"]) {
            continue;
        }
        NSRange range = [line rangeOfString:@"="];
        if(range.location == NSNotFound) {
            continue;
        }
        NSString* value = [line substringFromIndex:range.location+1];
        NSString* key = [line substringToIndex:range.location];
        [self.dict setObject:value forKey:key];
    }
    return self;
}

-(void)setConf:(id)value forKey:(NSString *)key {
    [self.dict setObject:value forKey:key];
}

-(NSString*) getConf:(NSString *)key {
    return [self.dict objectForKey:key];
}

-(int)getConfAsInt:(NSString *)key defaultValue:(int)defValue {
    NSString* value = [self getConf:key];
    if (value) {
        return [value intValue];
    }
    else
        return defValue;
}
@end
