//
//  ProvidersViewController.m
//  IASIS
//
//  Created by Tyler Hall on 12/9/14.
//  Copyright (c) 2014 IASIS Healthcare Corporation. All rights reserved.
//

#import "ProvidersViewController.h"
#import "ProviderResultsViewController.h"

@interface ProvidersViewController () <UITextFieldDelegate>

@property (nonatomic, weak) IBOutlet UITextField *txtLastName;

@end

@implementation ProvidersViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationItem.title = @"Find a Provider";
    
    self.txtLastName.delegate = self;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

- (IBAction)search:(id)sender
{
    ProviderResultsViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:NSStringFromClass([ProviderResultsViewController class])];
    vc.showDefaultLeftBarButton = YES;
    [self.navigationController pushViewController:vc animated:YES];
}

@end
