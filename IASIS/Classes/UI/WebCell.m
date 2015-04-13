//
//  WebCell.m
//  IASIS
//
//  Created by Tyler Hall on 12/10/14.
//  Copyright (c) 2014 IASIS Healthcare Corporation. All rights reserved.
//

#import "WebCell.h"

@interface WebCell ()

@property (nonatomic, weak) IBOutlet UIWebView *webView;

@end

@implementation WebCell

- (void)setUrl:(NSURL *)url
{
    _url = url;

    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:url];
    [self.webView loadRequest:urlRequest];
}

@end
