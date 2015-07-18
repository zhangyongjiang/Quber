#import <UIKit/UIKit.h>
#import "BaseViewController.h"

@interface WebViewController : BaseViewController  <UIWebViewDelegate>

@property(strong,nonatomic) NSString* url;
@property(strong,nonatomic) UIWebView *webView;

@end
