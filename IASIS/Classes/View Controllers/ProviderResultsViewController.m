//
//  ProviderResultsViewController.m
//  IASIS
//
//  Created by Tyler Hall on 12/13/14.
//  Copyright (c) 2014 IASIS Healthcare Corporation. All rights reserved.
//

#import "ProviderResultsViewController.h"
#import "ProviderViewController.h"
#import "MyProviderCell.h"
#import <AFNetworking/UIImageView+AFNetworking.h>

@interface ProviderResultsViewController () <UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>

@property (nonatomic, weak) IBOutlet UICollectionView *collectionView;

@end

@implementation ProviderResultsViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.navigationItem.title = @"Provider Search Results";

    [self.collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([MyProviderCell class]) bundle:nil] forCellWithReuseIdentifier:NSStringFromClass([MyProviderCell class])];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.providers.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *provider = self.providers[indexPath.row];
    
    NSString *photURLString = [NSString stringWithFormat:@"%@", provider[@"photo"]];
    
    MyProviderCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([MyProviderCell class]) forIndexPath:indexPath];
    cell.lblName.text = [NSString stringWithFormat:@"%@ %@", provider[@"first_name"], provider[@"last_name"]];
    cell.lblSpecialty.text = provider[@"specialty1"] ? provider[@"specialty1"] : @"";
    [cell.photo setImageWithURL:[NSURL URLWithString:photURLString] placeholderImage:[UIImage imageNamed:@"doctor_placeholder"]];

    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(collectionView.bounds.size.width, 130.0);
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    ProviderViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:NSStringFromClass([ProviderViewController class])];
    vc.showDefaultLeftBarButton = YES;
    [self.navigationController pushViewController:vc animated:YES];
}

@end
