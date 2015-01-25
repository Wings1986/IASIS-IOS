//
//  HospitalInfoCell.m
//  IASIS
//
//  Created by Tyler Hall on 12/10/14.
//  Copyright (c) 2014 IASIS Healthcare Corporation. All rights reserved.
//

#import "HospitalInfoCell.h"

@implementation HospitalInfoCell

- (void)layoutSubviews
{
    self.viewForShadow.layer.shadowColor = [UIColor lightGrayColor].CGColor;
    self.viewForShadow.layer.shadowOffset = CGSizeMake(0, 3);
    self.viewForShadow.layer.shadowOpacity = 1.0;
}

@end
