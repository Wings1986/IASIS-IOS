//
//  UIViewController+Alerts.m
//  Photos
//
//  Created by Tyler Hall on 11/5/14.
//  Copyright (c) 2014 Click On Tyler. All rights reserved.
//

#import "UIViewController+Alerts.h"

@implementation UIViewController (Alerts)

- (void)TDM_presentOkAlertControllerWithTitle:(NSString *)title message:(NSString *)message handler:(void (^)())handler
{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:NSLocalizedString(@"OK", nil)
                                                       style:UIAlertActionStyleDefault
                                                     handler:^(UIAlertAction *action)
                               {
                                   if(handler) {
                                       handler();
                                   }
                               }];
    [alertController addAction:okAction];
    
    [self presentViewController:alertController animated:YES completion:nil];
}

- (void)TDM_presentYesNoAlertControllerWithTitle:(NSString *)title message:(NSString *)message yesHandler:(void (^)())yesHandler noHandler:(void (^)())noHandler
{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *yesAction = [UIAlertAction actionWithTitle:NSLocalizedString(@"Yes", nil)
                                                       style:UIAlertActionStyleDefault
                                                     handler:^(UIAlertAction *action)
                               {
                                   if(yesHandler) {
                                       yesHandler();
                                   }
                               }];
    [alertController addAction:yesAction];

    UIAlertAction *noAction = [UIAlertAction actionWithTitle:NSLocalizedString(@"No", nil)
                                                        style:UIAlertActionStyleDefault
                                                      handler:^(UIAlertAction *action)
                                {
                                    if(noHandler) {
                                        noHandler();
                                    }
                                }];
    [alertController addAction:noAction];
    
    [self presentViewController:alertController animated:YES completion:nil];
}

- (void)TDM_presentAlertSheetWithTitle:(NSString *)title
                      button1Title:(NSString *)button1Title button1Handler:(void (^)())button1Handler
                      button2Title:(NSString *)button2Title button2Handler:(void (^)())button2Handler
                        showCancel:(BOOL)showCancel
{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIAlertAction *action1 = [UIAlertAction actionWithTitle:button1Title
                                                        style:UIAlertActionStyleDefault
                                                      handler:^(UIAlertAction *action)
                                {
                                    if(button1Handler) {
                                        button1Handler();
                                    }
                                }];
    [alertController addAction:action1];
    
    UIAlertAction *action2 = [UIAlertAction actionWithTitle:button2Title
                                                       style:UIAlertActionStyleDefault
                                                     handler:^(UIAlertAction *action)
                               {
                                   if(button2Handler) {
                                       button2Handler();
                                   }
                               }];
    [alertController addAction:action2];

    if(showCancel) {
        UIAlertAction *cancel = [UIAlertAction actionWithTitle:NSLocalizedString(@"Cancel", nil)
                                                          style:UIAlertActionStyleCancel
                                                        handler:nil];
        [alertController addAction:cancel];
    }
    
    [self presentViewController:alertController animated:YES completion:nil];
}

@end
