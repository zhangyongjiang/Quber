//
//  LanguageDict.m
//
//
//  Created by Kevin Zhang on 1/20/15.
//  Copyright (c) 2015 Kevin Zhang. All rights reserved.
//

#import "LanguageDict.h"
#import "LanguageText.h"

@implementation LanguageDict

+(NSMutableArray*)fromLanguageTextArray:(NSMutableArray*)languageTexts {
    NSMutableDictionary* dict = [[NSMutableDictionary alloc] init];
    for (LanguageText* lt in languageTexts) {
        [dict setObject:lt.text forKey:lt.language];
    }

    NSMutableArray* array = [[NSMutableArray alloc] init];
    for (LanguageText* lt in languageTexts) {
        LanguageDict* ld = [[LanguageDict alloc] init];
        [array addObject:ld];
        ld.text = lt.text;
        ld.dict = dict;
    }

    return array;
}

@end
