//
//  MenuViewController.m
//  IASIS
//
//  Created by Tyler Hall on 12/1/14.
//  Copyright (c) 2014 IASIS Healthcare Corporation. All rights reserved.
//

#import "MenuViewController.h"
#import "MenuTableViewCell.h"
#import "UIColor+Colors.h"

typedef NS_ENUM(NSUInteger, MenuItem) {
    MenuItemMyIASIS,
    MenuItemHospitals,
    MenuItemProviders,
    MenuItemPatientPortal,
    // MenuItemSettings,
    MenuItemCount
};

@interface MenuViewController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, weak) IBOutlet UITableView *tableView;

@end

@implementation MenuViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.automaticallyAdjustsScrollViewInsets = YES;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return MenuItemCount;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MenuTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([MenuTableViewCell class])];
    
    if(indexPath.row == MenuItemMyIASIS) {
        cell.lblTitle.text = @"My IASIS";
        cell.imgIcon.image = [UIImage imageNamed:@"MenuStar"];
    }

    if(indexPath.row == MenuItemHospitals) {
        cell.lblTitle.text = @"Hospitals";
        cell.imgIcon.image = [UIImage imageNamed:@"MenuHospitals"];
    }

    if(indexPath.row == MenuItemProviders) {
        cell.lblTitle.text = @"Providers";
        cell.imgIcon.image = [UIImage imageNamed:@"MenuStethoscope"];
    }

    if(indexPath.row == MenuItemPatientPortal) {
        cell.lblTitle.text = @"Patient Portal";
        cell.imgIcon.image = [UIImage imageNamed:@"MenuKey"];
    }

//    if(indexPath.row == MenuItemSettings) {
//        cell.lblTitle.text = @"Settings";
//        cell.imgIcon.image = [UIImage imageNamed:@"MenuGear"];
//    }
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 55.0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 18.0;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.bounds.size.width, 18)];
    headerView.backgroundColor = [UIColor menuBackgroundColor];
    return headerView;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [self.delegate menuSelectedItem:indexPath.row];
}

@end
