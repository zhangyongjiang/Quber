//
//  ScrollViewController.m
//
//
//  Created by Kevin Zhang on 1/21/15.
//  Copyright (c) 2015 Kevin Zhang. All rights reserved.
//

#import "ScrollViewController.h"

@interface ScrollViewController ()

@end

@implementation ScrollViewController

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self registerForKeyboardNotifications];
}

- (void)registerForKeyboardNotifications
{
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWasShown:)
                                                 name:UIKeyboardDidShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillBeHidden:)
                                                 name:UIKeyboardWillHideNotification object:nil];
}

- (void)keyboardWasShown:(NSNotification *)notification {
    NSDictionary* info = [notification userInfo];
    CGSize keyboardSize = [[info objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    CGFloat buttonHeight = gCurrentTextField.frame.size.height;
    CGPoint buttonOrigin = [gCurrentTextField.superview convertPoint:gCurrentTextField.frame.origin toView:nil];
    CGFloat buttonBottom = buttonOrigin.y + buttonHeight + self.scrollView.contentOffset.y;
    CGFloat kbtop = self.view.height - keyboardSize.height - buttonHeight - 5;
    if (kbtop < buttonBottom){
        CGPoint scrollPoint = CGPointMake(0.0, buttonBottom - kbtop);
        [self.scrollView setContentOffset:scrollPoint animated:YES];
    }
    
}

- (void)keyboardWillBeHidden:(NSNotification *)notification {
    [self.scrollView setContentOffset:CGPointZero animated:YES];
//    NSDictionary* info = [notification userInfo];
//    CGSize keyboardSize = [[info objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
//    self.scrollView.height -= keyboardSize.height;
}

@end
