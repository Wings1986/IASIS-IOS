//
//  HospitalsViewController.m
//  IASIS
//
//  Created by Tyler Hall on 12/10/14.
//  Copyright (c) 2014 IASIS Healthcare Corporation. All rights reserved.
//

#import "HospitalsViewController.h"
#import "HospitalInfoCell.h"
#import "HospitalInfoCellER.h"
#import "HospitalInfoViewController.h"

@interface HospitalsViewController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, weak) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSArray *hospitals;

@end

@implementation HospitalsViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.navigationItem.title = @"Find a Hospital";

    self.hospitals = @[ @"Some Hospital", @"Some Hospital", @"Some Hospital", @"Some Hospital", @"Some Hospital", @"Some Hospital", ];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.hospitals.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.row % 2 == 0) {
        HospitalInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([HospitalInfoCell class]) forIndexPath:indexPath];
        cell.lblTitle.text = @"Mountain Vista Medical Center";
        cell.lblLocation.text = @"Mesa, AZ";
        [cell.btnInfo addTarget:self action:@selector(info:) forControlEvents:UIControlEventTouchUpInside];
        return cell;
    } else {
        HospitalInfoCellER *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([HospitalInfoCellER class]) forIndexPath:indexPath];
        cell.lblTitle.text = @"St. Luke's Behavioral Health Center";
        cell.lblLocation.text = @"Phoenix, AZ";
        cell.lblWait.text = @"Current ER Wait Time: 20 minutes";
        [cell.btnInfo addTarget:self action:@selector(info:) forControlEvents:UIControlEventTouchUpInside];
        return cell;
    }

    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 20.0;
}

- (BOOL)tableView:(UITableView *)tableView shouldHighlightRowAtIndexPath:(NSIndexPath *)indexPath
{
    return NO;
}

- (IBAction)info:(id)sender
{
    HospitalInfoViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:NSStringFromClass([HospitalInfoViewController class])];
    [self.navigationController pushViewController:vc animated:YES];
}

@end
