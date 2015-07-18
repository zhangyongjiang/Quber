//
//  LabeledTabBar.m
//
//
//  Created by Kevin Zhang on 3/11/15.
//  Copyright (c) 2015 Kevin Zhang. All rights reserved.
//

#import "LabeledTabBar.h"

@interface LabeledTabBar()

@property(strong,nonatomic)NSMutableArray* tabs;
@property(strong,nonatomic)UIView* currentIndicator;

@end

@implementation LabeledTabBar

-(id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    self.tabs = [[NSMutableArray alloc] init];
    self.currentTab = 0;
    
    self.currentIndicator = [[UIView alloc] initWithFrame:CGRectMake(0, self.height - 10, 10, 2)];
    self.currentIndicator.backgroundColor = [UIColor mainColor];
    [self addSubview:self.currentIndicator];
    
    return self;
}

-(void)addTab:(NSString *)text {
    UILabel* tab = [self createTab:text];
    [self.tabs addObject:tab];
    [self addSubview:tab];
    [self hcenterSubviewArray:self.tabs];
    [self moveIndicator];
}

-(void)moveIndicator {
    UIView* view = [self.tabs objectAtIndex:self.currentTab];
    self.currentIndicator.x = view.x - 1;
    self.currentIndicator.width = view.width + 2;
}

-(UILabel*)createTab:(NSString*)text {
    UILabel* tab = [[FitLabel alloc] init];
    [tab styleContent];
    tab.text = text;
    tab.height = 40;
    tab.ycenter = self.height / 2.;
    tab.textAlignment = NSTextAlignmentCenter;
    [tab addTarget:self action:@selector(labelClicked:)];
    tab.accessibilityLabel = text;
    return tab;
}

-(void)labelClicked:(UITapGestureRecognizer*) gs {
    UIView* view = gs.view;
    for(int i=0; i<self.tabs.count; i++) {
        UIView* tab = [self.tabs objectAtIndex:i];
        if (tab == view) {
            self.currentTab = i;
            
            [UIView beginAnimations:nil context:nil];
            [UIView setAnimationDuration:0.5];
            [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
            [self moveIndicator];
            [UIView commitAnimations];
            
            [[NSNotificationCenter defaultCenter] postNotificationName:NotificationLabelTabChanged object:[NSNumber numberWithInt:self.currentTab]];
            break;
        }
    }
}
@end
