#import "WebViewController.h"
#import "SVProgressHUD.h"

@interface WebViewController () <UIWebViewDelegate>
{
    UIWebView *webView;
}
@end

@implementation WebViewController

-(void)createPage {
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.backgroundColor = [UIColor whiteColor];
    webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 64, self.view.width, self.view.height-64) ];
    webView.scalesPageToFit = YES;
    
    [self.view addSubview:webView];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self setup];
    [SVProgressHUD show];
    webView.delegate = self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

-(void) setup
{
    [webView setAllowsInlineMediaPlayback:YES];
    [webView setMediaPlaybackRequiresUserAction:NO];
    [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.url]]];
}

-(void)webViewDidFinishLoad:(UIWebView *)webView
{
    [SVProgressHUD popActivity];
    NSLog(@"webViewDidFinishLoad %@", webView.request.URL);
//    [webView stringByEvaluatingJavaScriptFromString: @"alert(document.title)" ];
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    if ([request.HTTPMethod isEqualToString:@"POST"]) {
        NSData *data = request.HTTPBody;
        NSString* s = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        NSLog(@"post data: %@", s);
    }
    return YES;
}

- (void)webViewDidStartLoad:(UIWebView *)webView {
    NSLog(@"webViewDidStartLoad %@", webView.request.URL);
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    NSLog(@"Error : %@",error);
    [webView loadHTMLString:error.description baseURL:[[NSBundle mainBundle] resourceURL]];

}

-(void)viewWillDisappear:(BOOL)animated {
    [webView stopLoading];
}


@end
