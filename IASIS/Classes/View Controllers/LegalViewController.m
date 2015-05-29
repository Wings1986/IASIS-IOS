//
//  LegalViewController.m
//  IASIS
//
//  Created by Tyler Hall on 5/28/15.
//  Copyright (c) 2015 IASIS Healthcare Corporation. All rights reserved.
//

#import "LegalViewController.h"

@interface LegalViewController ()

@property (nonatomic, weak) IBOutlet UIWebView *webView;

@end

@implementation LegalViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.navigationItem.title = @"Legal Notices";
    
    NSURL *url = [NSURL URLWithString:@"http://www.iasishealthcare.com/app/legal.html"];
    [self.webView loadRequest:[NSURLRequest requestWithURL:url]];
}

@end
