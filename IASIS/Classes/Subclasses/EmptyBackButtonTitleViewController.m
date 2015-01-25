//
//  EmptyBackButtonTitleViewController.m
//  IASIS
//
//  Created by Tyler Hall on 1/25/15.
//  Copyright (c) 2015 IASIS Healthcare Corporation. All rights reserved.
//

#import "EmptyBackButtonTitleViewController.h"

@implementation EmptyBackButtonTitleViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] init];
    backButton.title = @" ";
    self.navigationItem.backBarButtonItem = backButton;
}

@end
