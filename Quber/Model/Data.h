//
//  Data.h
//  NextShopperSwift
//
//  Created by Kevin Zhang on 10/16/14.
//  Copyright (c) 2014 Kevin Zhang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Data : NSObject

-(NSString *) toJson;
-(NSString*)addToUrlString:(NSString *)urlString;
- (NSMutableDictionary *) toDictionary;

@end
