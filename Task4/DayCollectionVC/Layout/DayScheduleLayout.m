//
//  DayScheduleLayout.m
//  Task4
//
//  Created by Roma on 7/1/19.
//  Copyright © 2019 Roman. All rights reserved.
//

#import "DayScheduleLayout.h"
#import "DataSource.h"

@interface DayScheduleLayout ()
@property (nonatomic, strong) NSMutableArray<UICollectionViewLayoutAttributes *> *layouts;
@property (nonatomic, assign) CGFloat yOffset;
@end

@implementation DayScheduleLayout

- (void)prepareLayout{
    DataSource *dataSourxe = [[DataSource alloc] init];
    NSDate *date = [NSDate date];
    self.events = [dataSourxe fetchDataForDate:date];
    self.layouts = [NSMutableArray new];
    CGFloat viewWidth =  CGRectGetWidth(self.collectionView.bounds);
    self.yOffset = 0.f;

    
    NSInteger count = [self.collectionView numberOfItemsInSection:0];
    
    
    
    for (NSUInteger i =  0; i < [self.collectionView numberOfItemsInSection:0] - self.events.count; i++){
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:i inSection:0];
        UICollectionViewLayoutAttributes *atributes = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
        atributes.frame = CGRectMake(0, self.yOffset, viewWidth, 30);
        self.yOffset += 30;
        [self.layouts  addObject:atributes];
    }
    
    if (self.events) {
        NSMutableArray *eventLayouts = [NSMutableArray new];
        for (NSUInteger i = self.layouts.count; i < [self.collectionView numberOfItemsInSection:0]; i++){
            NSIndexPath *indexPath = [NSIndexPath indexPathForItem:i inSection:0];
            UICollectionViewLayoutAttributes *atributes = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
            RKEvent *event = [self.events objectAtIndex:i - self.layouts.count] ;
            atributes.frame = CGRectMake(50, event.yPosition, viewWidth - 50, event.eventHeigh);
            atributes.zIndex = 100;
            [eventLayouts addObject:atributes];
        }
        [self.layouts addObjectsFromArray:eventLayouts];
    }
    
    
    
    
    
}

- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect {
   
    return [self.layouts copy];
}
- (CGSize)collectionViewContentSize {
    return CGSizeMake(self.collectionView.frame.size.width, self.yOffset);
}
@end
