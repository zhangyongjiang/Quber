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
@property(assign,nonatomic)BOOL autoplay;

@end

@implementation UberViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"m.uber.com";
    self.url = @"https://m.uber.com/";
    [self addNavRightButton:@"Scrape" target:self action:@selector(scrape)];
}

-(void)scrape {
    [self runJs:@"listVehicles()" withDealy:0.1 handler:^(NSString *result) {
        NSLog(@"listVehicles: %@", result);
        NSData *data = [result dataUsingEncoding:NSUTF8StringEncoding];
        id json = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        NSLog(@"%@", json);
        self.vehicles = [[NSMutableArray alloc] init];
        for (NSDictionary* dict in json) {
            NSMutableDictionary* mu = [NSMutableDictionary dictionaryWithDictionary:dict];
            [self.vehicles addObject:mu];
        }
        self.autoplay = YES;
        self.currentVehicle = 0;
        [SVProgressHUD show];
        [self fetchVehicles];
    }];
}


-(NSString*)getResult {
    NSMutableString* result = [[NSMutableString alloc] init];
    for (NSDictionary* vehicle in self.vehicles) {
        [result appendString:[vehicle objectForKey:@"name"]];
        
        NSString* pickupTime = [vehicle objectForKey:@"PickupTime"];
        if (pickupTime) {
            [result appendString:@", "];
            [result appendString:pickupTime];
        }
        
        NSString* priceRange = [vehicle objectForKey:@"PriceRange"];
        if (priceRange) {
            [result appendString:@", "];
            [result appendString:priceRange];
        }
        
        [result appendString:@"\n\n"];
    }
    return result;
}

-(void)fetchVehicles {
    if (self.currentVehicle>=self.vehicles.count) {
        [SVProgressHUD dismiss];
        [[AppDelegate getInstance] alertWithTitle:nil andMsg:[self getResult] handler:^(UIAlertAction *action) {
        }];
        self.currentVehicle = 0;
        return;
    }
    
    NSMutableDictionary* mutable = [self.vehicles objectAtIndex:self.currentVehicle];
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
            if(self.autoplay) {
                [self openPickupLocationPage];
            }
        }];
    }];
}

-(void)runJs:(NSString*)javascript withDealy:(double)delayInSeconds handler:(void (^)(NSString* result))handler {
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        NSString* js = javascript;
        NSString* result = [self.webView stringByEvaluatingJavaScriptFromString:js];
        NSLog(@"javascript %@ result: %@", javascript, result);
        handler(result);
    });
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self setupNotificationHandler];
}

-(void)setupNotificationHandler {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(openPickupLocationPage) name:@"Open Pickup Location Page" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(closeConfirmationPage) name:@"Close Confirmation Page" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(openDropOffLocation) name:@"Open Dropoff Location Page" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(closeDropOffLocation) name:@"Close Dropoff Location Page" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(openFaireQuotePage) name:@"Open Fare Quote Page" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(closeFaireQuotePage) name:@"Close Fare Quote Page" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(setAddress) name:@"Set Address" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(selectSearchResult) name:@"Select Search Result" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getPriceRange) name:@"Get Price Range" object:nil];
}

-(void)getPriceRange {
    [self runJs:@"getPriceRange()" withDealy:0.5 handler:^(NSString *result) {
        NSDictionary* dict = [self.vehicles objectAtIndex:self.currentVehicle];
        [dict setValue:result forKey:@"PriceRange"];
        if(self.autoplay) {
            [self closeFaireQuotePage];
        }
    }];
}

-(void)selectSearchResult {
    [self runJs:@"showingDropOffLocation()" withDealy:0.5 handler:^(NSString *result) {
        if ([result isEqualToString:@"true"]) {
            [self runJs:@"selectSearchResult()" withDealy:3 handler:^(NSString *result) {
                [self selectSearchResult];
            }];
        }
        else if (self.autoplay) {
            [self openFaireQuotePage];
        }
    }];
}

-(void)openFaireQuotePage {
    [self runJs:@"showingFareQuote()" withDealy:0.5 handler:^(NSString *result) {
        if (![result isEqualToString:@"true"]) {
            NSString* js = @"gotoFareQuotePage()";
            [self runJs:js withDealy:0.5 handler:^(NSString *result) {
                [self openFaireQuotePage];
            }];
        }
        else if (self.autoplay) {
            [self getPriceRange];
        }
    }];
}

-(void)closeFaireQuotePage {
    [self runJs:@"showingFareQuote()" withDealy:0.5 handler:^(NSString *result) {
        if ([result isEqualToString:@"true"]) {
            [self runJs:@"closeFareQuote()" withDealy:0.5 handler:^(NSString *result) {
                [self closeFaireQuotePage];
            }];
        }
        else if (self.autoplay) {
            [self closeConfirmationPage];
        }
    }];
}

-(void)setAddress {
    NSString* js = @"fillSearchField('944 Industrial Ave, Palo Alto, CA 94303')";
    [self runJs:js withDealy:0.5 handler:^(NSString *result) {
        if (self.autoplay) {
            [self selectSearchResult];
        }
    }];
}

-(void)closeDropOffLocation {
    [self runJs:@"showingDropOffLocation()" withDealy:0.5 handler:^(NSString *result) {
        if ([result isEqualToString:@"true"]) {
            [self runJs:@"closeDropOffLocation()" withDealy:0.5 handler:^(NSString *result) {
                [self closeDropOffLocation];
            }];
        }
    }];
}

-(void)openDropOffLocation {
    [self runJs:@"showingDropOffLocation()" withDealy:0.5 handler:^(NSString *result) {
        if ([result isEqualToString:@"false"]) {
            [self runJs:@"openDropoffLocationPage()" withDealy:0.5 handler:^(NSString *result) {
                [self openDropOffLocation];
            }];
        }
        else if (self.autoplay) {
            [self setAddress];
        }
    }];
}

-(void)closeConfirmationPage {
    [self runJs:@"showingConfirmationPage()" withDealy:0.5 handler:^(NSString *result) {
        if ([result isEqualToString:@"true"]) {
            [self runJs:@"closeConfirmationPage()" withDealy:0.5 handler:^(NSString *result) {
                [self closeConfirmationPage];
            }];
        }
        else if (self.autoplay) {
            self.currentVehicle++;
            [self fetchVehicles];
        }
    }];
}

-(void)qtest {
    double delayInSeconds = 0.5;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        NSString* js = @"qtest()";
        NSString* result = [self.webView stringByEvaluatingJavaScriptFromString:js];
        NSLog(@"javascript %@ result: %@", js, result);
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

-(void)openPickupLocationPage {
    [self runJs:@"showingConfirmationPage()" withDealy:0.5 handler:^(NSString *result) {
        if ([result isEqualToString:@"false"]) {
            NSString* js = @"openPickupLocationPage()";
            [self runJs:js withDealy:0.1 handler:^(NSString *result) {
                [self openPickupLocationPage];
            }];
        }
        else if (self.autoplay) {
            [self openDropOffLocation];
        }
    }];
    
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

-(UITextField*)searchFocusedTextField:(UIView*)view {
    NSLog(@"---- class %@", [view class]);
    if ([view isKindOfClass:[UITextField class]]) {
        UITextField* tf = (UITextField*)view;
        if ([tf isFirstResponder]) {
            return tf;
        }
    }
    for (UIView* child in view.subviews) {
        UITextField* tf = [self searchFocusedTextField:child];
        if (tf) {
            return tf;
        }
    }
    return nil;
}

@end
