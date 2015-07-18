//
//  UserImageView.m
//
//
//  Created by Kevin Zhang on 11/18/14.
//  Copyright (c) 2014 Kevin Zhang. All rights reserved.
//

#import "UserImageView.h"

@implementation UserImageView

-(id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    self.image = [UIImage imageNamed:@"avatarDefault"];
    self.contentMode = UIViewContentModeScaleAspectFit;
    self.layer.cornerRadius = frame.size.width/2.0;
    self.layer.masksToBounds = YES;
    self.layer.borderColor = [UIColor colorFromString:@"nsbg"].CGColor;
    self.layer.borderWidth = 1.0f;
    self.backgroundColor = [UIColor whiteColor];
    return self;
}
@end

@implementation SmallUserImageView

-(id)init {
    self = [super initWithFrame:CGRectMake(0, 0, SmallUserImageViewSize, SmallUserImageViewSize)];
    return self;
}

@end

@implementation MediumUserImageView

-(id)init {
    self = [super initWithFrame:CGRectMake(0, 0, MediumUserImageViewSize, MediumUserImageViewSize)];
    return self;
}

@end

@implementation LargeUserImageView

-(id)init {
    self = [super initWithFrame:CGRectMake(0, 0, LargeUserImageViewSize, LargeUserImageViewSize)];
    self.layer.borderWidth = 3.0f;
    return self;
}

@end
