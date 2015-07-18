//
//  LabelWithTitle.h
//
//
//  Created by Kevin Zhang on 1/17/15.
//  Copyright (c) 2015 Kevin Zhang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LabelWithTitle : UIView

@property(strong,nonatomic)NSString* text;
@property(assign,nonatomic)BOOL fitHeight;

-(id)initWithTitle:(NSString*)title;

@end
