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
//  NSObject+Attach.m
//
//  Created by Kevin Zhang on 11/5/14.
//  Copyright (c) 2014 Kevin Zhang. All rights reserved.
//

#import <objc/runtime.h>
#import "NSObject+Attach.h"

@implementation NSObject (Attach)

-(void)attachObject:(id)anObject forKey:(id)aKey {
    NSMutableDictionary* dict = [self getAttachedDictionary:YES];
    [dict setObject:anObject forKey:aKey];
}

-(id)attachedObjectForKey:(id)aKey {
    NSMutableDictionary* dict = [self getAttachedDictionary:NO];
    if (!dict) {
        return nil;
    }
    return [dict objectForKey:aKey];
}

-(id)attachedObjectForKey:(id)aKey defaultValue:(id)defValue{
    NSMutableDictionary* dict = [self getAttachedDictionary:NO];
    id value = [dict objectForKey:aKey];
    return value ? value : defValue;
}

-(NSMutableDictionary *)getAttachedDictionary:(BOOL)createIfNotExist {
    static char key;
    NSMutableDictionary *dict = objc_getAssociatedObject(self, &key);
    if(dict || !createIfNotExist)
        return dict;
    dict = [[NSMutableDictionary alloc] init];
    objc_setAssociatedObject(self, &key, dict, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    return dict;
}

-(void)removeAttachedObjectForKey:(id)aKey {
    NSMutableDictionary* dict = [self getAttachedDictionary:NO];
    if (!dict) {
        return;
    }
    [dict removeObjectForKey:aKey];
}
@end
