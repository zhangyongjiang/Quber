/*
 * Licensed to the Apache Software Foundation (ASF) under one or more
 * contributor license agreements.  See the NOTICE file distributed with
 * this work for additional information regarding copyright ownership.
 * The ASF licenses this file to You under the Apache License, Version 2.0
 * (the "License"); you may not use this file except in compliance with
 * the License.  You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

//
//  NSUserDefaults+Util.m
//
//
//  Created by Kevin Zhang on 12/29/14.
//  Copyright (c) 2014 Kevin Zhang. All rights reserved.
//

#import "NSUserDefaults+Util.h"
#import "ObjectMapper.h"

@implementation NSUserDefaults (Util)

+(void)savePushNotificationToken:(NSString *)token {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:token forKey:@"push-notification-token"];
    [defaults synchronize];
}

+(NSString*)savedPushNotificationToken {
    NSString* token = [[NSUserDefaults standardUserDefaults] objectForKey:@"push-notification-token"];
    return token;
}

+(void)save:(NSObject *)obj forKey:(NSString *)key {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:obj forKey:key];
    [defaults synchronize];
}

+(id)get:(NSString *)key {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    return [defaults objectForKey:key];
}

+(void)remove:(NSString *)key {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults removeObjectForKey:key];
    [defaults synchronize];
}

+(NSString*)savedEmail {
    return [NSUserDefaults get:@"LoginEmail"];
}
+(void)saveEmail:(NSString*)email {
    [NSUserDefaults save:email forKey:@"LoginEmail"];
}
+(void)removeSavedEmail {
    [NSUserDefaults remove:@"LoginEmail"];
}
+(NSString*)savedPassword {
    return [NSUserDefaults get:@"LoginPassword"];
}
+(void)savePassword:(NSString *)password {
    [NSUserDefaults save:password forKey:@"LoginPassword"];
}
+(void)removeSavedPassword {
    [NSUserDefaults remove:@"LoginPassword"];
}

+(void)saveCartNumber:(NSInteger)cartNumber {
    [NSUserDefaults save:[NSNumber numberWithLong:cartNumber] forKey:@"CartNumber"];
}
+(int)savedCartNumber {
    NSNumber* number = [NSUserDefaults get:@"CartNumber"];
    if (number) {
        return number.intValue;
    }
    else
        return 0;
}
@end
