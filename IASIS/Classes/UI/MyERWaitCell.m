//
//  MyERWaitCell.m
//  IASIS
//
//  Created by Tyler Hall on 12/9/14.
//  Copyright (c) 2014 IASIS Healthcare Corporation. All rights reserved.
//

#import "MyERWaitCell.h"
#import "ERWaitTimes.h"

@interface MyERWaitCell () <NSXMLParserDelegate>

@property (nonatomic, weak) IBOutlet UILabel *lblWaitTime;
@property (nonatomic, strong) NSString *characters;
@property (nonatomic, assign) BOOL foundFirstTitle;
@property (nonatomic, assign) BOOL workingOnTitle;

@end

@implementation MyERWaitCell

- (void)awakeFromNib
{
    [super awakeFromNib];

    self.lblWaitTime.text = @"Current ER Wait Time: Not Available";
    self.btnCheckIn.hidden = YES;
    self.btnDirections.hidden = YES;
    self.btnCenteredDirections.hidden = YES;
}

- (void)fetchER:(NSString *)erURL
{
    [[ERWaitTimes sharedObject] fetchWaitTimeForHospital:erURL successBlock:^(NSXMLParser *parser) {
        self.lblWaitTime.text = @"Fetching ER Wait Time...";
        self.characters = @"";
        self.foundFirstTitle = NO;
        parser.delegate = self;
        [parser parse];
    } failureBlock:^(NSError *error) {
        self.lblWaitTime.text = @"Unable to retrieve ER wait time";
    }];
}

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qualifiedName attributes:(NSDictionary *)attributeDict
{
    if([elementName isEqualToString:@"title"]) {
        self.workingOnTitle = YES;
    } else {
        self.workingOnTitle = NO;
    }
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName
{
    if([elementName isEqualToString:@"title"]) {
        if(!self.foundFirstTitle) {
            self.foundFirstTitle = YES;
        } else {
            NSString *waitTimeString;
            NSInteger waitTime = [self.characters integerValue];

            if(waitTime < 0) {
                waitTimeString = @"0 minutes";
            } else if (waitTime == 1) {
                waitTimeString = @"1 minute";
            } else if (waitTime > 59) {
                waitTimeString = @"Unavailable";
            } else {
                waitTimeString = [NSString stringWithFormat:@"%ld minutes", (long)waitTime];
            }

            self.lblWaitTime.text = [NSString stringWithFormat:@"Current ER Wait Time: %@", waitTimeString];
            
            if(self.useCenteredLayout) {
                self.btnCheckIn.hidden = YES;
                self.btnDirections.hidden = YES;
                self.btnCenteredDirections.hidden = NO;
            } else {
                self.btnCheckIn.hidden = NO;
                self.btnDirections.hidden = NO;
                self.btnCenteredDirections.hidden = YES;
            }
        }
    }
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string
{
    if(self.foundFirstTitle && self.workingOnTitle) {
        self.characters = [self.characters stringByAppendingString:string];
        self.characters = [self.characters stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    }
}

@end
