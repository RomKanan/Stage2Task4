//
//  RKEvent.h
//  Task4
//
//  Created by Roma on 7/1/19.
//  Copyright © 2019 Roman. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <EventKit/EventKit.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface RKEvent : NSObject
@property (strong, nonatomic, readonly) EKEvent *event;
@property (assign, nonatomic, readonly) CGFloat eventHeigh;
@property (assign, nonatomic, readonly) BOOL isSingleInLine;
@property (assign, nonatomic, readonly) NSUInteger countityOfNeibors;
@property (assign, nonatomic, readonly) CGFloat yPosition;
@property (strong, nonatomic, readonly) UIColor *color;
@property (strong, nonatomic, readonly) NSString *eventTitle;

- (instancetype)initWithEKEvent:(EKEvent*)event;
@end

NS_ASSUME_NONNULL_END
