//
//  PortalFooterCell.m
//  IASIS
//
//  Created by Tyler Hall on 4/13/15.
//  Copyright (c) 2015 IASIS Healthcare Corporation. All rights reserved.
//

#import "PortalFooterCell.h"

@interface PortalFooterCell () <UIWebViewDelegate>

@property (nonatomic, weak) IBOutlet UIWebView *webView;

@end

@implementation PortalFooterCell

- (void)awakeFromNib
{
    self.webView.delegate = self;
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://www.iasishealthcare.com/app/portal.html"]]];
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    if([[request.URL absoluteString] isEqualToString:@"http://www.iasishealthcare.com/app/portal.html"]) {
        return YES;
    }
    
    [[UIApplication sharedApplication] openURL:request.URL];

    return NO;
}

@end
