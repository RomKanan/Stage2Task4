//
//  DataSource.h
//  Task4
//
//  Created by Roma on 7/1/19.
//  Copyright © 2019 Roman. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RKEvent.h"

@interface DataSource : NSObject
@property (nonatomic, strong, readonly) NSArray<RKEvent *> *events;
- (NSMutableArray<RKEvent *> *)fetchData;
@end


