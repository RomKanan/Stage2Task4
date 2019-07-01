//
//  RKEvent.m
//  Task4
//
//  Created by Roma on 7/1/19.
//  Copyright © 2019 Roman. All rights reserved.
//

#import "RKEvent.h"
#import <UIKit/UIKit.h>

@interface RKEvent ()
@property (strong, nonatomic) EKEvent *event;
@property (assign, nonatomic) CGFloat eventHeigh;
@property (assign, nonatomic) BOOL isSingleInLine;
@property (assign, nonatomic) NSUInteger countityOfNeibors;
@property (assign, nonatomic) CGFloat yPosition;
@property (strong, nonatomic) UIColor *color;
@property (strong, nonatomic) NSString *eventTitle;
@end

@implementation RKEvent
- (instancetype)initWithEKEvent:(EKEvent*)event{
    self = [super init];
    if (self) {
        self.event = event;
        NSCalendar *calendar = [NSCalendar currentCalendar];
        NSTimeInterval interval = [self.event.startDate timeIntervalSinceDate:self.event.endDate];
        self.eventHeigh = 2.f * interval / 60.f;
        NSDate *startDate = [calendar dateBySettingHour:0 minute:0 second:0 ofDate:self.event.startDate options:NSCalendarWrapComponents];
        NSTimeInterval intervalFromDayStart = [startDate timeIntervalSinceDate:self.event.startDate];
        self.yPosition = 2.f * intervalFromDayStart / 60.f;
        self.color = [UIColor colorWithCGColor:self.event.calendar.CGColor];
        self.eventTitle = self.event.title;
        
        
        
        
        
        
        
        
    }
    return self;
}
@end
