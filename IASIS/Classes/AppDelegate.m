//
//  AppDelegate.m
//  IASIS
//
//  Created by Tyler Hall on 9/17/14.
//  Copyright (c) 2014 IASIS Healthcare. All rights reserved.
//

#import "AppDelegate.h"
#import "UIColor+Colors.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [self styleApp];
    return YES;
}

- (void)styleApp
{
    [[UINavigationBar appearance] setBarTintColor:[UIColor IASISBlue]];
    [[UINavigationBar appearance] setTranslucent:NO];
}

@end
