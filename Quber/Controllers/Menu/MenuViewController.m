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

@property(strong,nonatomic)UserMenuPage* userMenuPage;
@property(strong,nonatomic)GuestMenuPage* guestMenuPage;

@end

@implementation MenuViewController

-(void)createPage {
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(shopClicked:) name:@"Shop" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(aboutClicked:) name:@"About" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(settingsClicked:) name:@"Settings" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(notiClicked:) name:@"Notification" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(msgMenuItemClicked:) name:@"Message" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(signinMenuItemClicked:) name:@"Sign in" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(signupMenuItemClicked:) name:@"Sign up" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(orderHistoryMenuItemClicked:) name:@"Order History" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(shoppingCartClicked:) name:@"Shopping Cart" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(emailSignupBtnClicked:) name:EmailSignupButtonClicked object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(facebookBtnClicked:) name:FacebookButtonClicked object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(twitterBtnClicked:) name:TwitterButtonClicked object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(browseMenuItemClicked:) name:@"Search" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(notiMeChanged:) name:NotificationMeChanged object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(createPage) name:NotificationLangChanged object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeBackgroundImage:) name:NotificationBackgroundImage object:nil];
}

-(void)changeBackgroundImage:(NSNotification *) notification  {
}

-(void)notiMeChanged:(NSNotification *) notification  {
    if (self.userMenuPage) {
        [self.userMenuPage.topView layoutSubviews];
        [self.userMenuPage update];
    }
    else {
        [self.guestMenuPage removeFromSuperview];
        self.guestMenuPage = nil;
        self.userMenuPage = [[UserMenuPage alloc] initWithFrame:self.view.bounds];
        [self.view addSubview:self.userMenuPage];
        [self.userMenuPage.topView.userImgView addTarget:self action:@selector(avatarClicked)];
    }
}

-(void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}

-(void)facebookBtnClicked:(NSNotification *) notification  {
}

-(void)twitterBtnClicked:(NSNotification *) notification  {
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    UIImage *selectedImage = info[UIImagePickerControllerEditedImage];
    if(!selectedImage)
        selectedImage = info[UIImagePickerControllerOriginalImage];
    NSData *imageData = UIImagePNGRepresentation(selectedImage);
    [picker dismissViewControllerAnimated:YES completion:NULL];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [picker dismissViewControllerAnimated:YES completion:NULL];
}

-(void)handleEvent:(NSString *)name fromSource:(UIView *)source data:(NSObject *)data {
    [super handleEvent:name fromSource:source data:data];
    
}

-(void)userLoggedIn {
    if (self.userMenuPage) {
        [self notiMeChanged:nil];
    }
    else {
        [self createPage];
    }
}

-(void)userLoggedOut {
    if (self.userMenuPage) {
        [self createPage];
    }
}

@end
