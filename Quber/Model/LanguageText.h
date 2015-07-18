//
//  LanguageText.h
//
//
//  Created by Kevin Zhang on 1/20/15.
//  Copyright (c) 2015 Kevin Zhang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LanguageText : NSObject

@property(strong,nonatomic)NSString* language;
@property(strong,nonatomic)NSString* text;

-(id)initWithString:(NSString*)line;

@end
