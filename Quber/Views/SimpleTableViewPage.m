//
//  SimpleTableViewPage.m
//
//
//  Created by Kevin Zhang on 11/19/14.
//  Copyright (c) 2014 Kevin Zhang. All rights reserved.
//

#import "SimpleTableViewPage.h"
#import "TableViewSectionHeader.h"
#import "NSTableViewCell.h"
#import "NSObject+Event.h"

@interface SimpleTableViewPage() <UITableViewDelegate, UITableViewDataSource>


@end


@implementation SimpleTableViewPage


-(id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    [_tableView registerClass:[NSTableViewCell class] forCellReuseIdentifier:NSStringFromClass([NSTableViewCell class])];
//    _tableView.scrollEnabled = NO;
    return self;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.tableData.sections.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    SimpleTableViewSection* sectionData = [self.tableData.sections objectAtIndex:section];
    return sectionData.rows.count;
}

-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    SimpleTableViewSection* sectionData = [self.tableData.sections objectAtIndex:section];
    if(!sectionData.headerText || sectionData.headerText.length == 0) {
        TableViewSectionHeaderLabel* header = [[TableViewSectionHeaderLabel alloc] initWithFrame:CGRectMake(0, 0, [UIView screenWidth], 40)];
        SimpleTableViewSection* sectionData = [self.tableData.sections objectAtIndex:section];
        header.label.text = sectionData.headerText;
        return header;
    }
    else {
        TableViewSectionHeaderLabel* header = [[TableViewSectionHeaderLabel alloc] init];
        SimpleTableViewSection* sectionData = [self.tableData.sections objectAtIndex:section];
        header.label.text = sectionData.headerText;
        return header;
    }
    
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSTableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([NSTableViewCell class]) forIndexPath:indexPath];
    SimpleTableViewSection* sectionData = [self.tableData.sections objectAtIndex:indexPath.section];
    NSString* text = [sectionData.rows objectAtIndex:indexPath.row];
    cell.textLabel.text = nil;
    cell.textLabel.text = text;
    cell.accessibilityLabel = text;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    SimpleTableViewSection* sectionData = [self.tableData.sections objectAtIndex:indexPath.section];
    NSString* label = [sectionData.rows objectAtIndex:indexPath.row];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"SimpleTableRowClicked" object:self];
    [[NSNotificationCenter defaultCenter] postNotificationName:label object:self];
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    SimpleTableViewSection* sectionData = [self.tableData.sections objectAtIndex:section];
    if(!sectionData.headerText || sectionData.headerText.length == 0)
        return 40;
    else
        return 63;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44;
}
@end
