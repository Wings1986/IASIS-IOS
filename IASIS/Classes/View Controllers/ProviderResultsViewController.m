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
#import "Provider.h"

@interface ProviderResultsViewController () <UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>

@property (nonatomic, weak) IBOutlet UICollectionView *collectionView;

@end

@implementation ProviderResultsViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.navigationItem.title = @"Provider Search Results";

    [self.collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([MyProviderCell class]) bundle:nil] forCellWithReuseIdentifier:NSStringFromClass([MyProviderCell class])];

    // NSLog(@"%@", self.providers);
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self.collectionView reloadData];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.providers.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *provider = self.providers[indexPath.row];

    NSString *photURLString = [NSString stringWithFormat:@"http://directory.iasishealthcare.com/images/physicians/%@", provider[@"photo"]];
    
    MyProviderCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([MyProviderCell class]) forIndexPath:indexPath];
    cell.lblName.text = [NSString stringWithFormat:@"%@ %@, %@", provider[@"first_name"], provider[@"last_name"], provider[@"credentials"]];
    cell.lblSpecialty.text = provider[@"specialty1"] ? provider[@"specialty1"] : @"";
    [cell.photo setImageWithURL:[NSURL URLWithString:photURLString] placeholderImage:[UIImage imageNamed:@"doctor_placeholder"]];
    
    cell.btnDetails.tag = indexPath.row;
    [cell.btnDetails addTarget:self action:@selector(details:) forControlEvents:UIControlEventTouchUpInside];

    cell.btnStar.tag = indexPath.row;
    [cell.btnStar addTarget:self action:@selector(star:) forControlEvents:UIControlEventTouchUpInside];

    Provider *fetchedProvider = [Provider objectForPrimaryKey:provider[@"id"]];
    if(fetchedProvider) {
        [cell.btnStar setSelected:YES];
    } else {
        [cell.btnStar setSelected:NO];
    }
    
    if([provider[@"appointment_url"] isKindOfClass:[NSNull class]]) {
        cell.btnSchedule.hidden = YES;
    } else if([provider[@"appointment_url"] containsString:@"://"]) {
        cell.btnSchedule.hidden = NO;
        [cell.btnSchedule addTarget:self action:@selector(schedule:) forControlEvents:UIControlEventTouchUpInside];
    } else {
        cell.btnSchedule.hidden = YES;
    }

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
    vc.providerDict = self.providers[indexPath.row];
    [self.navigationController pushViewController:vc animated:YES];
}

- (IBAction)schedule:(UIButton *)sender
{
    NSDictionary *provider = self.providers[sender.tag];
    NSURL *url = [NSURL URLWithString:provider[@"appointment_url"]];
    [[UIApplication sharedApplication] openURL:url];
}

- (IBAction)details:(UIButton *)sender
{
    ProviderViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:NSStringFromClass([ProviderViewController class])];
    vc.showDefaultLeftBarButton = YES;
    vc.providerDict = self.providers[sender.tag];
    [self.navigationController pushViewController:vc animated:YES];
}

- (IBAction)star:(UIButton *)sender
{
    NSDictionary *providerDict = self.providers[sender.tag];
    Provider *provider = [Provider objectForPrimaryKey:providerDict[@"id"]];
    if(provider) {
        [sender setSelected:NO];
        [[RLMRealm defaultRealm] beginWriteTransaction];
        [[RLMRealm defaultRealm] deleteObject:provider];
        [[RLMRealm defaultRealm] commitWriteTransaction];
    } else {
        [sender setSelected:YES];
        [[RLMRealm defaultRealm] beginWriteTransaction];
        provider = [[Provider alloc] init];
        provider.name = [NSString stringWithFormat:@"%@ %@", providerDict[@"first_name"], providerDict[@"last_name"]];
        provider.specialty = providerDict[@"specialty1"] ? providerDict[@"specialty1"] : @"";
        provider.photoURLString = [NSString stringWithFormat:@"http://directory.iasishealthcare.com/images/physicians/%@", providerDict[@"photo"]];
        provider.guid = providerDict[@"id"];
        provider.fullData = providerDict;

        if([providerDict[@"appointment_url"] isKindOfClass:[NSNull class]]) {
            provider.scheduleURLString = @"";
        } else if([providerDict[@"appointment_url"] containsString:@"://"]) {
            provider.scheduleURLString = providerDict[@"appointment_url"];
        } else {
            provider.scheduleURLString = @"";
        }
        
        [[RLMRealm defaultRealm] addObject:provider];
        [[RLMRealm defaultRealm] commitWriteTransaction];
    }
}

@end
