//
//  HospitalInfoCellER.h
//  IASIS
//
//  Created by Tyler Hall on 12/10/14.
//  Copyright (c) 2014 IASIS Healthcare Corporation. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HospitalInfoCell.h"

@interface HospitalInfoCellER : HospitalInfoCell

@property (nonatomic, weak) IBOutlet UILabel *lblWait;

- (void)fetchER:(NSString *)erURL;

@end
