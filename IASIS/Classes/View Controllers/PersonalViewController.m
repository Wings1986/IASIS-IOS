//
//  PersonalViewController.m
//  IASIS
//
//  Created by Tyler Hall on 12/1/14.
//  Copyright (c) 2014 IASIS Healthcare Corporation. All rights reserved.
//

#import "PersonalViewController.h"
#import "MyMyHospitalCell.h"
#import "MyERWaitCell.h"
#import "MyProviderCell.h"

@interface PersonalViewController ()

@property (nonatomic, weak) IBOutlet UICollectionView *collectionView;

@end

@implementation PersonalViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.navigationItem.title = @"IASIS Healthcare";

    [self.collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([MyMyHospitalCell class]) bundle:nil] forCellWithReuseIdentifier:NSStringFromClass([MyMyHospitalCell class])];
    [self.collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([MyERWaitCell class]) bundle:nil] forCellWithReuseIdentifier:NSStringFromClass([MyERWaitCell class])];
    [self.collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([MyProviderCell class]) bundle:nil] forCellWithReuseIdentifier:NSStringFromClass([MyProviderCell class])];
    [self.collectionView registerNib:[UINib nibWithNibName:@"MyMyProvidersHeader" bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"MyMyProvidersHeader"];
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 3;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if(section == 2) {
        return 100;
    }
    
    return 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.section == 0) {
        MyMyHospitalCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([MyMyHospitalCell class]) forIndexPath:indexPath];
        return cell;
    }

    if(indexPath.section == 1) {
        MyERWaitCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([MyERWaitCell class]) forIndexPath:indexPath];
        return cell;
    }

    if(indexPath.section == 2) {
        MyProviderCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([MyProviderCell class]) forIndexPath:indexPath];
        return cell;
    }

    return nil;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.section == 2) {
        return CGSizeMake(collectionView.bounds.size.width, 130.0);
    }

    return CGSizeMake(collectionView.bounds.size.width, 120.0);
}

- (CGSize) collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    if(section == 2) {
        return CGSizeMake(60.0f, 40.0f);
    }
    
    return CGSizeZero;
}


- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    UICollectionReusableView *view = [collectionView dequeueReusableSupplementaryViewOfKind:kind
                                                     withReuseIdentifier:@"MyMyProvidersHeader"
                                                            forIndexPath:indexPath];
    return view;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
}

@end
