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
//  NSObject+Event.m
//
//  Created by Kevin Zhang on 11/4/14.
//

#import <objc/runtime.h>
#import "NSObject+Event.h"
#import "NSObject+Attach.h"

static NSString* eventNameKey = @"ObjectEvent";

@implementation NSObject (Event)

-(NSString*)eventName {
    NSString* name = [self attachedObjectForKey:eventNameKey];
    return name;
}

-(void)setEventName:(NSString *)eventName {
    [self attachObject:eventName forKey:eventNameKey];
}

-(void)fireEvent {
    NSString* ename = self.eventName;
    if (!ename) {
        NSLog(@"No event name");
        return;
    }
    
    [[NSNotificationCenter defaultCenter] postNotificationName:ename object:self];
}
@end
