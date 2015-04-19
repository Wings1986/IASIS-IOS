//
//  WebCell.h
//  IASIS
//
//  Created by Tyler Hall on 12/10/14.
//  Copyright (c) 2014 IASIS Healthcare Corporation. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WebCell : UICollectionViewCell

@property (nonatomic, strong) NSURL *url;

- (void)loadHTML:(NSString *)html;

@end
