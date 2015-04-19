//
//  ProviderViewController.m
//  IASIS
//
//  Created by Tyler Hall on 12/13/14.
//  Copyright (c) 2014 IASIS Healthcare Corporation. All rights reserved.
//

#import "ProviderViewController.h"
#import "MyProviderCell.h"
#import "WebCell.h"
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
    [self.collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([WebCell class]) bundle:nil] forCellWithReuseIdentifier:NSStringFromClass([WebCell class])];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 2;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.row == 0) {
        MyProviderCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([MyProviderCell class]) forIndexPath:indexPath];
        cell.lblName.text = [NSString stringWithFormat:@"%@ %@", self.providerDict[@"first_name"], self.providerDict[@"last_name"]];
        
        cell.lblName.text = [NSString stringWithFormat:@"%@ %@", cell.lblName.text, self.providerDict[@"credentials"] ? self.providerDict[@"credentials"] : @""];
        
        cell.lblSpecialty.text = self.providerDict[@"specialty1"] ? self.providerDict[@"specialty1"] : @"";

        NSString *photURLString = [NSString stringWithFormat:@"%@", self.providerDict[@"photo"]];
        [cell.photo setImageWithURL:[NSURL URLWithString:photURLString] placeholderImage:[UIImage imageNamed:@"doctor_placeholder"]];

        cell.btnSchedule.hidden = YES;
        if(self.providerDict[@"appointment_url"]) {
            cell.btnSchedule.hidden = NO;
            [cell.btnSchedule addTarget:self action:@selector(appointment:) forControlEvents:UIControlEventTouchUpInside];
        }
        
        cell.btnDetails.hidden = YES;
//        if(self.providerDict[@"appointment_url"]) {
//            cell.btnDetails.hidden = NO;
//            [cell.btnDetails addTarget:self action:@selector(appointment:) forControlEvents:UIControlEventTouchUpInside];
//        }

        return cell;
    } else {
        WebCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([WebCell class]) forIndexPath:indexPath];
        
        NSString *htmlPath = [[NSBundle mainBundle] pathForResource:@"Provider" ofType:@"html"];
        NSString *html = [[NSString alloc] initWithContentsOfFile:htmlPath encoding:NSUTF8StringEncoding error:nil];
        [cell loadHTML:html];

        return cell;
    }
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.row == 0) {
        return CGSizeMake(collectionView.bounds.size.width, 130.0);
    } else {
        CGFloat height = MIN(500, (collectionView.bounds.size.height - 130.0));
        return CGSizeMake(collectionView.bounds.size.width, height);
    }
}

- (IBAction)appointment:(id)sender
{
    NSURL *url = [NSURL URLWithString:self.providerDict[@"appointment_url"]];
    [[UIApplication sharedApplication] openURL:url];
}

@end
