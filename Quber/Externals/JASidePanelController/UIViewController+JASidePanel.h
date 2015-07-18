//
//  UIViewController+JASidePanel.h
//  NextShopperSwift
//
//  Created by Kevin Zhang on 10/15/14.
//  Copyright (c) 2014 Kevin Zhang. All rights reserved.
//

#import <UIKit/UIKit.h>

@class JASidePanelController;

/* This optional category provides a convenience method for finding the current
 side panel controller that your view controller belongs to. It is similar to the
 Apple provided "navigationController" and "tabBarController" methods.
 */
@interface UIViewController (JASidePanel)

// The nearest ancestor in the view controller hierarchy that is a side panel controller.
@property (nonatomic, weak, readonly) JASidePanelController *sidePanelController;

@end
