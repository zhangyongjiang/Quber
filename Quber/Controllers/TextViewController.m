//
//  TextViewController.m
//
//
//  Created by Kevin Zhang on 2/17/15.
//  Copyright (c) 2015 Kevin Zhang. All rights reserved.
//

#import "TextViewController.h"

static NSMutableArray* htmlTags;

@interface TextViewController ()

@property(strong,nonatomic)UILabel* label;
@property(strong,nonatomic)UIImageView* imageView;

@end

@implementation TextViewController

+(void)load {
    htmlTags = [[NSMutableArray alloc] init];
    NSString* tags = @"html body p b h1 h2 h3 h4 h5 u li a div";
    NSArray * array = [tags componentsSeparatedByString:@" "];
    for (NSString* tag in array) {
        [htmlTags addObject:[NSString stringWithFormat:@"</%@>", tag]];
    }
    
}

+(BOOL)isHtmlString:(NSString *)str {
    NSString* low = [str lowercaseString];
    for (NSString* tag in htmlTags) {
        NSRange range = [low rangeOfString:tag];
        if (range.location != NSNotFound) {
            return YES;
        }
    }
    return NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    CGFloat width = 150;
    self.imageView = [[UIImageView alloc] initWithFrame:CGRectMake(PagePadding, PagePadding, width, width)];
    [self.imageView setImageWithPath:self.imgPath];
    
    self.scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    self.scrollView.backgroundColor = [UIColor colorFromString:@"nsbg"];
    [self.view addSubview:self.scrollView];
    
    [self.scrollView addSubview:self.imageView];
    [self.imageView hcenterInParent];
    
    if (self.text) {
        BOOL ishtml = [TextViewController isHtmlString:self.text] && NO;
        if (!ishtml) {
            self.label = [[UILabel alloc] initWithFrame:CGRectMake(PagePadding, self.imageView.bottom + PagePadding, self.view.width-PagePadding*2, 0)];
            [self.label styleMenuItem];
            self.label.textAlignment = NSTextAlignmentLeft;
            self.label.numberOfLines = 0;
            [self.label setText:self.text withLineSpacing:4];
            [self.label fitHeight];
            [self.scrollView addSubview:self.label];
            self.scrollView.contentSize = CGSizeMake(self.view.width, self.label.bottom);
        }
        else {
            self.imageView.y = 74;
            [self.view addSubview:self.imageView];
            [self.imageView hcenterInParent];
            
            UIWebView* webview = [[UIWebView alloc] initWithFrame:CGRectMake(0, self.imageView.bottom+10, [UIView screenWidth], [UIView screenHeight] - self.imageView.bottom-10)];
            webview.backgroundColor = [UIColor bgColor];
            [self.view addSubview:webview];
            [webview loadHTMLString:self.text baseURL:nil];
        }
    }
}
@end
