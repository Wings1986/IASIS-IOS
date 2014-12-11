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
        return cell;
    }
    
    if(indexPath.section == 1) {
        MyERWaitCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([MyERWaitCell class]) forIndexPath:indexPath];
        return cell;
    }
    
    if(indexPath.section == 2) {
        WebCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([WebCell class]) forIndexPath:indexPath];
        cell.url = [NSURL URLWithString:@"http://www.yahoo.com"];
        return cell;
    }
    
    return nil;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.section == 2) {
        return CGSizeMake(collectionView.bounds.size.width, 500.0);
    }
    
    return CGSizeMake(collectionView.bounds.size.width, 120.0);
}

@end
