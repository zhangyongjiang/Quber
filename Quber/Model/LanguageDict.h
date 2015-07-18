//
//  LanguageDict.h
//
//
//  Created by Kevin Zhang on 1/20/15.
//  Copyright (c) 2015 Kevin Zhang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LanguageDict : NSObject

@property(strong,nonatomic)NSString* text;
@property(strong,nonatomic)NSMutableDictionary* dict;

+(NSMutableArray*)fromLanguageTextArray:(NSMutableArray*)languageTexts;

@end
