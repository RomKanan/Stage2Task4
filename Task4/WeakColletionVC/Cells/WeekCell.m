//
//  WeekCell.m
//  Task4
//
//  Created by Roma on 7/3/19.
//  Copyright © 2019 Roman. All rights reserved.
//

#import "WeekCell.h"
#import "DayOfWeekView.h"
#import "SelectedDate.h"


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
@property (weak, nonatomic) IBOutlet UILabel *dateLable;
@property (strong, nonatomic, readwrite) NSArray<DayOfWeekView *> *daysOfWeek;


@end

@implementation WeekCell

- (void)awakeFromNib {
    [super awakeFromNib];
}

-(void)setUpCell {
    for (UIView *view in self.containerStackView.arrangedSubviews){
        [view removeFromSuperview];
    }
    
    NSMutableArray *tempDays = [NSMutableArray new];
    
    self.dateLable.text = [self russianDate];

    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDate *nextMonday = [calendar nextDateAfterDate:self.referencedDate matchingUnit:NSCalendarUnitWeekday value:2 options:NSCalendarMatchNextTimePreservingSmallerUnits];
    
    for (NSUInteger i = 0; i < 7; i++) {
        DayOfWeekView * view = [[[NSBundle mainBundle] loadNibNamed:@"DayOfWeekView" owner:self options:nil] firstObject];
        view.userInteractionEnabled = YES;
        view.tag = i;

        switch (i) {
            case 0:
                view.dayOfWeekLable.text = @"пн";
                view.date = [NSDate dateWithTimeInterval:-(7 * 24 * 60 *60) sinceDate:nextMonday];
                break;
            case 1:
                view.dayOfWeekLable.text = @"вт";
                view.date = [NSDate dateWithTimeInterval:-(6 * 24 * 60 *60) sinceDate:nextMonday];
                break;
            case 2:
                view.dayOfWeekLable.text = @"ср";
                view.date = [NSDate dateWithTimeInterval:-(5 * 24 * 60 *60) sinceDate:nextMonday];
                break;
            case 3:
                view.dayOfWeekLable.text = @"чт";
                view.date = [NSDate dateWithTimeInterval:-(4 * 24 * 60 *60) sinceDate:nextMonday];
                break;
            case 4:
                view.dayOfWeekLable.text = @"пт";
                view.date = [NSDate dateWithTimeInterval:-(3 * 24 * 60 *60) sinceDate:nextMonday];
                break;
            case 5:
                view.dayOfWeekLable.text = @"сб";
                view.date = [NSDate dateWithTimeInterval:-(2 * 24 * 60 *60) sinceDate:nextMonday];
                break;
            case 6:
                view.dayOfWeekLable.text = @"вс";
                view.date = [NSDate dateWithTimeInterval:-(24 * 60 *60) sinceDate:nextMonday];
                break;
                
            default:
                break;
        };
        [tempDays addObject:view];
        [self.containerStackView addArrangedSubview:view];
    }
    self.daysOfWeek = [tempDays copy];
    
}

- (NSString *)russianDate{
    
    NSDateFormatter *formater = [[NSDateFormatter alloc] init];
    formater.dateFormat = @"M";
    NSString *month = [formater stringFromDate:self.referencedDate];
    NSDictionary *russinMonths = @{@"1":@"Января", @"2":@"Февраля", @"3":@"Марта", @"4":@"Апреля", @"5":@"Мая", @"6":@"Июня", @"7":@"Июля", @"8":@"Августа", @"9":@"Сентября", @"10":@"Октября", @"11":@"Ноября", @"12":@"Декабря"};
    formater.dateFormat = @"dd";
    NSString *day = [formater stringFromDate:self.referencedDate];
    formater.dateFormat = @"yyyy";
    NSString *year = [formater stringFromDate:self.referencedDate];
    NSString *russianDate = [NSString stringWithFormat:@"%@ %@ %@", day, [russinMonths objectForKey:month], year];
    
    return russianDate;
}



@end
