//
//  OutlinedButton.m
//  IASIS
//
//  Created by Tyler Hall on 12/9/14.
//  Copyright (c) 2014 IASIS Healthcare Corporation. All rights reserved.
//

#import "OutlinedButton.h"

@implementation OutlinedButton

- (void)setColor:(UIColor *)color
{
    _color = color;
    self.layer.borderColor = self.color.CGColor;
    self.layer.borderWidth = 1.0;
    self.layer.cornerRadius = 4.0;
    [self setTitleColor:self.color forState:UIControlStateNormal];
}

@end
