//
//  WeekCell.h
//  Task4
//
//  Created by Roma on 7/3/19.
//  Copyright © 2019 Roman. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DayOfWeekView.h"

NS_ASSUME_NONNULL_BEGIN

@interface WeekCell : UICollectionViewCell
@property (strong, nonatomic) NSDate *referencedDate;

@property (strong, nonatomic, readonly) NSArray<DayOfWeekView *> *daysOfWeek;
-(void)setUpCell;
@end

NS_ASSUME_NONNULL_END
