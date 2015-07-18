//
//  SimpleTableViewData.h
//
//
//  Created by Kevin Zhang on 12/31/14.
//  Copyright (c) 2014 Kevin Zhang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SimpleTableViewData : NSObject

@property(strong, nonatomic)NSMutableArray* sections;

-(id)initWithSections:(SimpleTableViewSection*)section,...;

@end
