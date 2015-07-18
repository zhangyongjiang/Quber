//
//  SimpleTableViewPage.h
//
//
//  Created by Kevin Zhang on 11/19/14.
//  Copyright (c) 2014 Kevin Zhang. All rights reserved.
//

#import "Page.h"

@interface TableViewPage : Page <UITableViewDelegate, UITableViewDataSource>
{
@protected
    UITableView* _tableView;
    UIRefreshControl* _refreshControl;
}

-(id)initWithFrame:(CGRect)frame andStyle:(UITableViewStyle)style;
-(void)beginRefresh;
-(void)endRefresh;
-(void)checkNextPageForTableView:(UITableView*)tableView indexPath:(NSIndexPath*)indexPath;
-(void)deselect;

@end
