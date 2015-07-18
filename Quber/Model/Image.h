//
//  Image.h
//  Next Shopper
//
//  Created by Kevin Zhang on 10/7/14.
//  Copyright (c) 2014 Gaoshin. All rights reserved.
//

#import "Data.h"

@interface Image : Data

@property(assign, nonatomic) int width;
@property(assign, nonatomic) int height;
@property(assign, nonatomic) int bits;
@property(strong, nonatomic) NSString* mime;
@property(strong, nonatomic) NSString* extension;
@property(strong, nonatomic) NSString* image;

@end
