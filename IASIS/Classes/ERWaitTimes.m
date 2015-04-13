//
//  ERWaitTimes.m
//  IASIS
//
//  Created by Tyler Hall on 3/20/15.
//  Copyright (c) 2015 IASIS Healthcare Corporation. All rights reserved.
//

#import "ERWaitTimes.h"

@interface ERWaitTimes ()

@property (nonatomic, strong) AFHTTPRequestOperationManager *operationManager;

@end

@implementation ERWaitTimes

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
        AFXMLParserResponseSerializer *responseSerializer = [AFXMLParserResponseSerializer serializer];
        responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"application/rss+xml"];
        
        _operationManager = [[AFHTTPRequestOperationManager alloc] initWithBaseURL:[NSURL URLWithString:@""]];
        _operationManager.responseSerializer = responseSerializer;
        _operationManager.requestSerializer = [AFJSONRequestSerializer serializer];
    }
    return self;
}

- (AFHTTPRequestOperation *)fetchWaitTimeForHospital:(NSString *)waitURLString successBlock:(void (^)(NSXMLParser *parser))successBlock failureBlock:(void (^)(NSError *error))failureBlock
{
    NSLog(@"%@", waitURLString);
    AFHTTPRequestOperation *operation = [self.operationManager GET:waitURLString parameters:nil success:^(AFHTTPRequestOperation *operation, NSXMLParser *responseObject) {
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
