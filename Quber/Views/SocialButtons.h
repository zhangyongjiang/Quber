//
//  FacebookButton.h
//
//
//  Created by Kevin Zhang on 11/17/14.
//  Copyright (c) 2014 Kevin Zhang. All rights reserved.
//

#import <UIKit/UIKit.h>

#define EmailSignupButtonClicked @"EmailSignupButtonClicked"
#define FacebookButtonClicked @"FacebookButtonClicked"
#define TwitterButtonClicked @"TwitterButtonClicked"

@interface SocialSignupButton : UIButton

@end


@interface FacebookButton : SocialSignupButton

@end

@interface TwitterButton : SocialSignupButton

@end

@interface EmailSignupButton : SocialSignupButton

@end
