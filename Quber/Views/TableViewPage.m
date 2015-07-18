//
//  SimpleTableViewPage.m
//
//
//  Created by Kevin Zhang on 11/19/14.
//  Copyright (c) 2014 Kevin Zhang. All rights reserved.
//

#import "TableViewPage.h"

@interface TableViewPage() 


@end


@implementation TableViewPage


-(id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    _tableView = [[UITableView alloc] initWithFrame:frame];
    [self setup];
    return self;
}

-(id)initWithFrame:(CGRect)frame andStyle:(UITableViewStyle)style {
    self = [super initWithFrame:frame];
    _tableView = [[UITableView alloc] initWithFrame:frame style:style];
    [self setup];
    return self;
}

-(void)setup {
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.frame = self.bounds;
    _tableView.backgroundColor = [UIColor bgColor];
    _tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIView screenWidth], 40)];
    _tableView.tableFooterView.backgroundColor = [UIColor bgColor];
    _tableView.clipsToBounds = YES;
    
    [self addSubview:_tableView];
    
    _refreshControl = [[UIRefreshControl alloc] init];
//    _refreshControl.attributedTitle = [[NSAttributedString alloc] initWithString:@"Pull to Refresh"];
    [_tableView addSubview:_refreshControl];
    
    [_refreshControl addTarget:self
                        action:@selector(reloadData)
              forControlEvents:UIControlEventValueChanged];
}

-(void)beginRefresh {
    [_refreshControl beginRefreshing];
    _refreshControl.hidden = YES;
}

-(void)endRefresh {
    [_refreshControl endRefreshing];
    _refreshControl.hidden = NO;
}

-(void)reloadData {
    [_refreshControl endRefreshing];
    [[NSNotificationCenter defaultCenter] postNotificationName:NotificationRefreshControl object:self];
}

-(void)checkNextPageForTableView:(UITableView*)tableView indexPath:(NSIndexPath*)indexPath {
    if ((indexPath.section+1) == [self numberOfSectionsInTableView:tableView]
        && (indexPath.row == ([self tableView:tableView numberOfRowsInSection:indexPath.section]-3)
            || ([self tableView:tableView numberOfRowsInSection:indexPath.section]==1)
            )
            ) {
        [[NSNotificationCenter defaultCenter] postNotificationName:NotificationEndOfDisplay object:tableView];
    }
    
}

-(void)reload {
    [_tableView reloadData];
}

-(void)deselect {
    [_tableView deselectRowAtIndexPath:[_tableView indexPathForSelectedRow] animated:YES];
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.5;
}

-(UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    UIView* view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIView screenWidth], 0.5)];
    view.backgroundColor = FormBorderColor;
    return view;
}

@end
