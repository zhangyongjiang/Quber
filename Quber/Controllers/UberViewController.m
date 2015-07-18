//
//  UberViewController.m
//  Quber
//
//  Created by Kevin Zhang on 7/17/15.
//  Copyright (c) 2015 Kevin Zhang. All rights reserved.
//

#import "UberViewController.h"

@interface UberViewController ()

@end

@implementation UberViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"m.uber.com";
    self.url = @"https://m.uber.com/";
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self setupNotificationHandler];
}

-(void)setupNotificationHandler {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(wvtest) name:@"WVTest" object:nil];
}

-(void)wvtest {
    [self closeDialog];
}

-(void)qtest {
    double delayInSeconds = 0.5;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        NSString* js = @"qtest()";
        NSString* result = [self.webView stringByEvaluatingJavaScriptFromString:js];
        NSLog(@"javascript result: %@", result);
    });
}

-(void)closeDialog {
    NSString* js = @"closeDialog()";
    NSString* result = [self.webView stringByEvaluatingJavaScriptFromString:js];
    NSLog(@"javascript result: %@", result);
}

-(void)gotoFareQuotePage {
    double delayInSeconds = 0.5;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        NSString* js = @"gotoFareQuotePage()";
        NSString* result = [self.webView stringByEvaluatingJavaScriptFromString:js];
        NSLog(@"javascript result: %@", result);
    });
}

-(void)cancelPickupLocation {
    double delayInSeconds = 0.5;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        NSString* js = @"cancelPickupLocation()";
        NSString* result = [self.webView stringByEvaluatingJavaScriptFromString:js];
        NSLog(@"javascript result: %@", result);
        if ([result isEqualToString:@"1"]) {
            [self cancelPickupLocation];
        }
    });
}

-(void)gotoPickupLocation {
    NSString* js = @"gotoPickupLocation()";
    NSString* result = [self.webView stringByEvaluatingJavaScriptFromString:js];
    NSLog(@"javascript result: %@", result);
}

-(NSMutableArray*)listVehicles {
        NSString* js = @"listVehicles()";
        NSString* result = [self.webView stringByEvaluatingJavaScriptFromString:js];
        NSLog(@"javascript result: %@", result);
    return nil;
}

-(void)changeVehicle:(int)index {
    NSString* js = [NSString stringWithFormat:@"changeVehicle(%i)", index];
    NSString* result = [self.webView stringByEvaluatingJavaScriptFromString:js];
    NSLog(@"javascript result: %@", result);
}

-(void)getPickupTime {
    NSString* js = @"getPickupTime()";
    NSString* result = [self.webView stringByEvaluatingJavaScriptFromString:js];
    NSLog(@"javascript result: %@", result);
}

-(void)webViewDidFinishLoad:(UIWebView *)webView {
    [super webViewDidFinishLoad:webView];
    NSString *content = [NSString stringWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"util" ofType:@"js"]
                                                  encoding:NSUTF8StringEncoding
                                                     error:nil];
    NSString* result = [self.webView stringByEvaluatingJavaScriptFromString:content];
    NSLog(@"javascript result: %@", result);
}
@end
