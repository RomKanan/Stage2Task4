//
//  DayScheduleViewController.m
//  Task4
//
//  Created by Roma on 7/1/19.
//  Copyright © 2019 Roman. All rights reserved.
//

#import "DayScheduleViewController.h"
#import "TimeCell.h"
#import "IventCell.h"
#import "DayScheduleLayout.h"

@interface DayScheduleViewController () <UICollectionViewDataSource, UICollectionViewDelegate>

@property (strong, nonatomic) UICollectionViewLayout *customLayout;
@property (strong, nonatomic) UICollectionView *collectionView;
@end

@implementation DayScheduleViewController

static NSString * const timeCellID = @"TimeCell";
static NSString * const iventCellID = @"IventCell";

- (void)viewDidLoad {
    [super viewDidLoad];
    self.customLayout = [DayScheduleLayout new];
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:self.customLayout];
    [self.collectionView registerNib:[UINib nibWithNibName:@"IventCell" bundle:nil]
          forCellWithReuseIdentifier:iventCellID];
    [self.collectionView registerNib:[UINib nibWithNibName:@"TimeCell" bundle:nil]
          forCellWithReuseIdentifier:timeCellID];
    [self.view addSubview:self.collectionView];
    [self.collectionView reloadData];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    self.collectionView.backgroundColor = [UIColor whiteColor];

}

//- (void)viewDidAppear:(BOOL)animated{
//    [super viewWillAppear:YES];
//    [self.customLayout invalidateLayout];
//}
- (void)viewDidLayoutSubviews {
    self.collectionView.translatesAutoresizingMaskIntoConstraints = NO;
    [NSLayoutConstraint activateConstraints:@[
    [self.collectionView.topAnchor constraintEqualToAnchor:self.view.topAnchor],
    [self.collectionView.trailingAnchor constraintEqualToAnchor:self.view.trailingAnchor],
    [self.collectionView.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor],
    [self.collectionView.bottomAnchor constraintEqualToAnchor:self.view.bottomAnchor]]];
    [self.customLayout invalidateLayout];
}

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 24 * 4;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    TimeCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:timeCellID forIndexPath:indexPath];
    if (indexPath.item % 4 == 0) {
        cell.timeLable.text = [NSString stringWithFormat:@"%ld:00", indexPath.item / 4 ];
    } else {
        cell.timeLable.text = @"";
    }
    
    // Configure the cell
    
    return cell;
}

@end
