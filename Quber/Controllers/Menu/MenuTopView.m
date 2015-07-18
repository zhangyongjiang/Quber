//
//  MenuTopView.m
//
//
//  Created by Kevin Zhang on 11/21/14.
//  Copyright (c) 2014 Kevin Zhang. All rights reserved.
//

#import "MenuTopView.h"

@interface MenuTopView()
@property(strong,nonatomic)UIView* frontView;
@end

@implementation MenuTopView

-(id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:CGRectMake(0, 0, [UIView screenWidth], 140 * [UIView scale])];
    self.frontView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.width*0.8, self.height)];
    [self addSubview:self.frontView];
    return self;
}

@end



@implementation GuestMenuTopView

-(id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    
    CGFloat topMargin = 50 * [UIView scale];
    CGFloat margin = 20;
    CGFloat btnWidth = 105;
    
    self.emailSignupBtn = [[NSButton alloc] initWithFrame:CGRectMake(0, 0, btnWidth, ButtonHeightSmall)];
    self.emailSignupBtn.layer.borderColor = [UIColor whiteColor].CGColor;
    [self.emailSignupBtn setTitle:@"Sign up" forState:UIControlStateNormal];
    self.emailSignupBtn.y = topMargin;
    [self.frontView addSubview:self.emailSignupBtn];
    
    self.emailSigninBtn = [[NSButton alloc] initWithFrame:CGRectMake(0, 0, btnWidth, ButtonHeightSmall)];
    self.emailSigninBtn.layer.borderColor = [UIColor whiteColor].CGColor;
    [self.emailSigninBtn setTitle:@"Sign in" forState:UIControlStateNormal];
    self.emailSigninBtn.y = topMargin;
    [self.frontView addSubview:self.emailSigninBtn];
 
    [self.emailSigninBtn alignParentRightWithMarghin:margin];
    [self.emailSignupBtn alignParentLeftWithMarghin:margin];
    
    return self;
}

@end


@interface UserMenuTopView()
@end

@implementation UserMenuTopView

-(id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    self.backgroundColor = [UIColor bgColor];
    
    self.clipsToBounds = YES;
    
    self.userImgView = [[LargeUserImageView alloc] init];
    self.userImgView.accessibilityLabel = @"userImgView";
    [self.frontView addSubview:self.userImgView];
    
    self.userNameView = [[FitLabel alloc] init];
    self.userNameView.text = @"login user name";
    [self.userNameView h2];
    [self.userNameView black0];
    [self.frontView addSubview:self.userNameView];
    
    self.userImgView.y = 24 * [UIView scale];
    [self.userNameView belowView:self.userImgView withMargin:PagePadding];
    
//    User* me = [NSUserDefaults savedUser];
//    self.userNameView.text = [NSString stringWithFormat:@"%@ %@", me.info.firstName, me.info.lastName];
//    [self.userImgView setImageWithPath:me.info.imgPath];
    
    return self;
}

-(void)updateUserImage:(NSString *)path {
    [self.userImgView setImageWithPath:path];
}

-(void)layoutSubviews {
    [super layoutSubviews];
    [UIView hcenterViews:self.userNameView, self.userImgView, nil];
}
@end


