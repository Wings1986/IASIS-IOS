//
//  HospitalsViewController.m
//  IASIS
//
//  Created by Tyler Hall on 12/9/14.
//  Copyright (c) 2014 IASIS Healthcare Corporation. All rights reserved.
//

#import "StatesViewController.h"
#import "StateNameCell.h"
#import "HospitalsViewController.h"

@interface StatesViewController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, weak) IBOutlet UITableView *tableView;
@property (nonatomic, weak) IBOutlet UILabel *lblSubtitle;

@property (nonatomic, strong) NSDictionary *states;

@end

@implementation StatesViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.title = @"Find a Hospital";

    self.states = [[NSDictionary alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Hospitals" ofType:@"plist"]];
    
    NSString *favoriteLocation = [[NSUserDefaults standardUserDefaults] valueForKey:@"favoriteLocation"];
    if(favoriteLocation) {
        HospitalsViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:NSStringFromClass([HospitalsViewController class])];
        vc.hospitals = self.states[favoriteLocation];
        vc.subtitle = [NSString stringWithFormat:@"%@ IASIS Hospitals", favoriteLocation];
        [self.navigationController pushViewController:vc animated:YES];
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.states.allKeys.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    StateNameCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([StateNameCell class])];
    
    NSArray *allKeys = [self.states.allKeys sortedArrayUsingSelector:@selector(compare:)];

    NSString *stateName = allKeys[indexPath.row];

    cell.lblTitle.text = stateName;

    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

    NSArray *allKeys = [self.states.allKeys sortedArrayUsingSelector:@selector(compare:)];

    NSString *stateName = allKeys[indexPath.row];

    HospitalsViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:NSStringFromClass([HospitalsViewController class])];
    vc.hospitals = self.states[stateName];
    vc.subtitle = [NSString stringWithFormat:@"%@ IASIS Hospitals", stateName];
    [self.navigationController pushViewController:vc animated:YES];
}

@end
