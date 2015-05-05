//
//  ProviderSearchClient.m
//  IASIS
//
//  Created by Tyler Hall on 3/20/15.
//  Copyright (c) 2015 IASIS Healthcare Corporation. All rights reserved.
//

#import "ProviderSearchClient.h"

@interface ProviderSearchClient ()

@property (nonatomic, strong) AFHTTPRequestOperationManager *operationManager;

@end

@implementation ProviderSearchClient

+ (instancetype)sharedObject
{
    static dispatch_once_t pred = 0;
    __strong static id _sharedObject = nil;
    dispatch_once(&pred, ^{
        _sharedObject = [[self alloc] init];
    });
    return _sharedObject;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        AFJSONResponseSerializer *responseSerializer = [AFJSONResponseSerializer serializer];
        responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];

        _operationManager = [[AFHTTPRequestOperationManager alloc] initWithBaseURL:[NSURL URLWithString:@"http://directory.iasishealthcare.com/"]];
        _operationManager.responseSerializer = responseSerializer;
        _operationManager.requestSerializer = [AFJSONRequestSerializer serializer];
    }
    return self;
}

- (AFHTTPRequestOperation *)searchWithState:(NSString *)state city:(NSString *)city specialty:(NSString *)specialty lastName:(NSString *)lastName successBlock:(void (^)(id responseObject))successBlock failureBlock:(void (^)(NSError *error))failureBlock
{
    if([[state lowercaseString] isEqualToString:@"arizona"]) {
        state = @"az";
    }

    if([[state lowercaseString] isEqualToString:@"utah"]) {
        state = @"ut";
    }
    
    if([[state lowercaseString] isEqualToString:@"texas"]) {
        state = @"tx";
    }
    
    if([[state lowercaseString] isEqualToString:@"colorado"]) {
        state = @"co";
    }

    if([[state lowercaseString] isEqualToString:@"arkansas"]) {
        state = @"ar";
    }

    if([[state lowercaseString] isEqualToString:@"louisiana"]) {
        state = @"la";
    }
    
    specialty = [specialty stringByReplacingOccurrencesOfString:@" " withString:@"+"];

    NSString *url = [NSString stringWithFormat:@"api/?last_name=%@&state=%@&city=%@&specialty=%@", lastName, state, city, specialty];

    AFHTTPRequestOperation *operation = [self.operationManager GET:url parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if(successBlock) {
            successBlock(responseObject);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if(failureBlock) {
            failureBlock(error);
        }
    }];

    return operation;
}

- (AFHTTPRequestOperation *)specialtiesWithState:(NSString *)state city:(NSString *)city successBlock:(void (^)(id responseObject))successBlock failureBlock:(void (^)(NSError *error))failureBlock
{
    if(!state) {
        state = @"";
    }
    
    if(!city) {
        city = @"";
    }

    if([[state lowercaseString] isEqualToString:@"arizona"]) {
        state = @"az";
    }
    
    if([[state lowercaseString] isEqualToString:@"utah"]) {
        state = @"ut";
    }
    
    if([[state lowercaseString] isEqualToString:@"texas"]) {
        state = @"tx";
    }
    
    if([[state lowercaseString] isEqualToString:@"colorado"]) {
        state = @"co";
    }
    
    if([[state lowercaseString] isEqualToString:@"arkansas"]) {
        state = @"ar";
    }
    
    if([[state lowercaseString] isEqualToString:@"louisiana"]) {
        state = @"la";
    }

    NSString *url = [NSString stringWithFormat:@"api/specialties.php?state=%@&city=%@", state, city];
    
    AFHTTPRequestOperation *operation = [self.operationManager GET:url parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if(successBlock) {
            successBlock(responseObject);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if(failureBlock) {
            failureBlock(error);
        }
    }];
    
    return operation;
}

@end
