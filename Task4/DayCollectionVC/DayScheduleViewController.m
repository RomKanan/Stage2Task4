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
#import "DataSource.h"
#import "RKEvent.h"
#import "SelectedDate.h"


@interface DayScheduleViewController () <UICollectionViewDataSource, UICollectionViewDelegate>

@property (strong, nonatomic) DayScheduleLayout *customLayout;
@property (strong, nonatomic) UICollectionView *collectionView;
@property (strong, nonatomic) DataSource *dataSource;
@property (strong,nonatomic) NSArray<RKEvent *> *allEvents;
@end

@implementation DayScheduleViewController

static NSString * const timeCellID = @"TimeCell";
static NSString * const iventCellID = @"IventCell";

- (void)viewDidLoad {
    [super viewDidLoad];
    [self reloadData];
    self.customLayout = [DayScheduleLayout new];
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:self.customLayout];
    [self.collectionView registerNib:[UINib nibWithNibName:@"IventCell" bundle:nil]
          forCellWithReuseIdentifier:iventCellID];
    [self.collectionView registerNib:[UINib nibWithNibName:@"TimeCell" bundle:nil]
          forCellWithReuseIdentifier:timeCellID];
    [self.view addSubview:self.collectionView];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    self.collectionView.backgroundColor = [UIColor whiteColor];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(dateChanged) name:@"dateChanged" object:nil];

}


- (void)viewDidLayoutSubviews {
    self.collectionView.translatesAutoresizingMaskIntoConstraints = NO;
    [NSLayoutConstraint activateConstraints:@[
    [self.collectionView.topAnchor constraintEqualToAnchor:self.view.topAnchor],
    [self.collectionView.trailingAnchor constraintEqualToAnchor:self.view.trailingAnchor],
    [self.collectionView.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor],
    [self.collectionView.bottomAnchor constraintEqualToAnchor:self.view.bottomAnchor]]];
    [self.customLayout invalidateLayout];
}

-(void)dateChanged{
    [self reloadData];
}

-(void)reloadData{
    self.dataSource = [DataSource new];
    NSDate *date = [[SelectedDate sharedInstance] date];
    self.allEvents = [self.dataSource fetchDataForDate:date];
    self.customLayout.events = self.allEvents;
    [self.collectionView reloadData];

}

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    NSInteger cells = 24 * 4 + self.allEvents.count;
    return cells;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger item = indexPath.item;
    item = indexPath.row;
    if (indexPath.item >= (24 * 4)) {
        RKEvent *event = [self.allEvents objectAtIndex:indexPath.item - 96];
        IventCell *eventCell = [collectionView dequeueReusableCellWithReuseIdentifier:iventCellID forIndexPath:indexPath];
        eventCell.eventRootView.backgroundColor = event.color;
        eventCell.eventDescriptionLable.text = event.eventTitle;
        return eventCell;
    }
    
    TimeCell *timerCell = [collectionView dequeueReusableCellWithReuseIdentifier:timeCellID forIndexPath:indexPath];
    if (indexPath.item % 4 == 0) {
        timerCell.timeLable.text = [NSString stringWithFormat:@"%ld:00", indexPath.item / 4 ];
    } else {
        timerCell.timeLable.text = @"";
    }

    
    return timerCell;
}

@end
