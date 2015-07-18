//
//  ContactNextShopperPage.m
//
//
//  Created by Kevin Zhang on 11/16/14.
//  Copyright (c) 2014 Kevin Zhang. All rights reserved.
//

#import "SendMessagePage.h"
#import "APBAlertView.h"

#define PlaceHolder @"Your message here"

@interface SendMessagePage() <UITextViewDelegate>

@end


@implementation SendMessagePage

-(id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    
    self.images = [[NSMutableArray alloc] init];

    self.textFieldSubject = [[FullWidthField alloc] initWithPlaceHolder:@"Subject"];
    self.textFieldSubject.y = FormTopMargin;
    [self.scrollView addSubview:self.textFieldSubject];
    
    self.textFieldContent = [[NSUITextView alloc] initWithFrame:CGRectMake(PagePadding, 100*[UIView scale], FullWidthExcludePadding, 150)];
    self.textFieldContent.placeholder = PlaceHolder;
    self.textFieldContent.textContainer.lineFragmentPadding = PagePadding;
    [self.scrollView addSubviewV:self.textFieldContent margin:1];
    
    self.cameraView = [[UIImageView alloc] initWithFrame:CGRectMake(PagePadding, self.textFieldContent.bottom+PagePadding, 40, 40)];
    self.cameraView.image = [UIImage imageNamed:@"attachment"];
    self.cameraView.contentMode = UIViewContentModeCenter;
    [self.scrollView addSubview:self.cameraView];

    self.labelAttachment = [[UILabel alloc] initWithFrame:CGRectMake(self.cameraView.right, self.cameraView.y, 100, 40)];
    self.labelAttachment.text = @"Attach a photo";
    [self.labelAttachment styleTableViewRowTag];
    [self.scrollView addSubview:self.labelAttachment];

    containerView = [self maskViews:[NSArray arrayWithObjects:self.textFieldSubject, self.textFieldContent, nil]];
    [self.scrollView addSubview:containerView];

    return self;
}

-(void)addImage:(UIImage *)img {
    CGFloat imgSize = ([UIView screenWidth] - 4 * PagePadding)/3;
    
    CGFloat x = (self.images.count%3) * (imgSize + PagePadding) + PagePadding;
    CGFloat y = self.cameraView.bottom + PagePadding;
    y += (self.images.count/3 * (imgSize + PagePadding));
    
    UIImageView* imgView = [[UIImageView alloc] initWithFrame:CGRectMake(x, y, imgSize, imgSize)];
    imgView.contentMode = UIViewContentModeScaleAspectFit;
    imgView.image = img;
    imgView.tag = self.images.count;
    [self.images addObject:imgView];
    [imgView addTarget:self action:@selector(editImage:)];
    
    [self.scrollView addSubview:imgView];
    self.scrollView.contentSize = CGSizeMake(self.width, imgView.bottom);
}

-(void)editImage:(UITapGestureRecognizer*) ges {
}

-(NSString*)getReviewText {
    if ([self.textFieldContent.text isEqualToString:@""] || [self.textFieldContent.text isEqualToString:PlaceHolder]) {
        return nil;
    }
    return self.textFieldContent.text;
}

@end
