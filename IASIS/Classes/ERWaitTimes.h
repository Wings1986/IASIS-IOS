//
//  ERWaitTimes.h
//  IASIS
//
//  Created by Tyler Hall on 3/20/15.
//  Copyright (c) 2015 IASIS Healthcare Corporation. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking/AFNetworking.h>

@interface ERWaitTimes : NSObject

+ (instancetype)sharedObject;

- (AFHTTPRequestOperation *)fetchWaitTimeForHospital:(NSString *)username successBlock:(void (^)(NSXMLParser *parser))successBlock failureBlock:(void (^)(NSError *error))failureBlock;

@end
