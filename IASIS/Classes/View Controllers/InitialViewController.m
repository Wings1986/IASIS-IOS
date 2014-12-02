//
//  ViewController.m
//  IASIS
//
//  Created by Tyler Hall on 9/17/14.
//  Copyright (c) 2014 IASIS Healthcare. All rights reserved.
//

#import "InitialViewController.h"
#import "JSSlidingViewController.h"
#import "MenuViewController.h"
#import "PersonalViewController.h"

@interface InitialViewController ()

@end

@implementation InitialViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)viewDidAppear:(BOOL)animated
{
    MenuViewController *menuVC = [self.storyboard instantiateViewControllerWithIdentifier:NSStringFromClass([MenuViewController class])];
    PersonalViewController *personalVC = [self.storyboard instantiateViewControllerWithIdentifier:NSStringFromClass([PersonalViewController class])];
    
    JSSlidingViewController *vc = [[JSSlidingViewController alloc] initWithFrontViewController:personalVC backViewController:menuVC];
    [self presentViewController:vc animated:NO completion:nil];
}

@end
