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
#import "Provider.h"

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

        NSString *photURLString = [NSString stringWithFormat:@"http://directory.iasishealthcare.com/images/physicians/%@", self.providerDict[@"photo"]];
        [cell.photo setImageWithURL:[NSURL URLWithString:photURLString] placeholderImage:[UIImage imageNamed:@"doctor_placeholder"]];

        cell.btnSchedule.hidden = YES;
        if(self.providerDict[@"appointment_url"]) {
            cell.btnSchedule.hidden = NO;
            [cell.btnSchedule addTarget:self action:@selector(appointment:) forControlEvents:UIControlEventTouchUpInside];
        }
        
        cell.btnStar.tag = indexPath.row;
        [cell.btnStar addTarget:self action:@selector(star:) forControlEvents:UIControlEventTouchUpInside];

        Provider *fetchedProvider = [Provider objectForPrimaryKey:self.providerDict[@"id"]];
        if(fetchedProvider) {
            [cell.btnStar setSelected:YES];
        } else {
            [cell.btnStar setSelected:NO];
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
        NSMutableString *mutableHTML = [html mutableCopy];

        NSDictionary *replacements = @{ @"first_name" : ![self.providerDict[@"first_name"] isKindOfClass:[NSNull class]] ? self.providerDict[@"first_name"] : @"",
                                        @"last_name" : ![self.providerDict[@"last_name"] isKindOfClass:[NSNull class]] ? self.providerDict[@"last_name"] : @"",
                                        @"specialty" : ![self.providerDict[@"specialty1"] isKindOfClass:[NSNull class]] ? self.providerDict[@"specialty1"] : @"",
                                        @"bio" : ![self.providerDict[@"bio"] isKindOfClass:[NSNull class]] ? self.providerDict[@"bio"] : @"",
                                        @"location1_name" : ![self.providerDict[@"location1_name"] isKindOfClass:[NSNull class]] ? self.providerDict[@"location1_name"] : @"",
                                        @"location1_address1" : ![self.providerDict[@"location1_address1"] isKindOfClass:[NSNull class]] ? self.providerDict[@"location1_address1"] : @"",
                                        @"location1_city" : ![self.providerDict[@"location1_city"] isKindOfClass:[NSNull class]] ? self.providerDict[@"location1_city"] : @"",
                                        @"location1_state" : ![self.providerDict[@"location1_state"] isKindOfClass:[NSNull class]] ? self.providerDict[@"location1_state"] : @"",
                                        @"location1_zip" : ![self.providerDict[@"location1_zip"] isKindOfClass:[NSNull class]] ? self.providerDict[@"location1_zip"] : @"",
                                        @"location1_phone" : ![self.providerDict[@"location1_phone"] isKindOfClass:[NSNull class]] ? self.providerDict[@"location1_phone"] : @"",
                                        @"location1_url" : ![self.providerDict[@"location1_url"] isKindOfClass:[NSNull class]] ? self.providerDict[@"location1_url"] : @""
                                        };

        for(NSString *key in replacements.allKeys) {
            [mutableHTML replaceOccurrencesOfString:[NSString stringWithFormat:@"{{%@}}", key] withString:replacements[key] options:0 range:NSMakeRange(0, mutableHTML.length)];
        }

        [cell loadHTML:mutableHTML];

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

- (IBAction)star:(UIButton *)sender
{
    Provider *provider = [Provider objectForPrimaryKey:self.providerDict[@"id"]];
    if(provider) {
        [sender setSelected:NO];
        [[RLMRealm defaultRealm] beginWriteTransaction];
        [[RLMRealm defaultRealm] deleteObject:provider];
        [[RLMRealm defaultRealm] commitWriteTransaction];
    } else {
        [sender setSelected:YES];
        [[RLMRealm defaultRealm] beginWriteTransaction];
        provider = [[Provider alloc] init];
        provider.name = [NSString stringWithFormat:@"%@ %@", self.providerDict[@"first_name"], self.providerDict[@"last_name"]];
        provider.specialty = self.providerDict[@"specialty1"] ? self.providerDict[@"specialty1"] : @"";
        provider.photoURLString = [NSString stringWithFormat:@"http://directory.iasishealthcare.com/images/physicians/%@", self.providerDict[@"photo"]];
        provider.guid = self.providerDict[@"id"];
        [[RLMRealm defaultRealm] addObject:provider];
        [[RLMRealm defaultRealm] commitWriteTransaction];
    }
}

@end
