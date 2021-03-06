//
//  MyProviderCell.h
//  IASIS
//
//  Created by Tyler Hall on 12/9/14.
//  Copyright (c) 2014 IASIS Healthcare Corporation. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyProviderCell : UICollectionViewCell

@property (nonatomic, weak) IBOutlet UIView *viewForShadow;
@property (nonatomic, weak) IBOutlet UILabel *lblName;
@property (nonatomic, weak) IBOutlet UILabel *lblSpecialty;
@property (nonatomic, weak) IBOutlet UIImageView *photo;
@property (nonatomic, weak) IBOutlet UIButton *btnSchedule;
@property (nonatomic, weak) IBOutlet UIButton *btnDetails;
@property (nonatomic, weak) IBOutlet UIButton *btnStar;

@end
