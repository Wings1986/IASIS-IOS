//
//  HospitalInfoViewController.m
//  IASIS
//
//  Created by Tyler Hall on 12/10/14.
//  Copyright (c) 2014 IASIS Healthcare Corporation. All rights reserved.
//

#import "HospitalInfoViewController.h"
#import "FindHospitalInfoCell.h"
#import "MyERWaitCell.h"
#import "WebCell.h"

@interface HospitalInfoViewController () <UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>

@property (nonatomic, weak) IBOutlet UICollectionView *collectionView;

@end

@implementation HospitalInfoViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationItem.title = @"Find a Hospital";

    [self.collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([FindHospitalInfoCell class]) bundle:nil] forCellWithReuseIdentifier:NSStringFromClass([FindHospitalInfoCell class])];
    [self.collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([MyERWaitCell class]) bundle:nil] forCellWithReuseIdentifier:NSStringFromClass([MyERWaitCell class])];
    [self.collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([WebCell class]) bundle:nil] forCellWithReuseIdentifier:NSStringFromClass([WebCell class])];
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 3;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.section == 0) {
        FindHospitalInfoCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([FindHospitalInfoCell class]) forIndexPath:indexPath];
        
        cell.lblName.text = self.hospital[@"name"];
        if(self.hospital[@"displayName"]) {
            cell.lblName.text = self.hospital[@"displayName"];
        }
        
        NSArray *parts = [self.hospital[@"info"] componentsSeparatedByString:@"\n"];
        cell.lblAddress1.text = parts[0];
        cell.lblAddress2.text = parts[1];
        cell.lblPhone.text = parts[2];
        cell.image.image = [UIImage imageNamed:self.hospital[@"image"]];
        
        return cell;
    }
    
    if(indexPath.section == 1) {
        MyERWaitCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([MyERWaitCell class]) forIndexPath:indexPath];

        [cell fetchER:self.hospital[@"er"]];

        [cell.btnCheckIn addTarget:self action:@selector(checkIn:) forControlEvents:UIControlEventTouchUpInside];
        [cell.btnDirections addTarget:self action:@selector(directions:) forControlEvents:UIControlEventTouchUpInside];

        return cell;
    }
    
    if(indexPath.section == 2) {
        WebCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([WebCell class]) forIndexPath:indexPath];
        cell.url = [NSURL URLWithString:[self.hospital[@"url"] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]]];
        return cell;
    }
    
    return nil;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.section == 2) {
        return CGSizeMake(collectionView.bounds.size.width, 500.0);
    }
    
    NSLog(@"%@", self.hospital);

    if(indexPath.section == 1 && ![self.hospital[@"er"] containsString:@"http"]) {
        return CGSizeMake(collectionView.bounds.size.width, 1.0);
    }
    
    return CGSizeMake(collectionView.bounds.size.width, 120.0);
}

- (IBAction)checkIn:(id)sender
{
    NSURL *url = [NSURL URLWithString:self.hospital[@"checkin"]];
    [[UIApplication sharedApplication] openURL:url];
}

- (IBAction)directions:(id)sender
{
    NSArray *parts = [self.hospital[@"info"] componentsSeparatedByString:@"\n"];
    NSString *address = [NSString stringWithFormat:@"%@ %@", parts[0], parts[1]];
    address = [address stringByReplacingOccurrencesOfString:@" " withString:@"+"];
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://maps.apple.com/?q=%@", address]];
    [[UIApplication sharedApplication] openURL:url];
}

@end
