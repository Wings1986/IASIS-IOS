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
#import "ERWaitTimes.h"

@interface HospitalsViewController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, weak) IBOutlet UITableView *tableView;
@property (nonatomic, weak) IBOutlet UILabel *lblSubtitle;

@end

@implementation HospitalsViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.navigationItem.title = @"Find a Hospital";
    self.lblSubtitle.text = self.subtitle;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.hospitals.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if([self.hospitals[indexPath.row][@"er"] length] < 8) {
        HospitalInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([HospitalInfoCell class]) forIndexPath:indexPath];
        cell.lblTitle.text = self.hospitals[indexPath.row][@"name"];
        cell.lblLocation.text = [[self.hospitals[indexPath.row][@"info"] componentsSeparatedByString:@"\n"][1] stringByTrimmingCharactersInSet:[NSCharacterSet decimalDigitCharacterSet]];
        [cell.btnInfo addTarget:self action:@selector(info:) forControlEvents:UIControlEventTouchUpInside];
        cell.btnInfo.tag = indexPath.row;
        [cell.btnCheckIn addTarget:self action:@selector(checkIn:) forControlEvents:UIControlEventTouchUpInside];
        cell.btnCheckIn.tag = indexPath.row;
        cell.btnCheckIn.hidden = self.hospitals[indexPath.row][@"checkin"] ? NO : YES;
        return cell;
    } else {
        HospitalInfoCellER *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([HospitalInfoCellER class]) forIndexPath:indexPath];
        cell.lblTitle.text = self.hospitals[indexPath.row][@"name"];
        cell.lblLocation.text = [[self.hospitals[indexPath.row][@"info"] componentsSeparatedByString:@"\n"][1] stringByTrimmingCharactersInSet:[NSCharacterSet decimalDigitCharacterSet]];
        [cell.btnInfo addTarget:self action:@selector(info:) forControlEvents:UIControlEventTouchUpInside];
        cell.btnInfo.tag = indexPath.row;
        [cell fetchER:self.hospitals[indexPath.row][@"er"]];
        [cell.btnCheckIn addTarget:self action:@selector(checkIn:) forControlEvents:UIControlEventTouchUpInside];
        cell.btnCheckIn.tag = indexPath.row;
        cell.btnCheckIn.hidden = self.hospitals[indexPath.row][@"checkin"] ? NO : YES;
        return cell;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if([self.hospitals[indexPath.row][@"er"] length] < 8 ) {
        return 145.0;
    } else {
        return 203.0;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.0;
}

- (BOOL)tableView:(UITableView *)tableView shouldHighlightRowAtIndexPath:(NSIndexPath *)indexPath
{
    return NO;
}

- (IBAction)info:(UIButton *)sender
{
    HospitalInfoViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:NSStringFromClass([HospitalInfoViewController class])];
    vc.hospital = self.hospitals[sender.tag];
    [self.navigationController pushViewController:vc animated:YES];
}

- (IBAction)checkIn:(UIButton *)sender
{
    NSURL *url = [NSURL URLWithString:self.hospitals[sender.tag][@"checkin"]];
    [[UIApplication sharedApplication] openURL:url];
}

@end
