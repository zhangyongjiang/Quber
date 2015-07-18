//
//  MenuItem.m
//
//
//  Created by Kevin Zhang on 11/22/14.
//  Copyright (c) 2014 Kevin Zhang. All rights reserved.
//

#import "MenuItem.h"

@interface MenuItem()


@end

@implementation MenuItem

-(id)initWithText:(NSString*)text andIcon:(NSString*)imgName {
    self = [super initWithFrame:CGRectMake(0, 0, [UIView screenWidth], 48 * [UIView scale])];
    self.accessibilityLabel = text;
    self.backgroundColor = [UIColor clearColor];
    self.eventName = text;
    self.iconImgView.width = 22;
    self.iconImgView.height = 22;
    self.imgName = imgName;
    self.iconImgView.image = [UIImage imageNamed:self.imgName];
    [self.titleLabel styleMenuItem];
    self.titleLabel.text = text;
    self.titleLabel.textColor = [UIColor blackColor];
    self.userInteractionEnabled = YES;
    
    UITapGestureRecognizer* gr = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didTap)];
    [self addGestureRecognizer:gr];
    
    return self;
}

-(NSString*)eventName {
    NSString* name = [super eventName];
    if (name) {
        return name;
    }
    return self.titleLabel.text;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    self.titleLabel.textColor = [UIColor mainColor];
    self.iconImgView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@-active", self.imgName]];
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    self.titleLabel.textColor = [UIColor blackColor];
    self.iconImgView.image = [UIImage imageNamed:self.imgName];
}

-(void)didTap {
    [self fireEvent];
    self.titleLabel.textColor = [UIColor blackColor];
    self.iconImgView.image = [UIImage imageNamed:self.imgName];
}

@end


@implementation Menu

-(id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:CGRectMake(0, 0, [UIView screenWidth], 50 * [UIView scale])];
    self.items = [[NSMutableArray alloc] init];
    return self;
}

@end

@implementation GuestMenu

-(id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    
    [self.items addObject:[[MenuItem alloc] initWithText:@"Shop" andIcon:@"menu-shop"]];
    [self.items addObject:[[MenuItem alloc] initWithText:@"Search" andIcon:@"menu-search"]];
    [self.items addObject:[[MenuItem alloc] initWithText:@"About" andIcon:@"menu-about"]];
    
    for (UIView* subview in self.items) {
        [self addSubviewV:subview margin:0];
    }
    
    return self;
}

@end

@interface UserMenu()

@property(strong,nonatomic)MenuItem* cartMenu;
@property(strong,nonatomic)MenuItem* msgMenu;

@end

@implementation UserMenu

-(id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    
    self.cartMenu  = [[MenuItem alloc] initWithText:@"Shopping Cart" andIcon:@"menu-cart"];
    
    NSInteger badgeNumber = [UIApplication sharedApplication].applicationIconBadgeNumber;
    NSString* icon = badgeNumber > 0 ? @"menu-messages-full" : @"menu-messages";
    self.msgMenu = [[MenuItem alloc] initWithText:@"Message" andIcon:icon];
    
    [self.items addObject:[[MenuItem alloc] initWithText:@"Shop" andIcon:@"menu-shop"]];
    [self.items addObject:[[MenuItem alloc] initWithText:@"Search" andIcon:@"menu-search"]];
    [self.items addObject:self.cartMenu];
    [self.items addObject:[[MenuItem alloc] initWithText:@"Settings" andIcon:@"menu-setting"]];
    [self.items addObject:self.msgMenu];
    [self.items addObject:[[MenuItem alloc] initWithText:@"Order History" andIcon:@"menu-order"]];
    [self.items addObject:[[MenuItem alloc] initWithText:@"About" andIcon:@"menu-about"]];
    
    for (UIView* subview in self.items) {
        [self addSubviewV:subview margin:0];
    }
    
    return self;
}

-(void)updateShoppingCartNumber:(NSInteger)number {
    if (number == 0) {
        self.cartMenu.imgName = @"menu-cart";
    }
    else {
        self.cartMenu.imgName = @"menu-cart-full";
    }
    self.cartMenu.iconImgView.image = [UIImage imageNamed:self.cartMenu.imgName];
    [self.cartMenu setNeedsDisplay];
}

-(void)updateMsgNumber:(NSNumber*)number {
    if (number.intValue == 0) {
        self.msgMenu.imgName = @"menu-messages";
    }
    else {
        self.msgMenu.imgName = @"menu-messages-full";
    }
    self.msgMenu.iconImgView.image = [UIImage imageNamed:self.msgMenu.imgName];
    [self.msgMenu setNeedsDisplay];
}

@end
