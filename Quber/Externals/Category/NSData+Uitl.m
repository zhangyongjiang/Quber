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
//  NSData+Uitl.m
//
//
//  Created by Kevin Zhang on 3/19/15.
//  Copyright (c) 2015 Kevin Zhang. All rights reserved.
//

#import "NSData+Uitl.h"

@implementation NSData (Uitl)

+(NSData*)dataFromFile:(NSString*)name andExt:(NSString*)ext {
    NSString* nameWithSize = [NSString stringWithFormat:@"%@-%ix%i", name, (int)[UIView screenWidth], (int)[UIView screenHeight]];
    NSString *pathAndFileName = [[NSBundle mainBundle] pathForResource:nameWithSize ofType:ext];
    if ([[NSFileManager defaultManager] fileExistsAtPath:pathAndFileName]) {
        return [NSData dataWithContentsOfFile:pathAndFileName];
    }
    
    pathAndFileName = [[NSBundle mainBundle] pathForResource:name ofType:ext];
    if ([[NSFileManager defaultManager] fileExistsAtPath:pathAndFileName]) {
        return [NSData dataWithContentsOfFile:pathAndFileName];
    }
    
    return nil;
}


@end
