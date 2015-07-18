//
//  MenuViewController.m
//
//
//  Created by Kevin Zhang on 11/16/14.
//  Copyright (c) 2014 Kevin Zhang. All rights reserved.
//

#import "MenuViewController.h"
#import "MenuPage.h"
#import "UIImage+ImageEffects.h"


@interface MenuViewController() <UINavigationControllerDelegate, UIImagePickerControllerDelegate>

@property(strong,nonatomic)MenuPage* page;

@end

@implementation MenuViewController

-(void)createPage {
    CGFloat y = 0;
    if (self.page) {
        [self.page removeFromSuperview];
        UIView* navBar = self.navigationController.navigationBar;
        y = navBar.bottom;
    }
    self.page = [[MenuPage alloc] initWithFrame:self.view.frame];
    self.page.y = y;
    [self.view addSubview:self.page];
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(logoutClicked:) name:@"Logout" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateProfileClicked:) name:@"Update Profile" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changePasswordClicked:) name:@"Change Password" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(showMyFavorites:) name:@"Favorites" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(showFollowedStores:) name:@"Followed Stores" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(editShipping:) name:@"Shipping" object:nil];
}

-(void)changeBackgroundImage:(NSNotification *) notification  {
}

-(void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}

-(void)handleEvent:(NSString *)name fromSource:(UIView *)source data:(NSObject *)data {
    [super handleEvent:name fromSource:source data:data];
    
}

@end
