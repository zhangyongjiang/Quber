//
//  MenuPage.h
//
//
//  Created by Kevin Zhang on 11/22/14.
//  Copyright (c) 2014 Kevin Zhang. All rights reserved.
//

#import "Page.h"
#import "MenuItem.h"
#import "MenuTopView.h"

@interface GuestMenuPage : Page
@property(strong,nonatomic)UserMenuTopView* topView;
@property(strong,nonatomic)GuestMenu* menu;
@end

@interface UserMenuPage : Page
@property(strong,nonatomic)UserMenuTopView* topView;
@property(strong,nonatomic)UserMenu* menu;
-(void)update;
-(void)updateShoppingCartNumber:(NSInteger)number;
-(void)updateMsgNumber:(NSNumber*)number;
@end
