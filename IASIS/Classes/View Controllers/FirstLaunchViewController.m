//
//  FirstLaunchViewController.m
//  IASIS
//
//  Created by Tyler Hall on 5/11/15.
//  Copyright (c) 2015 IASIS Healthcare Corporation. All rights reserved.
//

#import "FirstLaunchViewController.h"

@interface FirstLaunchViewController () <UIPickerViewDataSource, UIPickerViewDelegate>

@property (nonatomic, weak) IBOutlet UIButton *btnLocation;
@property (nonatomic, weak) IBOutlet UIButton *btnHospital;
@property (nonatomic, strong) IBOutlet UIPickerView *pickerView;
@property (nonatomic, strong) UIView *shimView;

@property (nonatomic, strong) NSArray *pickerData;
@property (nonatomic, strong) NSDictionary *data;

@property (nonatomic, assign) BOOL choosingLocation;

@end

@implementation FirstLaunchViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.data = [NSDictionary dictionaryWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Hospitals" ofType:@"plist"]];
    
    self.shimView = [[UIView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:self.shimView];
    UITapGestureRecognizer *tgr = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hidePickerView)];
    [self.shimView addGestureRecognizer:tgr];
    
    self.pickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 162.0)];
    self.pickerView.hidden = YES;
    self.pickerView.delegate = self;
    self.pickerView.dataSource = self;
    [self.view addSubview:self.pickerView];
}

- (void)showPickerView
{
    CGRect frame = CGRectMake(0, 0, self.view.bounds.size.width, 162.0);
    frame.origin.y = self.view.bounds.size.height;

    CGRect newFrame = frame;
    newFrame.origin.y -= self.pickerView.frame.size.height;
    
    [self.pickerView reloadAllComponents];
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
        id selection = self.pickerData[[self.pickerView selectedRowInComponent:0]];
        if(self.choosingLocation) {
            [self.btnLocation setTitle:selection forState:UIControlStateNormal];
        } else {
            [[NSUserDefaults standardUserDefaults] setValue:@([self.pickerView selectedRowInComponent:0]) forKey:@"favoriteHospital"];
            [[NSUserDefaults standardUserDefaults] setValue:[self.btnLocation titleForState:UIControlStateNormal] forKey:@"favoriteLocation"];
            [[NSUserDefaults standardUserDefaults] synchronize];
            [[NSNotificationCenter defaultCenter] postNotificationName:@"FAVORITES" object:nil];
            [self dismissViewControllerAnimated:YES completion:nil];
        }
    }

    [UIView animateWithDuration:0.25 animations:^{
        self.pickerView.frame = newFrame;
    } completion:^(BOOL finished) {
        
    }];
}

- (IBAction)skip:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)chooseLocation:(id)sender
{
    self.choosingLocation = YES;
    self.pickerData = [self.data allKeys];
    [self showPickerView];
}

- (IBAction)chooseHospital:(id)sender
{
    self.choosingLocation = NO;
    self.pickerData = self.data[[self.btnLocation titleForState:UIControlStateNormal]];
    [self showPickerView];
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return self.pickerData.count;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    if([self.pickerData[row] isKindOfClass:[NSString class]]) {
        return self.pickerData[row];
    } else {
        return self.pickerData[row][@"name"];
    }
}

- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component
{
    return self.view.bounds.size.width;
}

@end
