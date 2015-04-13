//
//  FindHospitalInfoCell.h
//  IASIS
//
//  Created by Tyler Hall on 12/10/14.
//  Copyright (c) 2014 IASIS Healthcare Corporation. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FindHospitalInfoCell : UICollectionViewCell

@property (nonatomic, weak) IBOutlet UILabel *lblName;
@property (nonatomic, weak) IBOutlet UILabel *lblAddress1;
@property (nonatomic, weak) IBOutlet UILabel *lblAddress2;
@property (nonatomic, weak) IBOutlet UILabel *lblPhone;
@property (nonatomic, weak) IBOutlet UIImageView *image;

@end
