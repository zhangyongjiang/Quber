//
//  LanguageFile.m
//
//
//  Created by Kevin Zhang on 1/20/15.
//  Copyright (c) 2015 Kevin Zhang. All rights reserved.
//

#import "LanguageFile.h"
#import "LanguageText.h"
#import "LanguageDict.h"

static LanguageFile* instance;
NSString* gLanguage = @"c";

@interface LanguageFile()

@property(strong,nonatomic)NSMutableDictionary* dict;

@end

@implementation LanguageFile

+(void)load {
    instance = [[LanguageFile alloc] initWithFile:@"language-dictionary" andExt:@"txt"];
    gLanguage = [NSUserDefaults get:@"gLanguage"];
    if (!gLanguage) {
        gLanguage = @"e";
    }
}

+(void)toggleTranslate {
    if ([gLanguage isEqualToString:@"c"]) {
        gLanguage = @"e";
    }
    else
        gLanguage = @"c";
    [NSUserDefaults save:gLanguage forKey:@"gLanguage"];
    [[NSNotificationCenter defaultCenter] postNotificationName:NotificationLangChanged object:nil];
}

+(void)translateMutableString:(NSMutableString *)str {
    NSString* newstr = [self translate:str];
    if ([newstr isEqualToString:str]) {
        return;
    }
    [str replaceOccurrencesOfString:str withString:newstr options:NSCaseInsensitiveSearch range:NSMakeRange(0, str.length)];
}

+(NSString*)translate:(NSString *)str {
    if (!str) {
        return nil;
    }
    NSString* lower = [str lowercaseString];
    NSDictionary* dict = [instance.dict objectForKey:lower];
    if (dict) {
        NSString* translated = [dict objectForKey:gLanguage];
        if (translated) {
            return translated;
        }
    }

    NSArray* array = [str componentsSeparatedByString:@"##"];
    if (array.count == 1) {
        return str;
    }
    
    NSMutableString* parsed = [[NSMutableString alloc] init];
    for (NSString* substr in array) {
        [parsed appendString:[self translate:substr]];
    }
    return parsed;
}

-(id)initWithFile:(NSString *)name andExt:(NSString *)ext {
    self = [super init];
    self.dict = [[NSMutableDictionary alloc] init];
    NSString *content = [NSString stringWithContentsOfFile:[[NSBundle mainBundle] pathForResource:name ofType:ext]
                                                  encoding:NSUTF8StringEncoding
                                                     error:nil];
    NSArray* lines = [content componentsSeparatedByString:@"\n"];
    
    NSMutableArray* currentSet = [[NSMutableArray alloc] init];
    for (NSString* line in lines) {
        if ([line trim].length == 0) {
            if (currentSet.count>0) {
                NSMutableArray* dicts = [LanguageDict fromLanguageTextArray:currentSet];
                for (LanguageDict* ld in dicts) {
                    NSString* lower = [ld.text lowercaseString];
                    [self.dict setObject:ld.dict forKey:lower];
                }
            }
            currentSet = [[NSMutableArray alloc] init];
            continue;
        }
        LanguageText* lt = [[LanguageText alloc] initWithString:[line trim]];
        [currentSet addObject:lt];
    }
    return self;
}

@end
