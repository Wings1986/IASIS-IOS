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

@property (nonatomic, strong) NSArray *states;

@end

@implementation StatesViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.title = @"Find a Hospital";
    

    self.states = @[ @"Arizona", @"Arkansas", @"Colorado", @"Louisiana", @"Nevada", @"Texas", @"Utah" ];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.states.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    StateNameCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([StateNameCell class])];
    
    cell.lblTitle.text = self.states[indexPath.row];

    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

    HospitalsViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:NSStringFromClass([HospitalsViewController class])];
    [self.navigationController pushViewController:vc animated:YES];
}

@end
