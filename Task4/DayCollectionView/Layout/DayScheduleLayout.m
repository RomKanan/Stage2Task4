//
//  DayScheduleLayout.m
//  Task4
//
//  Created by Roma on 7/1/19.
//  Copyright © 2019 Roman. All rights reserved.
//

#import "DayScheduleLayout.h"

@interface DayScheduleLayout ()
@property (nonatomic, strong) NSMutableArray<UICollectionViewLayoutAttributes *> *layouts;
@property (nonatomic, assign) CGFloat yOffset;
@end

@implementation DayScheduleLayout

- (void)prepareLayout{
    self.layouts = [NSMutableArray new];
    CGFloat viewWidth =  UIScreen.mainScreen.bounds.size.width;
    self.yOffset = 0.f;
    for (NSUInteger i =0; i < [self.collectionView numberOfItemsInSection:0]; i++){
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:i inSection:0];
        UICollectionViewLayoutAttributes *atributes = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
        atributes.frame = CGRectMake(0, self.yOffset, viewWidth, 30);
        self.yOffset += 30;
        [self.layouts  addObject:atributes];
    }
    
    
}

- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect {
   
    return [self.layouts copy];
}
- (CGSize)collectionViewContentSize {
    return CGSizeMake(self.collectionView.frame.size.width, self.yOffset);
}
@end
