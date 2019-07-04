//
//  WeekViewController.m
//  Task4
//
//  Created by Roma on 7/1/19.
//  Copyright © 2019 Roman. All rights reserved.
//

#import "WeekViewController.h"
#import "WeekCell.h"
#import "SelectedDate.h"


@interface WeekViewController ()<UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;


@end

@implementation WeekViewController
static NSString * const weekCellID = @"WeekCell";

- (void)viewDidLoad {
    [super viewDidLoad];
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    [self.collectionView registerNib:[UINib nibWithNibName:@"WeekCell" bundle:nil]
          forCellWithReuseIdentifier:weekCellID];
    
    
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:YES];
    [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:1 inSection:0] atScrollPosition:UICollectionViewScrollPositionNone animated:NO];
}


- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    CGFloat viewWidth =  CGRectGetWidth(self.collectionView.bounds);
    return CGSizeMake(viewWidth, 100);
}

- (nonnull __kindof UICollectionViewCell *)collectionView:(nonnull UICollectionView *)collectionView cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath {
    WeekCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:weekCellID forIndexPath:indexPath];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDate *date = [calendar startOfDayForDate:[[SelectedDate sharedInstance] date]];
    switch (indexPath.item) {
            
        case 0:
            cell.referencedDate  = [NSDate dateWithTimeInterval:-(7 * 24 * 60 *60) sinceDate:date];
            cell.tag = 0;
            break;
        case 1:
            cell.referencedDate = date;
            cell.tag = 1;
            break;
        case 2:
            cell.referencedDate = [NSDate dateWithTimeInterval:(7 * 24 * 60 *60) sinceDate:date];
            cell.tag = 2;
            break;
            
        default:
            break;
    }
    [cell setUpCell];
    return cell;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(nonnull UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 3;
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    NSLog(@"aaaa");
}

- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView{
    NSLog(@"aaaa");

}  // called on finger up as we are moving
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
 
   NSUInteger tag = [[self.collectionView visibleCells] objectAtIndex:0].tag;
    switch (tag) {
        case 0:
           [[SelectedDate sharedInstance] setDate:[[[SelectedDate sharedInstance] date] dateByAddingTimeInterval:-(7 * 24 * 60 *60)]];
            NSLog(@"%@", [[SelectedDate sharedInstance] date]);
            self.collectionView.reloadData;
            [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:1 inSection:0] atScrollPosition:UICollectionViewScrollPositionNone animated:NO];
            
            break;
        case 1:
            NSLog(@"%@", [[SelectedDate sharedInstance] date]);
            return;
            break;
        case 2:
            NSLog(@"%@", [[SelectedDate sharedInstance] date]);
            [[SelectedDate sharedInstance] setDate:[[[SelectedDate sharedInstance] date] dateByAddingTimeInterval:(7 * 24 * 60 *60)]];
            self.collectionView.reloadData;
            [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:1 inSection:0] atScrollPosition:UICollectionViewScrollPositionNone animated:NO];
            break;
        default:
            break;
    }

}





















@end
