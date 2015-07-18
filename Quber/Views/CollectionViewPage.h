//
//  CollectionViewPage.h
//  Next Shopper
//
//  Created by Kevin Zhang on 10/12/14.
//  Copyright (c) 2014 Gaoshin. All rights reserved.
//

#import "Page.h"

@interface CollectionViewPage : Page <UICollectionViewDataSource, UICollectionViewDelegate,UIGestureRecognizerDelegate>
{
@protected
    UIRefreshControl* _refreshControl;
    UICollectionViewFlowLayout *_layout;
}

@property(strong,nonatomic)UICollectionView* collectionView;

-(void)checkNextPageForCollectionView:(UICollectionView *)collectionView indexPath:(NSIndexPath *)indexPath;

-(void)cellLongPressed:(NSIndexPath*)path;
@end
