//
//  ProviderSearchClient.h
//  IASIS
//
//  Created by Tyler Hall on 3/20/15.
//  Copyright (c) 2015 IASIS Healthcare Corporation. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking/AFNetworking.h>

@interface ProviderSearchClient : NSObject

+ (instancetype)sharedObject;

- (AFHTTPRequestOperation *)searchWithState:(NSString *)state city:(NSString *)city specialty:(NSString *)specialty lastName:(NSString *)lastName successBlock:(void (^)(id responseObject))successBlock failureBlock:(void (^)(NSError *error))failureBlock;

@end
