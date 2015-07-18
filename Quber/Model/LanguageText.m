//
//  LanguageText.m
//
//
//  Created by Kevin Zhang on 1/20/15.
//  Copyright (c) 2015 Kevin Zhang. All rights reserved.
//

#import "LanguageText.h"

@implementation LanguageText

-(id)initWithString:(NSString *)line {
    self = [super init];
    int pos = [line indexOf:@":"];
    self.language = [line substringToIndex:pos];
    self.text = [line substringFromIndex:pos + 1];
    self.text = [self.text stringByReplacingOccurrencesOfString:@"\\n" withString:@"\n"];
    return self;
}

@end
