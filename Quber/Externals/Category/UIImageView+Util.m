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
//  UIImageView+Util.m
//
//
//  Created by Kevin Zhang on 1/3/15.
//  Copyright (c) 2015 Kevin Zhang. All rights reserved.
//

#import "UIImageView+Util.h"

@implementation UIImageView (Util)

-(void)setImageWithPath:(NSString *)path {
    [self setImageWithPath:path placeholderImage:nil success:nil];
}

-(void)setImageWithPath:(NSString *)path  placeholderImage:(UIImage*)placeholderImage {
    [self setImageWithPath:path placeholderImage:placeholderImage success:nil];
}

-(void)setImageWithPath:(NSString *)path  placeholderImage:(UIImage*)placeholderImage success:(void (^)(UIImage *img, UIImageView* view))success {
    if (!path) {
        NSLog(@"null path");
        return;
    }
    
    NSURL* URLString = path;
    
    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:URLString cachePolicy:NSURLRequestReturnCacheDataElseLoad timeoutInterval:10.0f];
    UIImage *image = [[UIImageView sharedImageCache] cachedImageForRequest:urlRequest];
    if (image != nil) {
        self.image = image;
        if(success)
            success(image, self);
        return;
    }
    
    __weak UIImageView* weakSelf = self;
    int contentMode = self.contentMode;
    if (placeholderImage) {
        self.contentMode = UIViewContentModeCenter;
    }
    [self setImageWithURLRequest:urlRequest placeholderImage:placeholderImage success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image) {
        if (placeholderImage) {
            weakSelf.contentMode = contentMode;
        }
        [[UIImageView sharedImageCache] cacheImage:image forRequest:urlRequest];
        
//        weakSelf.image = image;
        [UIView transitionWithView:weakSelf
                          duration:1.0f
                           options:UIViewAnimationOptionTransitionCrossDissolve
                        animations:^{[weakSelf setImage:image];}
                        completion:NULL];
        
        if(success)
            success(image, weakSelf);
    } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error) {
        if(success)
            success(nil, weakSelf);
    }];
}

-(void)setImageWithPathArray:(NSArray *)array {
    if (array && array.count>0) {
        [self setImageWithPath:[array objectAtIndex:0]];
    }
}

-(void)setImageWithPath:(NSString *)path andArray:(NSArray *)array {
    if (array && array.count>0) {
        [self setImageWithPath:[array objectAtIndex:0]];
        return;
    }
    [self setImageWithPath:path placeholderImage:nil success:nil];
}

@end
