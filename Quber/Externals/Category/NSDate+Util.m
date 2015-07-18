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
//  NSDate+Util.m
//
//
//  Created by Kevin Zhang on 1/3/15.
//  Copyright (c) 2015 Kevin Zhang. All rights reserved.
//

#import "NSDate+Util.h"

@implementation NSDate (Util)

+(NSDate*)fromMilliseconds:(NSNumber *)millisecconds {
    NSDate * date = [NSDate dateWithTimeIntervalSince1970:([millisecconds floatValue]/1000)];
    return date;
}

+(NSString*)toYmd:(NSNumber *)millisecconds {
    return [[self fromMilliseconds:millisecconds] toYmd];
}

+(NSString*)toYmdhm:(NSNumber *)millisecconds {
    return [[self fromMilliseconds:millisecconds] toYmdhm];
}

-(NSString*)toYmd {
    NSDateFormatter  * formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"MM/dd/yyyy"];
    return [formatter stringFromDate:self];
}

-(NSString*)toYmdhm {
    NSDateFormatter  * formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"MM/dd/yyyy HH:mm:ss"];
    return [formatter stringFromDate:self];
}
@end
