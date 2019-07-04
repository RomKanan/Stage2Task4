//
//  DayOfWeekView.m
//  Task4
//
//  Created by Roma on 7/3/19.
//  Copyright © 2019 Roman. All rights reserved.
//

#import "DayOfWeekView.h"
#import "DataSource.h"
#import "SelectedDate.h"


@interface DayOfWeekView ()
@property(strong, nonatomic) DataSource *dataSource;


@end

@implementation DayOfWeekView

- (void)setDate:(NSDate *)date {
    _date = date;
    [self updateViewContent];
}



- (void)awakeFromNib {
    [super awakeFromNib];
    self.userInteractionEnabled = YES;
    self.dataSource = [DataSource new];
    self.selectedDayView.layer.cornerRadius = self.selectedDayView.bounds.size.height / 2;
    self.eventsInDayView.layer.cornerRadius = self.eventsInDayView.bounds.size.height / 2;
    [self.eventsInDayView setHidden:YES];
    self.selectedDayView.backgroundColor = UIColor.clearColor;
    [self updateViewContent];
    [self.selectedDayView setUserInteractionEnabled:YES];
    [self.selectedDayView addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(viewTouched:)]];

}

-(void)updateViewContent{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    if (self.date) {
        NSDate *startDate = [calendar  startOfDayForDate:self.date];
        NSDate *endDate = [calendar dateBySettingHour:23 minute:59 second:59 ofDate:self.date options:NSCalendarWrapComponents];
        NSPredicate *predicate = [self.dataSource.eventStore predicateForEventsWithStartDate:startDate endDate:endDate  calendars: nil];
        NSArray<EKEvent *> *events = [self.dataSource.eventStore eventsMatchingPredicate:predicate];
        if (events.count > 0) {
            [self.eventsInDayView setHidden:NO];
        }
        
        if([calendar isDate:self.date equalToDate:[[SelectedDate sharedInstance] date] toUnitGranularity:NSCalendarUnitDay])
        {
            self.selectedDayView.backgroundColor = UIColor.redColor;
        }
        NSInteger numberOfDay = [calendar component:NSCalendarUnitDay fromDate:self.date];
        self.dayOfMonthLable.text = [NSString stringWithFormat:@"%ld", numberOfDay];
        
    }
}



- (void)viewTouched:(UITapGestureRecognizer *)recognizer{
    NSLog(@"aaaa");
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    NSLog(@"aaaa");
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    NSLog(@"aaaa");
}

- (IBAction)datePushed:(id)sender {
    NSLog(@"aaaa");
}




@end
