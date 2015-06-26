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
#import "Provider.h"
#import "ProviderViewController.h"
#import "NoFavoriteProvidersCell.h"
#import "FindProvidersViewController.h"
#import "FirstLaunchViewController.h"
#import "HospitalInfoViewController.h"
#import <AFNetworking/UIImageView+AFNetworking.h>
#import <MapKit/MapKit.h>

@interface PersonalViewController ()

@property (nonatomic, weak) IBOutlet UICollectionView *collectionView;
@property (nonatomic, strong) RLMResults *favoriteProviders;
@property (nonatomic, strong) NSDictionary *favoriteHospital;
@property (nonatomic, strong) FirstLaunchViewController *vcFirstLaunch;

@end

@implementation PersonalViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.navigationItem.title = @"IASIS Healthcare";

    [self.collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([MyMyHospitalCell class]) bundle:nil] forCellWithReuseIdentifier:NSStringFromClass([MyMyHospitalCell class])];
    [self.collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([MyERWaitCell class]) bundle:nil] forCellWithReuseIdentifier:NSStringFromClass([MyERWaitCell class])];
    [self.collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([MyProviderCell class]) bundle:nil] forCellWithReuseIdentifier:NSStringFromClass([MyProviderCell class])];
    [self.collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([NoFavoriteProvidersCell class]) bundle:nil] forCellWithReuseIdentifier:NSStringFromClass([NoFavoriteProvidersCell class])];
    [self.collectionView registerNib:[UINib nibWithNibName:@"MyMyProvidersHeader" bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"MyMyProvidersHeader"];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    self.favoriteHospital = nil;
    
    NSString *favoriteState = [[NSUserDefaults standardUserDefaults] valueForKey:@"favoriteLocation"];
    NSInteger favoriteHospitalIndex = [[[NSUserDefaults standardUserDefaults] valueForKey:@"favoriteHospital"] integerValue];
    
    NSDictionary *data = [NSDictionary dictionaryWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Hospitals" ofType:@"plist"]];
    self.favoriteHospital = data[favoriteState][favoriteHospitalIndex];

    self.favoriteProviders = [Provider allObjects];

    [self.collectionView reloadData];
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 3;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if(section == 2) {
        return MAX(self.favoriteProviders.count, 1);
    }
    
    return 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.section == 0) {
        MyMyHospitalCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([MyMyHospitalCell class]) forIndexPath:indexPath];
        [cell setHospital:self.favoriteHospital];
        [cell.button addTarget:self action:@selector(pickFavorites) forControlEvents:UIControlEventTouchUpInside];
        
        NSString *favoriteState = [[NSUserDefaults standardUserDefaults] valueForKey:@"favoriteLocation"];
        NSInteger favoriteHospitalIndex = [[[NSUserDefaults standardUserDefaults] valueForKey:@"favoriteHospital"] integerValue];
        
        NSDictionary *data = [NSDictionary dictionaryWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Hospitals" ofType:@"plist"]];
        NSDictionary *hospital = data[favoriteState][favoriteHospitalIndex];
        
        cell.imgBackground.image = [UIImage imageNamed:hospital[@"image"]];
        
        return cell;
    }

    if(indexPath.section == 1) {
        MyERWaitCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([MyERWaitCell class]) forIndexPath:indexPath];
        if(self.favoriteHospital) {
            [cell fetchER:self.favoriteHospital[@"er"]];
        }

        [cell.btnCheckIn addTarget:self action:@selector(checkIn) forControlEvents:UIControlEventTouchUpInside];
        [cell.btnDirections addTarget:self action:@selector(directions) forControlEvents:UIControlEventTouchUpInside];
        [cell.btnCenteredDirections addTarget:self action:@selector(directions) forControlEvents:UIControlEventTouchUpInside];
        
        if(self.favoriteHospital[@"checkin"] != nil) {
            cell.useCenteredLayout = NO;
        } else {
            cell.useCenteredLayout = YES;
        }
        
        return cell;
    }

    if(indexPath.section == 2) {
        if(self.favoriteProviders.count == 0) {
            NoFavoriteProvidersCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([NoFavoriteProvidersCell class]) forIndexPath:indexPath];
            [cell.button addTarget:self action:@selector(addProviders:) forControlEvents:UIControlEventTouchUpInside];
            return cell;
        } else {
            Provider *provider = self.favoriteProviders[indexPath.row];

            MyProviderCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([MyProviderCell class]) forIndexPath:indexPath];
            cell.lblName.text = provider.name;
            cell.lblSpecialty.text = provider.specialty;
            [cell.photo setImageWithURL:[NSURL URLWithString:provider.photoURLString] placeholderImage:[UIImage imageNamed:@"doctor_placeholder"]];
            cell.btnStar.hidden = YES;
            
            cell.btnDetails.tag = indexPath.row;
            [cell.btnDetails addTarget:self action:@selector(details:) forControlEvents:UIControlEventTouchUpInside];
            
            if([provider.scheduleURLString containsString:@"://"]) {
                cell.btnSchedule.hidden = NO;
                cell.btnSchedule.tag = indexPath.row;
                [cell.btnSchedule addTarget:self action:@selector(schedule:) forControlEvents:UIControlEventTouchUpInside];
            } else {
                cell.btnSchedule.hidden = YES;
            }

            return cell;
        }
    }

    return nil;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.section == 2) {
        return self.favoriteProviders.count > 0 ? CGSizeMake(collectionView.bounds.size.width, 130.0) : CGSizeMake(collectionView.bounds.size.width, 186.0);
    }

    if(indexPath.section == 1) {
        return [self.favoriteHospital[@"er"] length] > 8 ? CGSizeMake(collectionView.bounds.size.width, 120.0) : CGSizeMake(collectionView.bounds.size.width, 0);
    }

    return CGSizeMake(collectionView.bounds.size.width, 120.0);
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    if(section == 2) {
        return CGSizeMake(60.0f, 35.0f);
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
    if(indexPath.section == 0) {
        HospitalInfoViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:NSStringFromClass([HospitalInfoViewController class])];

        NSString *favoriteState = [[NSUserDefaults standardUserDefaults] valueForKey:@"favoriteLocation"];
        NSInteger favoriteHospitalIndex = [[[NSUserDefaults standardUserDefaults] valueForKey:@"favoriteHospital"] integerValue];

        NSDictionary *data = [NSDictionary dictionaryWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Hospitals" ofType:@"plist"]];
        vc.hospital = data[favoriteState][favoriteHospitalIndex];

        [self.navigationController pushViewController:vc animated:YES];
    }
}

- (IBAction)details:(UIButton *)sender
{
    ProviderViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:NSStringFromClass([ProviderViewController class])];
    vc.showDefaultLeftBarButton = YES;

    Provider *provider = self.favoriteProviders[sender.tag];
    vc.providerDict = [[NSUserDefaults standardUserDefaults] valueForKey:provider.guid];
    [self.navigationController pushViewController:vc animated:YES];
}

- (IBAction)schedule:(UIButton *)sender
{
    Provider *provider = self.favoriteProviders[sender.tag];
    NSURL *url = [NSURL URLWithString:provider.scheduleURLString];
    [[UIApplication sharedApplication] openURL:url];
}

- (IBAction)addProviders:(id)sender
{
    UINavigationController *nc = [self.storyboard instantiateViewControllerWithIdentifier:NSStringFromClass([FindProvidersViewController class])];
    FindProvidersViewController *vc = nc.viewControllers[0];
    vc.showDefaultLeftBarButton = YES;
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)checkIn
{
    NSURL *url = [NSURL URLWithString:self.favoriteHospital[@"checkin"]];
    [[UIApplication sharedApplication] openURL:url];
}

- (void)directions
{
    NSString* url = [NSString stringWithFormat:@"http://maps.google.com/maps?saddr=&daddr=%@", [[self.favoriteHospital[@"info"] stringByReplacingOccurrencesOfString:@"\n" withString:@","] stringByReplacingOccurrencesOfString:@" " withString:@"+"]];
    [[UIApplication sharedApplication] openURL: [NSURL URLWithString: url]];
}

- (void)pickFavorites
{
    self.vcFirstLaunch = [self.storyboard instantiateViewControllerWithIdentifier:NSStringFromClass([FirstLaunchViewController class])];
    [self presentViewController:self.vcFirstLaunch animated:YES completion:nil];
}

@end
