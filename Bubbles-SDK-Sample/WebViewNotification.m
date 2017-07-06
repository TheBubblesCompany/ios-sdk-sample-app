//
//  BBWebViewNotificationViewController.m
//  BubblesFrameworkDemo
//
//  Created by Karim Koriche on 21/12/2015.
//  Copyright © 2015 . All rights reserved.
//

#import "WebViewNotification.h"

@interface WebViewNotification () <UIWebViewDelegate>

- (void)close:(UIButton *)sender;

@property (strong, nonatomic) UIWebView *webView;

@end


@implementation WebViewNotification


-(UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.view setBackgroundColor:[UIColor colorWithRed:44.f/255.f
                                                  green:62.f/255.f
                                                   blue:80.f/255.f
                                                  alpha:1.f]];
    
    CGRect screenBound = [[UIScreen mainScreen] bounds];
    _webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 70, screenBound.size.width, screenBound.size.height - 70)];
    [_webView setDelegate:self];
    
    UIButton * btnClose = [[UIButton alloc] initWithFrame:CGRectMake(20, 25, 30, 30)];
    [btnClose setImage:[UIImage imageNamed:@"closeButton"] forState:UIControlStateNormal];
    [btnClose addTarget:self action:@selector(close:) forControlEvents:UIControlEventTouchUpInside];
    
    
    [self.view addSubview:btnClose];
    [self.view addSubview:_webView];

    [self displayWebView];
}


-(void) displayWebView
{
    if(!_infos)
        return;
    
    NSString * webViewURL = [_infos objectForKey:@"url"];

    if(webViewURL)
        [_webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:webViewURL]]];
}


-(void)setWebviewURL:(NSString *)webviewURL
{
    _webviewURL = webviewURL;
    
    if(_webviewURL)
        [_webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:_webviewURL]]];
}

#pragma mark - Actions



- (void)close:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}






@end
