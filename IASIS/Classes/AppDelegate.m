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
//    [[AFNetworkActivityLogger sharedLogger] setLevel:AFLoggerLevelDebug];
//    [[AFNetworkActivityLogger sharedLogger] startLogging];

    [self styleApp];

    return YES;
}

- (void)styleApp
{
    [[UINavigationBar appearance] setBackgroundImage:[UIImage imageNamed:@"NavigationBarBG"] forBarMetrics:UIBarMetricsDefault];
    [[UINavigationBar appearance] setTranslucent:NO];
    [[UINavigationBar appearance] setTitleTextAttributes:@{ NSForegroundColorAttributeName: [UIColor whiteColor]}];
    [[UIBarButtonItem appearance] setTitleTextAttributes:@{ NSForegroundColorAttributeName: [UIColor whiteColor]} forState:UIControlStateNormal];
    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
}

@end
