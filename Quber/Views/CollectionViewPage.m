//
//  CollectionViewPage.m
//  Next Shopper
//
//  Created by Kevin Zhang on 10/12/14.
//  Copyright (c) 2014 Gaoshin. All rights reserved.
//

#import "CollectionViewPage.h"

@implementation CollectionViewPage

-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(self) {
        _layout = [[UICollectionViewFlowLayout alloc] init];
        self.collectionView = [[UICollectionView alloc] initWithFrame:frame collectionViewLayout:_layout];
        self.collectionView.backgroundColor = [UIColor colorFromString:@"nsbg"];
        self.collectionView.delegate = self;
        self.collectionView.dataSource = self;

        UILongPressGestureRecognizer *lpgr = [[UILongPressGestureRecognizer alloc]
                                              initWithTarget:self action:@selector(handleLongPress:)];
        lpgr.minimumPressDuration = .5; //seconds
        lpgr.delegate = self;
        [self.collectionView addGestureRecognizer:lpgr];
        self.collectionView.alwaysBounceVertical = YES;

        [self addSubview:self.collectionView];

        _refreshControl = [[UIRefreshControl alloc] init];
//        _refreshControl.attributedTitle = [[NSAttributedString alloc] initWithString:@"Pull to Refresh"];
        [self.collectionView addSubview:_refreshControl];
        [_refreshControl addTarget:self
                                action:@selector(reloadData)
                      forControlEvents:UIControlEventValueChanged];
    }
    return self;
}

-(void)beginRefresh
{
    [_refreshControl beginRefreshing];
}

-(void)endRefresh
{
    [_refreshControl endRefreshing];
}

-(void)reloadData {
    [_refreshControl endRefreshing];
    [[NSNotificationCenter defaultCenter] postNotificationName:NotificationRefreshControl object:self];
}

-(void)checkNextPageForCollectionView:(UICollectionView *)collectionView indexPath:(NSIndexPath *)indexPath {
    if ((indexPath.section+1) == [self numberOfSectionsInCollectionView:collectionView] && indexPath.row == ([self collectionView:collectionView numberOfItemsInSection:indexPath.section]-1)) {
        [[NSNotificationCenter defaultCenter] postNotificationName:NotificationEndOfDisplay object:collectionView];
    }
}

-(void)handleLongPress:(UILongPressGestureRecognizer *)gestureRecognizer
{
//    if (gestureRecognizer.state != UIGestureRecognizerStateEnded) {
//        return;
//    }
    CGPoint p = [gestureRecognizer locationInView:self.collectionView];
    
    NSIndexPath *indexPath = [self.collectionView indexPathForItemAtPoint:p];
    if (indexPath != nil){
        [self cellLongPressed:indexPath];
    }
}

-(void)cellLongPressed:(NSIndexPath *)path {
}

-(void)reload {
    [self.collectionView reloadData];
}
@end
