//
//  SimpleTableViewPage.h
//
//
//  Created by Kevin Zhang on 11/19/14.
//  Copyright (c) 2014 Kevin Zhang. All rights reserved.
//

#import "Page.h"
#import "TableViewPage.h"
#import "SimpleTableViewSection.h"
#import "SimpleTableViewData.h"
#import "SimpleRow.h"

@interface SimpleTableViewPage : TableViewPage

@property(strong, nonatomic)SimpleTableViewData* tableData;

@end
