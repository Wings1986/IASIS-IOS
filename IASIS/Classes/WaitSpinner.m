//
//  WaitSpinner.m
//  Tickets
//
//  Created by Tyler Hall on 2/8/15.
//  Copyright (c) 2015 Tandum LLC. All rights reserved.
//

#import "WaitSpinner.h"

@interface WaitSpinner ()

@property (nonatomic, assign) NSInteger count;
@property (nonatomic, strong) UIView *shimView;
@property (nonatomic, strong) UIActivityIndicatorView *activityInidicatorView;

@end

@implementation WaitSpinner

+ (instancetype)sharedObject
{
    static dispatch_once_t pred = 0;
    __strong static id _sharedObject = nil;
    dispatch_once(&pred, ^{
        _sharedObject = [[self alloc] init];
    });
    return _sharedObject;
}

- (id)init
{
    self = [super init];
    if(self) {
        _shimView = [[UIView alloc] initWithFrame:CGRectZero];
        _shimView.backgroundColor = [UIColor blackColor];
        _shimView.alpha = 0.25;
        _shimView.userInteractionEnabled = YES;

        _activityInidicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
        [_shimView addSubview:_activityInidicatorView];
    }
    return self;
}

- (void)setCount:(NSInteger)newCount
{
    if((_count == 0) && (newCount == 1)) {
        [self.activityInidicatorView startAnimating];
        self.shimView.frame = [[UIApplication sharedApplication] keyWindow].bounds;
        [[[UIApplication sharedApplication] keyWindow] addSubview:self.shimView];
        self.activityInidicatorView.center = self.shimView.center;
    }
    
    if((_count == 1) && (newCount == 0)) {
        [_activityInidicatorView stopAnimating];
        [self.shimView removeFromSuperview];
    }
    
    if(newCount < 0) {
        _count = 0;
    } else {
        _count = newCount;
    }
}

- (void)wait
{
    self.count++;
}

- (void)unwait
{
    self.count--;
}

@end
