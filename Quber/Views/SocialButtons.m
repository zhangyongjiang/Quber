//
//  FacebookButton.m
//
//
//  Created by Kevin Zhang on 11/17/14.
//  Copyright (c) 2014 Kevin Zhang. All rights reserved.
//

#import "SocialButtons.h"

@implementation SocialSignupButton

-(id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:CGRectMake(0, 0, 54*[UIView scale], 54*[UIView scale])];
    self.layer.cornerRadius = 27 * [UIView scale];
    return self;
}

@end

@implementation FacebookButton

-(id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    [self setImage:[UIImage imageNamed:@"welcomeFacebook"] forState:UIControlStateNormal];
    [self setImage:[UIImage imageNamed:@"welcomeFacebookSelect"] forState:UIControlStateSelected];
    [self addTarget:self action:@selector(clicked) forControlEvents:UIControlEventTouchUpInside];
    return self;
}

-(void)clicked {
    [[NSNotificationCenter defaultCenter] postNotificationName:FacebookButtonClicked object:self];
}

@end

@implementation TwitterButton

-(id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    [self setImage:[UIImage imageNamed:@"welcomeTwitter"] forState:UIControlStateNormal];
    [self setImage:[UIImage imageNamed:@"welcomeTwitterSelect"] forState:UIControlStateSelected];
    [self addTarget:self action:@selector(clicked) forControlEvents:UIControlEventTouchUpInside];
    return self;
}

-(void)clicked {
    [[NSNotificationCenter defaultCenter] postNotificationName:TwitterButtonClicked object:self];
}

@end

@implementation EmailSignupButton

-(id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    [self setImage:[UIImage imageNamed:@"welcomeMail"] forState:UIControlStateNormal];
    [self setImage:[UIImage imageNamed:@"welcomeMailSelect"] forState:UIControlStateSelected];
    [self addTarget:self action:@selector(clicked) forControlEvents:UIControlEventTouchUpInside];
    return self;
}

-(void)clicked {
    [[NSNotificationCenter defaultCenter] postNotificationName:EmailSignupButtonClicked object:self];
}

@end
