//
//  HospitalsViewController.h
//  IASIS
//
//  Created by Tyler Hall on 12/10/14.
//  Copyright (c) 2014 IASIS Healthcare Corporation. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "EmptyBackButtonTitleViewController.h"

@interface HospitalsViewController : EmptyBackButtonTitleViewController

@property (nonatomic, strong) NSArray *hospitals;
@property (nonatomic, strong) NSString *subtitle;

@end
