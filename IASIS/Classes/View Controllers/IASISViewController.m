//
//  IASISViewController.m
//  IASIS
//
//  Created by Tyler Hall on 12/9/14.
//  Copyright (c) 2014 IASIS Healthcare Corporation. All rights reserved.
//

#import "IASISViewController.h"
#import "FirstLaunchViewController.h"

@interface IASISViewController ()

@end

@implementation IASISViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    if(!self.showDefaultLeftBarButton) {
        UIBarButtonItem *hamburger = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"hamburger"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]
                                                                      style:UIBarButtonItemStylePlain
                                                                     target:self
                                                                     action:@selector(hamburger:)];
        self.navigationItem.leftBarButtonItem = hamburger;
    }

    UIBarButtonItem *settings = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"SettingsButton"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]
                                                                  style:UIBarButtonItemStylePlain
                                                                 target:self
                                                                 action:@selector(settings:)];
    self.navigationItem.rightBarButtonItem = settings;
}

- (IBAction)hamburger:(id)sender
{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"HAMBURGER" object:nil];
}

- (IBAction)settings:(id)sender
{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"SETTINGS" object:nil];

    FirstLaunchViewController *vcFirstLaunch = [self.storyboard instantiateViewControllerWithIdentifier:NSStringFromClass([FirstLaunchViewController class])];
    [self presentViewController:vcFirstLaunch animated:YES completion:nil];
    [vcFirstLaunch.btnSkip setTitle:@"Close" forState:UIControlStateNormal];
}

@end
