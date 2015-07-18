//
//  AppDelegate.h
//  Quber
//
//  Created by Kevin Zhang on 7/17/15.
//  Copyright (c) 2015 Kevin Zhang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

+(AppDelegate*)getInstance;
-(void) showMenu ;
-(void) showMainView;
-(void) showViewController:(UIViewController*)controller;
-(void) alertWithTitle:(NSString *)title andMsg:(NSString *)msg handler:(void (^)(UIAlertAction *action))handler;

@end

