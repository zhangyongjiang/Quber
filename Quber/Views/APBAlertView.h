//
//  APBAlertView.h
//  ishopping
//
//  Created by Kevin Zhang on 7/10/15.
//  Copyright (c) 2015 Kevin Zhang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface APBAlertView : UIAlertView

- (instancetype)initWithTitle:(NSString *)title
                      message:(NSString *)message
            cancelButtonTitle:(NSString *)cancelButtonTitle
            otherButtonTitles:(NSArray *)otherButtonTitles
                cancelHandler:(void (^)(void))cancelHandler
          confirmationHandler:(void (^)(NSInteger otherButtonIndex))confirmationHandler;

@end