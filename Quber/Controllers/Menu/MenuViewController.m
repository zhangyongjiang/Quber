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
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(simpleTableRowClicked:) name:@"SimpleTableRowClicked" object:nil];
}

-(void)simpleTableRowClicked:(NSNotification*)notifcation {
    [[AppDelegate getInstance] showMainView];
}

@end
