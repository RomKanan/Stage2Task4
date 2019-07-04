//
//  SelectedDate.m
//  Task4
//
//  Created by Roma on 7/3/19.
//  Copyright © 2019 Roman. All rights reserved.
//

#import "SelectedDate.h"

@interface SelectedDate ()
@property (strong, atomic, readwrite) NSDate *dateStart;
@property (strong, atomic, readwrite) NSDate *dateEnd;

@end



@implementation SelectedDate

@synthesize date = _date;

static SelectedDate *SINGLETON = nil;

static bool isFirstAccess = YES;

#pragma mark - Public Method

-(void)setDate:(NSDate *)date{
    @synchronized (self) {
        _date = date;
    }
}
- (NSDate *)date{
    @synchronized (self) {
        return _date;
    }
}

+ (id)sharedInstance
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        isFirstAccess = NO;
        SINGLETON = [[super alloc] init];
    });
    
    return SINGLETON;
}

#pragma mark - Life Cycle

//+ (id) allocWithZone:(NSZone *)zone
//{
//    return [self sharedInstance];
//}

- (id)copy
{
    return [[SelectedDate alloc] init];
}

- (id)mutableCopy
{
    return [[SelectedDate alloc] init];
}

- (id) init
{
    if(SINGLETON){
        return SINGLETON;
    }
    if (isFirstAccess) {
        [self doesNotRecognizeSelector:_cmd];
    }
    self = [super init];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    self.date = [NSDate date];
    
    self.dateStart = [calendar startOfDayForDate:self.date];
    self.dateEnd = [calendar dateBySettingHour:23 minute:59 second:59 ofDate:self.date options:NSCalendarWrapComponents];
    return self;
}

@end
