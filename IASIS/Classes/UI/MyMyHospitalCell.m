//
//  MyMyHospitalCell.m
//  IASIS
//
//  Created by Tyler Hall on 12/9/14.
//  Copyright (c) 2014 IASIS Healthcare Corporation. All rights reserved.
//

#import "MyMyHospitalCell.h"

@interface MyMyHospitalCell ()

@property (nonatomic, weak) IBOutlet UILabel *titleLabel;
@property (nonatomic, weak) IBOutlet UILabel *subtitleLabel;
@property (nonatomic, weak) IBOutlet UIImageView *imgChevron;

@end

@implementation MyMyHospitalCell

- (void)setHospital:(NSDictionary *)hospital
{
    if(hospital) {
        self.button.hidden = YES;
        self.titleLabel.hidden = NO;
        self.subtitleLabel.hidden = NO;
        self.imgChevron.hidden = NO;

        self.titleLabel.text = @"My Hospital";
        if(hospital[@"displayName"]) {
            self.subtitleLabel.text = hospital[@"displayName"];
        } else {
            self.subtitleLabel.text = hospital[@"name"];
        }
    } else {
        self.button.hidden = NO;
        self.titleLabel.hidden = YES;
        self.subtitleLabel.hidden = YES;
        self.imgChevron.hidden = YES;
    }
}

@end
