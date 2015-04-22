//
//  Provider.m
//  IASIS
//
//  Created by Tyler Hall on 4/22/15.
//  Copyright (c) 2015 IASIS Healthcare Corporation. All rights reserved.
//

#import "Provider.h"

@implementation Provider

+ (NSString *)primaryKey
{
    return @"guid";
}

+ (NSDictionary *)defaultPropertyValues
{
    CFUUIDRef theUUID = CFUUIDCreate(NULL);
    CFStringRef UUIDString = CFUUIDCreateString(NULL, theUUID);
    CFRelease(theUUID);

    return @{ @"guid" : (__bridge NSString *)UUIDString,
              @"name" : @"",
              @"specialty" : @"",
              @"photoURLString" : @"",
              @"scheduleURLString" : @""
            };
}

+ (NSArray *)ignoredProperties
{
    return @[ @"fullData" ];
}

- (void)setFullData:(NSDictionary *)fullData
{
    NSMutableDictionary *prunedDictionary = [NSMutableDictionary dictionary];
    for(NSString *key in [fullData allKeys])
    {
        if(![[fullData objectForKey:key] isKindOfClass:[NSNull class]]) {
            [prunedDictionary setValue:[fullData objectForKey:key] forKey:key];
        }
    }

    [[NSUserDefaults standardUserDefaults] setValue:prunedDictionary forKey:self.guid];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (NSDictionary *)fullData
{
    return [[NSUserDefaults standardUserDefaults] valueForKey:self.guid];
}

@end
