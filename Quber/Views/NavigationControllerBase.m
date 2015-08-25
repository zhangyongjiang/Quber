//
//  NavigationControllerBase.m
//  Next Shopper
//
//  Created by Kevin Zhang on 10/12/14.
//  Copyright (c) 2014 Gaoshin. All rights reserved.
//

#import "NavigationControllerBase.h"
#import "CoverView.h"
#import "UIImage+ImageEffects.h"

@interface NavigationControllerBase() <UIGestureRecognizerDelegate>

@property(strong, nonatomic)CoverView* cover;

@end

@interface NavigationControllerBase ()

@end

@implementation NavigationControllerBase

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationBar.tintColor = [UIColor mainColor];
    self.navigationBar.titleTextAttributes = [NSDictionary dictionaryWithObjectsAndKeys:
                                              [UIFont fontWithName:FontMedium size:17.0],
                                              NSFontAttributeName,
                                              nil];
    self.cover = [[CoverView alloc] initWithFrame:self.view.bounds];
    self.cover.hidden = YES;
    self.cover.alpha = 0;
    [self.view addSubview:self.cover];
    [self.view bringSubviewToFront:self.cover];
    
    [self addGoHomeButton];
//    [self addAutoTestButton];
}

-(void)addGoHomeButton {
    CGFloat width = 40;
    UIView* testView = [[UIView alloc] initWithFrame:CGRectMake(([UIView screenWidth]-width)/2, 0, width, 64)];
    [self.view addSubview:testView];
    testView.backgroundColor  = [UIColor clearColor];
    [testView addTarget:self action:@selector(goHome:)];
    
//    UIImageView* imgView = [[UIImageView alloc] initWithFrame:CGRectMake(([UIView screenWidth]-width)/2, 20, width, 44)];
//    imgView.image = [UIImage imageNamed:@"menu"];
//    [self.view addSubview:imgView];
//    imgView.backgroundColor  = [UIColor clearColor];
//    [imgView addTarget:self action:@selector(goHome:)];
}

-(void)addAutoTestButton {
    UIView* testView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
    [self.view addSubview:testView];
    [testView alignParentBottomWithMarghin:0];
    [self.view bringSubviewToFront:testView];
    testView.backgroundColor  = [UIColor clearColor];
    [testView addTarget:self action:@selector(handleLongPress)];
}

-(void)handleLongPress {
    if ([self.topViewController respondsToSelector:@selector(handleEvent:fromSource:data:)]) {
    }
}

-(void) goHome:(id)sender {
}

-(void)setEnabled:(BOOL)enabled
{
//    return;
    if (enabled == self.cover.hidden) {
        return;
    }
    if(!enabled) {
        self.cover.hidden = NO;
        __block UIImage* image = [self.view toImage];
        UIColor *tintColor = [UIColor colorWithWhite:0.32 alpha:0.73];
        image = [image applyBlurWithRadius:10 tintColor:tintColor saturationDeltaFactor:1.8 maskImage:nil];

        [UIView animateWithDuration:0.5f animations:^{
            self.cover.backgroundColor = [UIColor colorWithPatternImage:image];
            self.cover.alpha = 1;
        } completion:^(BOOL finished) {
        }];
    }
    else {
        [UIView animateWithDuration:0.5f animations:^{
            self.cover.alpha = 0;
        } completion:^(BOOL finished) {
            self.cover.hidden = YES;
        }];
    }
}

-(void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    [super pushViewController:viewController animated:animated];
    [self checkTutorialForController:viewController];
}

-(void)presentViewController:(UIViewController *)viewControllerToPresent animated:(BOOL)flag completion:(void (^)(void))completion {
    [super presentViewController:viewControllerToPresent animated:flag completion:completion];
}

-(void)autoNext:(NSObject*)obj {
    BaseViewController* bc = (BaseViewController*)obj;
    [bc handleEvent:@"Auto" fromSource:self data:nil];
}

-(void)setViewControllers:(NSArray *)viewControllers {
    [super setViewControllers:viewControllers];
    [self checkTutorialForController:self.topViewController];
}

-(void)checkTutorialForController:(UIViewController *)viewController {
}

-(void)tutorialClicked:(UITapGestureRecognizer*)sender {
    [sender.view removeFromSuperview];
}

-(UIViewController*)popViewControllerAnimated:(BOOL)animated {
    UIViewController* controller = [super popViewControllerAnimated:animated];
    if ([controller isKindOfClass:[BaseViewController class]]) {
        BaseViewController* bc = (BaseViewController *) controller;
        [bc cancelAllOperations];
    }
    [[NSNotificationCenter defaultCenter] removeObserver:controller];
    return controller;
}

-(NSArray*)popToRootViewControllerAnimated:(BOOL)animated {
    NSArray* controllers = [super popToRootViewControllerAnimated:animated];
    return controllers;
}
@end
