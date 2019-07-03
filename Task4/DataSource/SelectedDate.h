//
//  SelectedDate.h
//  Task4
//
//  Created by Roma on 7/3/19.
//  Copyright © 2019 Roman. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface SelectedDate : NSObject
@property (strong, atomic) NSDate *date;
@property (strong, atomic,readonly) NSDate *dateStart;
@property (strong, atomic,readonly) NSDate *dateEnd;

+ (id)sharedInstance;


@end

NS_ASSUME_NONNULL_END
