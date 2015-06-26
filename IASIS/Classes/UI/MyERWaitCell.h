//
//  MyERWaitCell.h
//  IASIS
//
//  Created by Tyler Hall on 12/9/14.
//  Copyright (c) 2014 IASIS Healthcare Corporation. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyERWaitCell : UICollectionViewCell

@property (nonatomic, weak) IBOutlet UIButton *btnCheckIn;
@property (nonatomic, weak) IBOutlet UIButton *btnDirections;
@property (nonatomic, weak) IBOutlet UIButton *btnCenteredDirections;
@property (nonatomic, assign) BOOL useCenteredLayout;

- (void)fetchER:(NSString *)erURL;

@end
