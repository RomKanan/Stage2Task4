//
//  DayOfWeekView.h
//  Task4
//
//  Created by Roma on 7/3/19.
//  Copyright © 2019 Roman. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface DayOfWeekView : UIView
@property (strong, nonatomic) NSDate *date;
@property (assign, nonatomic) BOOL isSelected;
@property (assign, nonatomic) BOOL haveEvents;
@property (weak, nonatomic) IBOutlet UIView *selectedDayView;
@property (weak, nonatomic) IBOutlet UILabel *dayOfMonthLable;
@property (weak, nonatomic) IBOutlet UILabel *dayOfWeekLable;
@property (weak, nonatomic) IBOutlet UIView *eventsInDayView;


@end

NS_ASSUME_NONNULL_END
