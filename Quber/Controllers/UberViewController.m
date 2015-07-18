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
    [self performSelector:@selector(jstest) withObject:nil afterDelay:0.5];
}

-(void)jstest {
//    NSString* js = @"listVehicles()";
    NSString* js = @"changeVehicle(2)";
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
