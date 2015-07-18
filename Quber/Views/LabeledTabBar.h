//
//  LabeledTabBar.h
//
//
//  Created by Kevin Zhang on 3/11/15.
//  Copyright (c) 2015 Kevin Zhang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LabeledTabBar : UIView

@property(assign,nonatomic)int currentTab;

-(void)addTab:(NSString*)text;

@end
