//
//  AppDelegate.m
//  IASIS
//
//  Created by Tyler Hall on 9/17/14.
//  Copyright (c) 2014 IASIS Healthcare. All rights reserved.
//

#import "AppDelegate.h"
#import "UIColor+Colors.h"
#import "GAI.h"
#import "ProviderSearchClient.h"
#import "ProviderResultsViewController.h"
#import "WaitSpinner.h"
#import "InitialViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
//    [[AFNetworkActivityLogger sharedLogger] setLevel:AFLoggerLevelDebug];
//    [[AFNetworkActivityLogger sharedLogger] startLogging];

    [self styleApp];
    
    [[GAI sharedInstance] trackerWithTrackingId:@"UA-41791573-1"];

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

- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url
{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"SHOW_PROVIDERS" object:url];

    return YES;
}

@end
