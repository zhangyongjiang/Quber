//
//  MenuPage.m
//
//
//  Created by Kevin Zhang on 11/22/14.
//  Copyright (c) 2014 Kevin Zhang. All rights reserved.
//

#import "MenuPage.h"
#import "UIImage+ImageEffects.h"

@implementation GuestMenuPage

-(id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    self.backgroundColor = [UIColor clearColor];
    self.topView = [[UserMenuTopView alloc] init];
    [self addSubview:self.topView];
    
    self.topView.userNameView.text = @"Log In or Sign Up";
//    self.topView.userNameView.hidden  = YES;
    
    self.menu = [[GuestMenu alloc] initWithFrame:frame];
    [self addSubview:self.menu];

//    UIImage* image = [UIImage imageNamed:@"welcome"];
//    image = [image scaleToSize:CGSizeMake([UIView screenWidth], [UIView screenHeight])];
//    UIImage* color = [image applyLightEffect];
//    self.backgroundColor = [UIColor colorWithPatternImage:color];
    self.backgroundColor = [UIColor whiteColor];

    return self;
}

-(void)layoutSubviews {
    [self.menu belowView:self.topView withMargin:0];
    self.menu.height = self.height - self.topView.height;
}

@end

@implementation UserMenuPage

-(id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    self.backgroundColor = [UIColor clearColor];
    self.topView = [[UserMenuTopView alloc] init];
    [self addSubview:self.topView];
    
//    UIImage* image = [UIImage imageNamed:@"welcome"];
//    image = [image scaleToSize:CGSizeMake([UIView screenWidth], [UIView screenHeight])];
//    UIImage* color = [image applyLightEffect];
//    self.backgroundColor = [UIColor colorWithPatternImage:color];
    
    self.menu = [[UserMenu alloc] init];
    [self addSubview:self.menu];
    return self;
}

-(void)layoutSubviews {
    [self.menu belowView:self.topView withMargin:0];
    self.menu.height = self.height - self.topView.height;
}

-(void)update {
}

-(void)updateShoppingCartNumber:(NSInteger)number {
    [self.menu updateShoppingCartNumber:number];
}

-(void)updateMsgNumber:(NSNumber*)number {
    [self.menu updateMsgNumber:number];
}
@end
