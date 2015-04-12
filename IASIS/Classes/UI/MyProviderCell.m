//
//  MyProviderCell.m
//  IASIS
//
//  Created by Tyler Hall on 12/9/14.
//  Copyright (c) 2014 IASIS Healthcare Corporation. All rights reserved.
//

#import "MyProviderCell.h"

@implementation MyProviderCell

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.viewForShadow.layer.shadowColor = [UIColor lightGrayColor].CGColor;
    self.viewForShadow.layer.shadowOffset = CGSizeMake(0, 1);
    self.viewForShadow.layer.shadowOpacity = 1.0;
}

@end
