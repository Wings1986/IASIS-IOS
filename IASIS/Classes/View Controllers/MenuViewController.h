//
//  MenuViewController.h
//  IASIS
//
//  Created by Tyler Hall on 12/1/14.
//  Copyright (c) 2014 IASIS Healthcare Corporation. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MenuViewControllerDelegate.h"

@interface MenuViewController : UIViewController

@property (nonatomic, weak) id <MenuViewControllerDelegate> delegate;

@end
