//
//  UIViewController+Alerts.h
//  Photos
//
//  Created by Tyler Hall on 11/5/14.
//  Copyright (c) 2014 Click On Tyler. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (Alerts)

- (void)TDM_presentOkAlertControllerWithTitle:(NSString *)title message:(NSString *)message handler:(void (^)())handler;
- (void)TDM_presentYesNoAlertControllerWithTitle:(NSString *)title message:(NSString *)message yesHandler:(void (^)())yesHandler noHandler:(void (^)())noHandler;
- (void)TDM_presentAlertSheetWithTitle:(NSString *)title
                      button1Title:(NSString *)button1Title button1Handler:(void (^)())button1Handler
                      button2Title:(NSString *)button2Title button2Handler:(void (^)())button2Handler
                        showCancel:(BOOL)showCancel;

@end
