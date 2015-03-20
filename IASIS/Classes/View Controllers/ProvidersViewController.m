//
//  ProvidersViewController.m
//  IASIS
//
//  Created by Tyler Hall on 12/9/14.
//  Copyright (c) 2014 IASIS Healthcare Corporation. All rights reserved.
//

#import "ProvidersViewController.h"
#import "ProviderResultsViewController.h"
#import "UIColor+Colors.h"
#import "ProviderSearchClient.h"
#import "WaitSpinner.h"
#import "UIViewController+Alerts.h"

@interface ProvidersViewController () <UITextFieldDelegate>

@property (nonatomic, weak) IBOutlet UITextField *txtState;
@property (nonatomic, weak) IBOutlet UITextField *txtCity;
@property (nonatomic, weak) IBOutlet UITextField *txtSpecialty;
@property (nonatomic, weak) IBOutlet UITextField *txtLastName;

@end

@implementation ProvidersViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationItem.title = @"Find a Provider";
    
    [self styleTextField:self.txtState withPlaceholder:@"Provider's State..."];
    [self styleTextField:self.txtCity withPlaceholder:@"Provider's City..."];
    [self styleTextField:self.txtSpecialty withPlaceholder:@"Provider's Specialty..."];
    [self styleTextField:self.txtLastName withPlaceholder:@"Provider's Last Name..."];
}

- (void)styleTextField:(UITextField *)textField withPlaceholder:(NSString *)placeholder
{
    textField.delegate = self;
    textField.layer.borderColor = [UIColor textFieldColor].CGColor;
    textField.layer.borderWidth = 1.0;
    NSAttributedString *str = [[NSAttributedString alloc] initWithString:placeholder attributes:@{ NSForegroundColorAttributeName : [UIColor textFieldColor] }];
    textField.attributedPlaceholder = str;
    
    UIView *paddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 12, 20)];
    textField.leftView = paddingView;
    textField.leftViewMode = UITextFieldViewModeAlways;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

- (IBAction)search:(id)sender
{
    [[WaitSpinner sharedObject] wait];

    [[ProviderSearchClient sharedObject] searchWithState:self.txtState.text city:self.txtCity.text specialty:self.txtSpecialty.text lastName:self.txtLastName.text successBlock:^(id responseObject) {
        [[WaitSpinner sharedObject] unwait];

        ProviderResultsViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:NSStringFromClass([ProviderResultsViewController class])];
        vc.showDefaultLeftBarButton = YES;
        vc.providers = responseObject[@"providers"];
        
        if(vc.providers.count == 0) {
            [self TDM_presentOkAlertControllerWithTitle:@"No Results Found" message:@"No providers matching your search criteria were found." handler:nil];
        } else {
            [self.navigationController pushViewController:vc animated:YES];
        }
    } failureBlock:^(NSError *error) {
        [[WaitSpinner sharedObject] unwait];
        [self TDM_presentOkAlertControllerWithTitle:@"Error" message:@"An error occurred while fetching your search results. Please try again." handler:nil];
    }];
}

@end
