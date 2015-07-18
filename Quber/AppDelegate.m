//
//  AppDelegate.m
//  Quber
//
//  Created by Kevin Zhang on 7/17/15.
//  Copyright (c) 2015 Kevin Zhang. All rights reserved.
//

#import "AppDelegate.h"
#import "DetailViewController.h"
#import "UberViewController.h"
#import "NSSlidePanelController.h"
#import "NavigationControllerBase.h"
#import "MenuViewController.h"
#import <CoreLocation/CoreLocation.h>
#import "APBAlertView.h"

@interface AppDelegate ()

@property(strong, nonatomic) NSSlidePanelController* slidePanelController;
@property(strong, nonatomic) NavigationControllerBase* navController;
@property(strong, nonatomic) NSSlidePanelController* resumeController;

@end

@implementation AppDelegate

+(AppDelegate*)getInstance {
    return [UIApplication sharedApplication].delegate;
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    UIWindow* window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    window.backgroundColor = [UIColor whiteColor];
    [window makeKeyAndVisible];
    self.window = window;
    
    CLLocationManager* myLocationManager = [[CLLocationManager alloc] init];
    [myLocationManager requestWhenInUseAuthorization];
    
    self.slidePanelController = [[NSSlidePanelController alloc] init];
    self.slidePanelController.shouldDelegateAutorotateToVisiblePanel = false;
    
    self.navController = [[NavigationControllerBase alloc] init];
    self.slidePanelController.centerPanel = self.navController;
    UberViewController* controller = [[UberViewController alloc] init];
    [self.navController pushViewController:controller animated: YES];
    self.navController.navigationBar.translucent = YES;
    self.slidePanelController.leftPanel = [[MenuViewController alloc] init];

    self.window.rootViewController = self.slidePanelController;
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

-(void) showMenu {
    [self.slidePanelController showLeftPanelAnimated:YES];
}

-(void) showMainView {
    [self.slidePanelController showCenterPanelAnimated:NO];
}

-(void) showViewController:(UIViewController*)controller {
    [self.slidePanelController showCenterPanelAnimated:NO];
    for (UIViewController* c in self.navController.viewControllers) {
        [[NSNotificationCenter defaultCenter] removeObserver:c];
    }
    [self.navController setViewControllers:@[controller]];
}

-(void)alertWithTitle:(NSString *)title andMsg:(NSString *)msg handler:(void (^)(UIAlertAction *action))handler{
    if ([UIAlertController class])
    {
        UIAlertController* alert = [UIAlertController alertControllerWithTitle:title message:msg preferredStyle:UIAlertControllerStyleAlert];
        [alert addAction:[UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleDefault handler:handler]];
        [self.window.rootViewController presentViewController:alert animated:YES completion:^{
        }];
    }
    else
    {
        APBAlertView *alertView = [[APBAlertView alloc]
                                   initWithTitle:title
                                   message:msg
                                   cancelButtonTitle:nil
                                   otherButtonTitles:@[@"OK"]
                                   cancelHandler:^{
                                   }
                                   confirmationHandler:^(NSInteger otherButtonIndex) {
                                       handler(nil);
                                   }];
        [alertView show];
    }
}
@end
