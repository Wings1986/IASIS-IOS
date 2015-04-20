//
//  WebCell.m
//  IASIS
//
//  Created by Tyler Hall on 12/10/14.
//  Copyright (c) 2014 IASIS Healthcare Corporation. All rights reserved.
//

#import "WebCell.h"

@interface WebCell () <UIWebViewDelegate>

@property (nonatomic, weak) IBOutlet UIWebView *webView;

@end

@implementation WebCell

- (void)setUrl:(NSURL *)url
{
    self.webView.delegate = self;
    
    _url = url;

    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:url];
    [self.webView loadRequest:urlRequest];
}

- (void)loadHTML:(NSString *)html
{
    self.webView.delegate = self;

    [self.webView loadHTMLString:html baseURL:nil];
}

- (BOOL)webView:(UIWebView *)inWeb shouldStartLoadWithRequest:(NSURLRequest *)inRequest navigationType:(UIWebViewNavigationType)inType
{
    if(inType == UIWebViewNavigationTypeLinkClicked) {
        NSLog(@"%@", inRequest.URL);
        [[UIApplication sharedApplication] openURL:[inRequest URL]];
        return NO;
    }
    
    return YES;
}

@end
