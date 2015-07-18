//
//  NSSlidePanelController.m
//  Next Shopper
//
//  Created by Kevin Zhang on 10/12/14.
//  Copyright (c) 2014 Gaoshin. All rights reserved.
//

#import "NSSlidePanelController.h"
#import "NavigationControllerBase.h"

@interface NSSlidePanelController ()

@end

@implementation NSSlidePanelController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)setState:(JASidePanelState)state
{
    [super setState:state];
    NavigationControllerBase* navController = (NavigationControllerBase*)self.centerPanel;
    [navController setEnabled:(state == JASidePanelCenterVisible)];
}

-(void)setCenterPanel:(UIViewController *)centerPanel {
    [super setCenterPanel:centerPanel];
    centerPanel.accessibilityLabel = @"centerPanel";
}
@end
