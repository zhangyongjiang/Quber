//
//  LanguageFile.h
//
//
//  Created by Kevin Zhang on 1/20/15.
//  Copyright (c) 2015 Kevin Zhang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LanguageFile : NSObject

+(void)toggleTranslate;
+(NSString*)translate:(NSString*)str;
+(void)translateMutableString:(NSMutableString*)str;

@end
