//
//  DayScheduleLayout.h
//  Task4
//
//  Created by Roma on 7/1/19.
//  Copyright © 2019 Roman. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RKEvent.h"

NS_ASSUME_NONNULL_BEGIN

@interface DayScheduleLayout : UICollectionViewLayout
@property (nonatomic, strong) NSArray<RKEvent *> *events;
@end

NS_ASSUME_NONNULL_END
