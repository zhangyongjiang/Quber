//
//  AppConfiguration.h
//
//
//  Created by Kevin Zhang on 3/18/15.
//  Copyright (c) 2015 Kevin Zhang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AppConfiguration : NSObject

+(AppConfiguration*)getInstance;

-(void)setConf:(id)value forKey:(NSString *)key;
-(NSString*)getConf:(NSString*)key;
-(int)getConfAsInt:(NSString*)key defaultValue:(int)defValue;

@end
