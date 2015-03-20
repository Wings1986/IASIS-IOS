//
//  WaitSpinner.h
//  Tickets
//
//  Created by Tyler Hall on 2/8/15.
//  Copyright (c) 2015 Tandum LLC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WaitSpinner : NSObject

+ (instancetype)sharedObject;
- (void)wait;
- (void)unwait;

@end
