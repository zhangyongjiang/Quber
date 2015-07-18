//
//  UberViewController.m
//  Quber
//
//  Created by Kevin Zhang on 7/17/15.
//  Copyright (c) 2015 Kevin Zhang. All rights reserved.
//

#import "UberViewController.h"
#import "SVProgressHUD.h"

@interface UberViewController ()

@property(strong,nonatomic)NSMutableArray* vehicles;
@property(assign,nonatomic)int currentVehicle;

@end

@implementation UberViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"m.uber.com";
    self.url = @"https://m.uber.com/";
    [self addNavRightButton:@"HACK" target:self action:@selector(search)];
}

-(void)search {
//    [self runJs:@"closeDialog()" withDealy:0.5 handler:^(NSString *result) {
//        [self runJs:@"closeDialog()" withDealy:0.5 handler:^(NSString *result) {
            [self runJs:@"listVehicles()" withDealy:0.1 handler:^(NSString *result) {
                NSLog(@"listVehicles: %@", result);
                NSData *data = [result dataUsingEncoding:NSUTF8StringEncoding];
                id json = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
                NSLog(@"%@", json);
                self.vehicles = [NSMutableArray arrayWithArray:json];
                self.currentVehicle = 0;
                [SVProgressHUD show];
                [self fetchVehicles];
            }];
//        }];
//    }];
}


-(NSString*)getResult {
    NSMutableString* result = [[NSMutableString alloc] init];
    for (NSDictionary* vehicle in self.vehicles) {
        [result appendString:[vehicle objectForKey:@"name"]];
        [result appendString:@", "];
        [result appendString:[vehicle objectForKey:@"PickupTime"]];
        [result appendString:@"\n"];
    }
    return result;
}

-(void)fetchVehicles {
    if (self.currentVehicle>=self.vehicles.count) {
        [SVProgressHUD dismiss];
        [[AppDelegate getInstance] alertWithTitle:nil andMsg:[self getResult] handler:^(UIAlertAction *action) {
        }];
        return;
    }
    
    NSDictionary* dict = [self.vehicles objectAtIndex:self.currentVehicle];
    NSMutableDictionary* mutable = [NSMutableDictionary dictionaryWithDictionary:dict];
    [self.vehicles replaceObjectAtIndex:self.currentVehicle withObject:mutable];
    
    if ([[[mutable objectForKey:@"available"] description] isEqualToString:@"0"]) {
        [mutable setValue:@"Not Available" forKey:@"PickupTime"];
        self.currentVehicle++;
        [self fetchVehicles];
        return;
    }
    
    NSString* js = [NSString stringWithFormat:@"changeVehicle(%i)", self.currentVehicle];
    [self runJs:js withDealy:0.5 handler:^(NSString *result) {
        [self runJs:@"getPickupTime()" withDealy:5 handler:^(NSString *result) {
            NSDictionary* dict = [self.vehicles objectAtIndex:self.currentVehicle];
            NSString* pickuptime = [NSString stringWithFormat:@"%@ minutes", result];
            [dict setValue:pickuptime forKey:@"PickupTime"];
            self.currentVehicle++;
            [self fetchVehicles];
        }];
    }];
}

-(void)runJs:(NSString*)javascript withDealy:(double)delayInSeconds handler:(void (^)(NSString* result))handler {
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        NSString* js = javascript;
        NSString* result = [self.webView stringByEvaluatingJavaScriptFromString:js];
        NSLog(@"javascript result: %@", result);
        handler(result);
    });
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self setupNotificationHandler];
}

-(void)setupNotificationHandler {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(wvtest) name:@"WVTest" object:nil];
}

-(void)wvtest {
    [self search];
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
