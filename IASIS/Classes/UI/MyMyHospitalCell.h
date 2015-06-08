//
//  MyMyHospitalCell.h
//  IASIS
//
//  Created by Tyler Hall on 12/9/14.
//  Copyright (c) 2014 IASIS Healthcare Corporation. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyMyHospitalCell : UICollectionViewCell

@property (nonatomic, weak) IBOutlet UIButton *button;
@property (nonatomic, weak) IBOutlet UIImageView *imgBackground;

- (void)setHospital:(NSDictionary *)hospital;

@end
