//
//  DataSource.m
//  Task4
//
//  Created by Roma on 7/1/19.
//  Copyright © 2019 Roman. All rights reserved.
//

#import "DataSource.h"
#import <UIKit/UIKit.h>
#import <EventKit/EventKit.h>

@interface DataSource ()

// The database with calendar events and reminders
@property (nonatomic, strong) NSArray<RKEvent *> *events;
@property (nonatomic, strong) NSCalendar *calendar;
@property (nonatomic, strong) NSDate *selectedDate;
@property (nonatomic, strong) EKEventStore *eventStore;
@property (nonatomic, assign) BOOL isAccessToEventStoreGranted;
@property (nonatomic, assign)  NSArray<EKCalendar *> *allCalendars;
@end

@implementation DataSource

- (instancetype)init
{
    self = [super init];
    if(self)
    {
        _eventStore = [[EKEventStore alloc] init];
    }
    
    return self;
}

- (EKEventStore *)eventStore {
    if (!_eventStore) {
        _eventStore = [[EKEventStore alloc] init];
    }
    return _eventStore;
}

- (BOOL)isAuthorized
{
    return ([EKEventStore authorizationStatusForEntityType:EKEntityTypeEvent] == EKAuthorizationStatusAuthorized);
}

- (void)updateAuthorizationStatusToAccessEventStore {
   
    EKAuthorizationStatus authorizationStatus = [EKEventStore authorizationStatusForEntityType:EKEntityTypeEvent];
    
    switch (authorizationStatus) {
        case EKAuthorizationStatusDenied:
            self.isAccessToEventStoreGranted = NO;
            break;
        case EKAuthorizationStatusRestricted:
            self.isAccessToEventStoreGranted = NO;
            break;
        case EKAuthorizationStatusAuthorized:
            self.isAccessToEventStoreGranted = YES;
            break;
        case EKAuthorizationStatusNotDetermined: {
            __weak DataSource *weakSelf = self;
            [self.eventStore requestAccessToEntityType:EKEntityTypeEvent
                                            completion:^(BOOL granted, NSError *error) {
                                                dispatch_async(dispatch_get_main_queue(), ^{
                                                    weakSelf.isAccessToEventStoreGranted = granted;
                                                    [weakSelf fetchData];
                                                });
                                            }];
            break;
        }
            
    }
}

- (void)fetchData {

    if(![self isAuthorized]) {
        [self updateAuthorizationStatusToAccessEventStore];
        return;
    }

    self.eventStore = [EKEventStore new];

    self.selectedDate = [NSDate date];
    self.calendar = [NSCalendar currentCalendar];

    self.allCalendars = [self.eventStore calendarsForEntityType:EKEntityTypeEvent];
    NSDate *startDate = [self.calendar dateBySettingHour:0 minute:0 second:0 ofDate:self.selectedDate options:NSCalendarWrapComponents];
    NSDate *endDate = [self.calendar dateBySettingHour:23 minute:59 second:59 ofDate:self.selectedDate options:NSCalendarWrapComponents];
    NSPredicate *predicate = [self.eventStore predicateForEventsWithStartDate:startDate endDate:endDate  calendars: nil];
    NSArray<EKEvent *> *ekEvents = [self.eventStore eventsMatchingPredicate:predicate];
    RKEvent testEvent
}
@end
