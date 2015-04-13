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
    if([self.hospitals[indexPath.row][@"er"] isEqualToString:@"http://"]) {
        HospitalInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([HospitalInfoCell class]) forIndexPath:indexPath];
        cell.lblTitle.text = self.hospitals[indexPath.row][@"name"];
        cell.lblLocation.text = [[self.hospitals[indexPath.row][@"info"] componentsSeparatedByString:@"\n"][1] stringByTrimmingCharactersInSet:[NSCharacterSet decimalDigitCharacterSet]];
        [cell.btnInfo addTarget:self action:@selector(info:) forControlEvents:UIControlEventTouchUpInside];
        cell.btnInfo.tag = indexPath.row;
        return cell;
    } else {
        HospitalInfoCellER *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([HospitalInfoCellER class]) forIndexPath:indexPath];
        cell.lblTitle.text = self.hospitals[indexPath.row][@"name"];
        cell.lblLocation.text = [[self.hospitals[indexPath.row][@"info"] componentsSeparatedByString:@"\n"][1] stringByTrimmingCharactersInSet:[NSCharacterSet decimalDigitCharacterSet]];
        [cell.btnInfo addTarget:self action:@selector(info:) forControlEvents:UIControlEventTouchUpInside];
        cell.btnInfo.tag = indexPath.row;
        [cell fetchER:self.hospitals[indexPath.row][@"er"]];
        return cell;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if([self.hospitals[indexPath.row][@"er"] isEqualToString:@"http://"]) {
        return 145.0;
    } else {
        return 203.0;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 20.0;
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

@end
