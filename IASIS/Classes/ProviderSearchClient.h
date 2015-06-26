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

- (AFHTTPRequestOperation *)searchWithState:(NSString *)state city:(NSString *)city specialty:(NSString *)specialty subspecialty:(NSString *)subspecialty lastName:(NSString *)lastName successBlock:(void (^)(id responseObject))successBlock failureBlock:(void (^)(NSError *error))failureBlock;
- (AFHTTPRequestOperation *)specialtiesWithState:(NSString *)state city:(NSString *)city successBlock:(void (^)(id responseObject))successBlock failureBlock:(void (^)(NSError *error))failureBlock;
- (AFHTTPRequestOperation *)searchWithDataset:(NSString *)dataset successBlock:(void (^)(id responseObject))successBlock failureBlock:(void (^)(NSError *error))failureBlock;

@end
