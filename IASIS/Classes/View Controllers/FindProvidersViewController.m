//
//  ProvidersViewController.m
//  IASIS
//
//  Created by Tyler Hall on 12/9/14.
//  Copyright (c) 2014 IASIS Healthcare Corporation. All rights reserved.
//

#import "FindProvidersViewController.h"
#import "ProviderResultsViewController.h"
#import "UIColor+Colors.h"
#import "ProviderSearchClient.h"
#import "WaitSpinner.h"
#import "UIViewController+Alerts.h"

@interface FindProvidersViewController () <UITextFieldDelegate, UIPickerViewDataSource, UIPickerViewDelegate>

@property (nonatomic, strong) IBOutlet UIPickerView *pickerView;
@property (nonatomic, weak) IBOutlet UIButton *btnState;
@property (nonatomic, weak) IBOutlet UIButton *btnCity;
@property (nonatomic, weak) IBOutlet UIButton *btnSpecialty;
@property (nonatomic, weak) IBOutlet UITextField *txtLastName;
@property (nonatomic, strong) NSDictionary *providerLocations;
@property (nonatomic, strong) UIView *shimView;
@property (nonatomic, strong) UIButton *selectedButton;
@property (nonatomic, weak) IBOutlet UIButton *btnSearch;
@property (nonatomic, weak) IBOutlet UIButton *btnClear;

@property (nonatomic, strong) NSArray *pickerData;

@property (nonatomic, strong) NSMutableArray *specialties;
@property (nonatomic, strong) NSDictionary *rawResponseData;

@end

@implementation FindProvidersViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.navigationItem.title = @"Find a Provider";
    
    [self styleTextField:self.txtLastName withPlaceholder:@"Provider's Last Name..."];

    self.providerLocations = [[NSDictionary alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"ProviderLocations" ofType:@"plist"]];
    
    self.shimView = [[UIView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:self.shimView];
    UITapGestureRecognizer *tgr = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hidePickerView)];
    [self.shimView addGestureRecognizer:tgr];
    self.shimView.hidden = YES;

    self.pickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 162.0)];
    self.pickerView.hidden = YES;
    self.pickerView.delegate = self;
    self.pickerView.dataSource = self;
    [self.view addSubview:self.pickerView];
 
    self.txtLastName.layer.borderWidth = 1.0;
    self.txtLastName.layer.cornerRadius = 4.0;
    
    self.btnSearch.backgroundColor = [UIColor colorWithRed:0.09 green:0.4 blue:0.69 alpha:1];
    self.btnSearch.layer.borderWidth = 0.0;
    self.btnSearch.layer.cornerRadius = 4.0;
    [self.btnSearch setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];

    self.btnClear.backgroundColor = [UIColor grayColor];
    self.btnClear.layer.borderWidth = 0.0;
    self.btnClear.layer.cornerRadius = 4.0;
    [self.btnClear setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    [self fetchSpecialties];
    
    NSString *favoriteLocation = [[NSUserDefaults standardUserDefaults] valueForKey:@"favoriteLocation"];
    if(favoriteLocation) {
        [self.btnState setTitle:[NSString stringWithFormat:@"  %@", favoriteLocation] forState:UIControlStateNormal];
    }
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

- (IBAction)state:(id)sender
{
    self.selectedButton = sender;
    self.pickerData = [self.providerLocations.allKeys sortedArrayUsingSelector:@selector(compare:)];
    [self.pickerView reloadAllComponents];
    [self showPickerView];
}

- (IBAction)city:(id)sender
{
    self.selectedButton = sender;
    self.pickerData = @[];
    if(self.providerLocations[[[self.btnState titleForState:UIControlStateNormal] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]]]) {
        NSString *selection = [[self.btnState titleForState:UIControlStateNormal] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        self.pickerData = self.providerLocations[selection];
    }
    self.pickerData = [self.pickerData sortedArrayUsingSelector:@selector(compare:)];
    [self.pickerView reloadAllComponents];
    [self showPickerView];
}

- (IBAction)specialty:(id)sender
{
    self.selectedButton = sender;
    self.pickerData = @[];
    self.pickerData = self.specialties;
    [self.pickerView reloadAllComponents];
    [self showPickerView];
}

- (IBAction)search:(id)sender
{
    [[WaitSpinner sharedObject] wait];

    NSString *state = [[self.btnState titleForState:UIControlStateNormal] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    NSString *city = [[self.btnCity titleForState:UIControlStateNormal] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    NSString *specialty = [[self.btnSpecialty titleForState:UIControlStateNormal] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];

    NSString *parentSpecialty = @"";
    NSString *subSpecialty = @"";

    if([state isEqualToString:@"State"]) {
        state = @"";
    }

    if([city isEqualToString:@"City"]) {
        city = @"";
    }

    if([specialty isEqualToString:@"Specialty"]) {
        parentSpecialty = @"";
        subSpecialty = @"";
    } else {
        BOOL isParent;

        for(__strong NSString *s in self.specialties) {
            s = [s stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];

            isParent = (self.rawResponseData[s] != nil);
            
            if(isParent) {
                parentSpecialty = s;
            } else {
                subSpecialty = s;
            }
            
            if([specialty isEqualToString:s] && isParent) {
                parentSpecialty = s;
                subSpecialty = @"";
                break;
            }

            if([specialty isEqualToString:s] && !isParent) {
                break;
            }
        }
    }

    [[ProviderSearchClient sharedObject] searchWithState:state city:city specialty:parentSpecialty subspecialty:subSpecialty lastName:self.txtLastName.text successBlock:^(id responseObject) {
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

- (void)fetchSpecialties
{
    [[WaitSpinner sharedObject] wait];
    
    if(!self.specialties) {
        self.specialties = [@[] mutableCopy];
    }
    [self.specialties removeAllObjects];

    NSString *state = [[self.btnState titleForState:UIControlStateNormal] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    NSString *city = [[self.btnCity titleForState:UIControlStateNormal] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    if([state isEqualToString:@"State"]) {
        state = @"";
    }
    
    if([city isEqualToString:@"City"]) {
        city = @"";
    }

    [[ProviderSearchClient sharedObject] specialtiesWithState:state city:city successBlock:^(NSDictionary *responseObject) {
        self.rawResponseData = [responseObject copy];
        for(NSString *key in [responseObject.allKeys sortedArrayUsingSelector:@selector(compare:)]) {
            if([responseObject[key] isKindOfClass:[NSDictionary class]]) {
                [self.specialties addObject:key];
                for(NSString *subkey in ((NSDictionary *)responseObject[key]).allKeys) {
                    [self.specialties addObject:subkey];
                }
            }
        }

        [[WaitSpinner sharedObject] unwait];
    } failureBlock:^(NSError *error) {
        [[WaitSpinner sharedObject] unwait];
    }];
}

- (void)showPickerView
{
    CGRect frame = CGRectMake(0, 0, self.view.bounds.size.width, 162.0);
    frame.origin.y = self.view.bounds.size.height;
    
    CGRect newFrame = frame;
    newFrame.origin.y -= self.pickerView.frame.size.height;

    self.pickerView.frame = frame;
    self.pickerView.hidden = NO;
    
    [UIView animateWithDuration:0.25 animations:^{
        self.pickerView.frame = newFrame;
    } completion:^(BOOL finished) {
        self.shimView.hidden = NO;
    }];
}

- (void)hidePickerView
{
    CGRect newFrame = self.pickerView.frame;
    newFrame.origin.y = self.view.bounds.size.height;

    self.shimView.hidden = YES;
    
    if(self.pickerData.count > 0) {
        NSString *selection = self.pickerData[[self.pickerView selectedRowInComponent:0]];
        [self.selectedButton setTitle:[NSString stringWithFormat:@"   %@", selection] forState:UIControlStateNormal];
    }
    
    [UIView animateWithDuration:0.25 animations:^{
        self.pickerView.frame = newFrame;
    } completion:^(BOOL finished) {
        
    }];
    
    if(self.selectedButton != self.btnSpecialty) {
        [self fetchSpecialties];
    }
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return self.pickerData.count;
}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view
{
    UILabel *label = [[UILabel alloc] initWithFrame:view.bounds];
    label.text = self.pickerData[row];
    label.textAlignment = NSTextAlignmentCenter;

    if(self.selectedButton == self.btnSpecialty) {
        if(self.rawResponseData[label.text] != nil) {
            label.textColor = [UIColor colorWithRed:23.0 / 255.0 green:102.0 / 255.0 blue:176.0 / 255.0 alpha:1.0];
        } else {
            label.textColor = [UIColor colorWithRed:128.0 / 255.0 green:128.0 / 255.0 blue:128.0 / 255.0 alpha:1.0];
        }
    }

    return label;
}

- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component
{
    return self.view.bounds.size.width;
}

- (IBAction)clear:(id)sender
{
    [self.btnState setTitle:@"   State" forState:UIControlStateNormal];
    [self.btnCity setTitle:@"   City" forState:UIControlStateNormal];
    [self.btnSpecialty setTitle:@"   Specialty" forState:UIControlStateNormal];
    self.txtLastName.text = @"";
}

@end
