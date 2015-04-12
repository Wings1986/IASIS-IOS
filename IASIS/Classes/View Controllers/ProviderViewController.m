//
//  ProviderViewController.m
//  IASIS
//
//  Created by Tyler Hall on 12/13/14.
//  Copyright (c) 2014 IASIS Healthcare Corporation. All rights reserved.
//

#import "ProviderViewController.h"
#import "MyProviderCell.h"
#import <AFNetworking/UIImageView+AFNetworking.h>

@interface ProviderViewController () <UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>

@property (nonatomic, weak) IBOutlet UICollectionView *collectionView;

@end

@implementation ProviderViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    NSLog(@"%@", self.providerDict);

    self.navigationItem.title = [NSString stringWithFormat:@"%@ %@", self.providerDict[@"first_name"], self.providerDict[@"last_name"]];

    [self.collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([MyProviderCell class]) bundle:nil] forCellWithReuseIdentifier:NSStringFromClass([MyProviderCell class])];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    MyProviderCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([MyProviderCell class]) forIndexPath:indexPath];
    cell.lblName.text = [NSString stringWithFormat:@"%@ %@", self.providerDict[@"first_name"], self.providerDict[@"last_name"]];
    cell.lblSpecialty.text = self.providerDict[@"specialty1"] ? self.providerDict[@"specialty1"] : @"";

    NSString *photURLString = [NSString stringWithFormat:@"%@", self.providerDict[@"photo"]];
    [cell.photo setImageWithURL:[NSURL URLWithString:photURLString] placeholderImage:[UIImage imageNamed:@"doctor_placeholder"]];

    cell.btnSchedule.hidden = YES;
    cell.btnDetails.hidden = YES;
    
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(collectionView.bounds.size.width, 130.0);
}

@end
