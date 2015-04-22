//
//  Provider.h
//  IASIS
//
//  Created by Tyler Hall on 4/22/15.
//  Copyright (c) 2015 IASIS Healthcare Corporation. All rights reserved.
//

#import "RLMObject.h"

@interface Provider : RLMObject

@property NSString *guid;
@property NSString *name;
@property NSString *specialty;
@property NSString *photoURLString;
@property NSString *scheduleURLString;

@property (nonatomic, strong) NSDictionary *fullData;

@end
