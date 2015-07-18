//
//  MenuItem.h
//
//
//  Created by Kevin Zhang on 11/22/14.
//  Copyright (c) 2014 Kevin Zhang. All rights reserved.
//

#import "IconTitleCell.h"

@interface MenuItem : IconTitleCell

@property(strong,nonatomic)NSString* imgName;

@end

@interface Menu : UIView
@property(strong,nonatomic)NSMutableArray* items;
@end

@interface GuestMenu : Menu

@end

@interface UserMenu : Menu

-(void)updateShoppingCartNumber:(NSInteger)number;
-(void)updateMsgNumber:(NSNumber*)number;

@end