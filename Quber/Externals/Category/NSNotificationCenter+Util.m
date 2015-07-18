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
//  NSNotificationCenter+Util.m
//
//
//  Created by Kevin Zhang on 1/4/15.
//  Copyright (c) 2015 Kevin Zhang. All rights reserved.
//

#import "NSNotificationCenter+Util.h"

@implementation NSNotificationCenter (Util)

- (void)postNotification:(NSNotification *)notification withDelay:(CGFloat)seconds {
    double delayInSeconds = seconds;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        [self postNotification:notification];
    });}

- (void)postNotificationName:(NSString *)aName object:(id)anObject withDelay:(CGFloat)seconds {
    double delayInSeconds = seconds;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        [self postNotificationName:aName object:anObject];
    });
}

- (void)postNotificationName:(NSString *)aName object:(id)anObject userInfo:(NSDictionary *)aUserInfo withDelay:(CGFloat)seconds {
    double delayInSeconds = seconds;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        [self postNotificationName:aName object:anObject userInfo:aUserInfo];
    });
}

-(void)postControllerNotification:(UIViewController*)controller fromView:(id)aViewObject {
    [[NSNotificationCenter defaultCenter] postNotificationName:NotificationPushController object:aViewObject userInfo:[NSDictionary  dictionaryWithObjectsAndKeys:controller, @"controller",nil]];
}

-(void)presentControllerNotification:(UIViewController*)controller fromView:(id)aViewObject {
    [[NSNotificationCenter defaultCenter] postNotificationName:NotificationPresentController object:aViewObject userInfo:[NSDictionary  dictionaryWithObjectsAndKeys:controller, @"controller",nil]];
}
@end
