//
//  PortalViewController.m
//  IASIS
//
//  Created by Tyler Hall on 12/9/14.
//  Copyright (c) 2014 IASIS Healthcare Corporation. All rights reserved.
//

#import "PortalViewController.h"
#import "PortalHeaderCell.h"
#import "PortalStateCell.h"
#import "PortalFooterCell.h"

@interface PortalViewController () <UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>

@property (nonatomic, weak) IBOutlet UICollectionView *collectionView;

@property (nonatomic, strong) NSArray *states;
@property (nonatomic, strong) NSArray *urls;

@end

@implementation PortalViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationItem.title = @"Patient Portal";
    
    [self.collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([PortalHeaderCell class]) bundle:nil] forCellWithReuseIdentifier:NSStringFromClass([PortalHeaderCell class])];
    [self.collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([PortalStateCell class]) bundle:nil] forCellWithReuseIdentifier:NSStringFromClass([PortalStateCell class])];
    [self.collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([PortalFooterCell class]) bundle:nil] forCellWithReuseIdentifier:NSStringFromClass([PortalFooterCell class])];

    self.states = @[ @"Hope, AR", @"AZ", @"West Monroe, LA", @"UT", @"Houston, TX", @"Odessa, TX", @"Port Arthur, TX", @"San Antonio, TX", @"Texarkana, TX" ];
    self.urls = @[ @"http://mywadleyathope.com/", @"http://patientportalaz.com/", @"http://mygrmc.com/", @"http://patientportalut.com/", @"http://mysjmc.com/", @"http://yourormc.com/", @"http://mymcst.com/", @"http://myswgh.com/", @"http://mywadley.com/" ];
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 3;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if(section == 0) {
        return 1;
    }
    
    if(section == 1) {
        return self.states.count;
    }
    
    if(section == 2) {
        return 1;
    }
    
    return 0;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.section == 0) {
        PortalHeaderCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([PortalHeaderCell class]) forIndexPath:indexPath];
        return cell;
    }

    if(indexPath.section == 1) {
        PortalStateCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([PortalStateCell class]) forIndexPath:indexPath];
        cell.lblTitle.text = [NSString stringWithFormat:@"Patient Portal %@", self.states[indexPath.row]];
        return cell;
    }
    
    if(indexPath.section == 2) {
        PortalFooterCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([PortalFooterCell class]) forIndexPath:indexPath];
        return cell;
    }
    
    return nil;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.section == 0) {
        return CGSizeMake(collectionView.bounds.size.width, 150.0);
    }

    if(indexPath.section == 1) {
        return CGSizeMake(collectionView.bounds.size.width, 60.0);
    }

    if(indexPath.section == 2) {
        return CGSizeMake(collectionView.bounds.size.width, 500.0);
    }
    
    return CGSizeZero;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.section == 1) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:self.urls[indexPath.row]]];
    }
}

@end
