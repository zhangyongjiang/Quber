//
//  MenuTopView.h
//
//
//  Created by Kevin Zhang on 11/21/14.
//  Copyright (c) 2014 Kevin Zhang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MenuTopView : UIView
@end


@interface GuestMenuTopView : MenuTopView
@property(strong,nonatomic)NSButton* emailSigninBtn;
@property(strong,nonatomic)NSButton* emailSignupBtn;
@end


@interface UserMenuTopView : MenuTopView
@property(strong,nonatomic)UIImageView* backgroundImgView;
@property(strong,nonatomic)LargeUserImageView* userImgView;
@property(strong,nonatomic)FitLabel* userNameView;

-(void)updateUserImage:(NSString*)path;
@end
