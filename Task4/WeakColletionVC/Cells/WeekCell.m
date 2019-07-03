//
//  WeekCell.m
//  Task4
//
//  Created by Roma on 7/3/19.
//  Copyright © 2019 Roman. All rights reserved.
//

#import "WeekCell.h"
#import "DayOfWeekView.h"

enum {
    monday,
    tuesdayView,
    wedensdayView,
    thursdayView,
    fridayView,
    saturdayView,
    sundayView,
} Day;

@interface WeekCell ()
@property (weak, nonatomic) IBOutlet UIStackView *containerStackView;

@property (strong, nonatomic) NSArray<DayOfWeekView *> *daysOfWeek;
@end

@implementation WeekCell

- (void)awakeFromNib {
    [super awakeFromNib];
    NSMutableArray *tempDays = [NSMutableArray new];
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    self.selectedDate = [NSDate date];
    NSDate *nextMonday = [calendar nextDateAfterDate:self.selectedDate matchingUnit:NSCalendarUnitWeekday value:2 options:NSCalendarMatchNextTime];
    
    for (NSUInteger i = 0; i < 7; i++) {
        DayOfWeekView * view = [[[NSBundle mainBundle] loadNibNamed:@"DayOfWeekView" owner:self options:nil] firstObject];
    
        switch (i) {
            case 0:
                view.dayOfWeekLable.text = @"пн";
                view.date = [calendar dateByAddingUnit: NSCalendarUnitDay value:-7 toDate:nextMonday options:NSCalendarWrapComponents];
                break;
            case 1:
                view.dayOfWeekLable.text = @"вт";
                view.date = [calendar dateByAddingUnit: NSCalendarUnitDay value:-6 toDate:nextMonday options:NSCalendarWrapComponents];
                break;
            case 2:
                view.dayOfWeekLable.text = @"ср";
                view.date = [calendar dateByAddingUnit: NSCalendarUnitDay value:-5 toDate:nextMonday options:NSCalendarWrapComponents];
                break;
            case 3:
                view.dayOfWeekLable.text = @"чт";
                view.date = [calendar dateByAddingUnit: NSCalendarUnitDay value:-4 toDate:nextMonday options:NSCalendarWrapComponents];
                break;
            case 4:
                view.dayOfWeekLable.text = @"пт";
                view.date = [calendar dateByAddingUnit: NSCalendarUnitDay value:-3 toDate:nextMonday options:NSCalendarWrapComponents];
                break;
            case 5:
                view.dayOfWeekLable.text = @"сб";
                view.date = [calendar dateByAddingUnit: NSCalendarUnitDay value:-2 toDate:nextMonday options:NSCalendarWrapComponents];
                break;
            case 6:
                view.dayOfWeekLable.text = @"вс";
                view.date = [calendar dateByAddingUnit: NSCalendarUnitDay value:-1 toDate:nextMonday options:NSCalendarWrapComponents];
                break;

            default:
                break;
        };
        [tempDays addObject:view];
        [self.containerStackView addArrangedSubview:view];
    }
    self.daysOfWeek = [tempDays copy];




    
    
    
    
//    NSDate *monday = [calendar dateByAddingUnit: NSCalendarUnitDay value:-7 toDate:nextMonday options:NSCalendarWrapComponents];
//     NSDate *previousMonday = [calendar dateByAddingUnit: NSCalendarUnitDay value:-7 toDate:monday options:NSCalendarWrapComponents];
//    NSMutableArray * numbersForWekDays = [NSMutableArray new];
//    for (NSUInteger i = 7; i > 0; i--) {
//       NSDate *day = [calendar dateByAddingUnit: NSCalendarUnitDay value:-i toDate:nextMonday options:NSCalendarWrapComponents];
//        [numbersForWekDays addObject:day];
//  }
//    NSInteger monday = [calendar component:NSCalendarUnitDay fromDate:nextMonday] - 1;
//    
//    for (NSUInteger i = 0; i < self.daysOfWeek.count; i++) {
//        UILabel *dayOfMonth = (UILabel*)[[self.daysOfWeek objectAtIndex:i] viewWithTag:dayOfMonth];
//        NSDate *date = [numbersForWekDays objectAtIndex:0];
//        dayOfMonth.text = [NSString stringWithFormat:@"%ld",[calendar component:NSCalendarUnitDay fromDate:date] ];
//    }


}

@end
