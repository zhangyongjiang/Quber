//
//  ScrollViewPage.m
//
//
//  Created by Kevin Zhang on 2/5/15.
//  Copyright (c) 2015 Kevin Zhang. All rights reserved.
//

#import "ScrollViewPage.h"

@interface ScrollViewPage()

@property(strong,nonatomic)UIRefreshControl* refreshControl;

@end

@implementation ScrollViewPage

-(id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    self.scrollView = [[NSScrollView alloc] initWithFrame:frame];
    [self addSubview:self.scrollView];
    
    self.refreshControl = [[UIRefreshControl alloc] init];
//    self.refreshControl.attributedTitle = [[NSAttributedString alloc] initWithString:@"Pull to Refresh"];
    [self.scrollView addSubview:self.refreshControl];
    [_refreshControl addTarget:self
                        action:@selector(reloadData)
              forControlEvents:UIControlEventValueChanged];
    
    return self;
}

-(void)reloadData {
    [_refreshControl endRefreshing];
    [[NSNotificationCenter defaultCenter] postNotificationName:NotificationRefreshControl object:self];
}

-(void)beginRefresh {
    [_refreshControl beginRefreshing];
}

-(void)endRefresh {
    [_refreshControl endRefreshing];
}

@end
