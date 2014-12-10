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
#import "MenuViewControllerDelegate.h"

#import "PersonalViewController.h"
#import "StatesViewController.h"
#import "ProvidersViewController.h"
#import "PortalViewController.h"
#import "SettingsViewController.h"

@interface InitialViewController () <MenuViewControllerDelegate>

@property (nonatomic, strong) JSSlidingViewController *vcSliding;
@property (nonatomic, strong) PersonalViewController *vcPersonal;
@property (nonatomic, strong) StatesViewController *vcStates;
@property (nonatomic, strong) ProvidersViewController *vcProviders;
@property (nonatomic, strong) PortalViewController *vcPortal;
@property (nonatomic, strong) SettingsViewController *vcSettings;

@end

@implementation InitialViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)viewDidAppear:(BOOL)animated
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(hamburger:) name:@"HAMBURGER" object:nil];
    
    MenuViewController *menuVC = [self.storyboard instantiateViewControllerWithIdentifier:NSStringFromClass([MenuViewController class])];
    menuVC.delegate = self;

    self.vcPersonal = [self.storyboard instantiateViewControllerWithIdentifier:NSStringFromClass([PersonalViewController class])];
    
    self.vcSliding = [[JSSlidingViewController alloc] initWithFrontViewController:self.vcPersonal backViewController:menuVC];
    self.vcSliding.useBouncyAnimations = NO;
    [self presentViewController:self.vcSliding animated:NO completion:nil];
}

- (void)menuSelectedItem:(NSUInteger)index
{
    if(index == 0) {
        if(!self.vcPersonal) {
            self.vcPersonal = [self.storyboard instantiateViewControllerWithIdentifier:NSStringFromClass([PersonalViewController class])];
        }
        [self.vcSliding setFrontViewController:self.vcPersonal animated:YES completion:nil];
    }

    if(index == 1) {
        if(!self.vcStates) {
            self.vcStates = [self.storyboard instantiateViewControllerWithIdentifier:NSStringFromClass([StatesViewController class])];
        }
        [self.vcSliding setFrontViewController:self.vcStates animated:YES completion:nil];
    }

    if(index == 2) {
        if(!self.vcProviders) {
            self.vcProviders = [self.storyboard instantiateViewControllerWithIdentifier:NSStringFromClass([ProvidersViewController class])];
        }
        [self.vcSliding setFrontViewController:self.vcProviders animated:YES completion:nil];
    }

    if(index == 3) {
        if(!self.vcPortal) {
            self.vcPortal = [self.storyboard instantiateViewControllerWithIdentifier:NSStringFromClass([PortalViewController class])];
        }
        [self.vcSliding setFrontViewController:self.vcPortal animated:YES completion:nil];
    }

    if(index == 4) {
        if(!self.vcSettings) {
            self.vcSettings = [self.storyboard instantiateViewControllerWithIdentifier:NSStringFromClass([SettingsViewController class])];
        }
        [self.vcSliding setFrontViewController:self.vcSettings animated:YES completion:nil];
    }
    
    [self.vcSliding closeSlider:YES completion:nil];
}

- (void)hamburger:(NSNotification *)notification
{
    [self.vcSliding openSlider:YES completion:nil];
}

@end
