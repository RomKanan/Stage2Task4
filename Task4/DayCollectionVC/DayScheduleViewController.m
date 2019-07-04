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
@property (strong, nonatomic) NSCalendar *calendar;
@property (strong, nonatomic) UIView *timeStampContainerView;
@property (strong, nonatomic) UILabel *timeStampLable;
@property (strong, nonatomic) UIView *timeLineView;
@property (strong, nonatomic) NSTimer *StartTimer;
@property (strong, nonatomic) NSTimer *timer;
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
    
    self.timeStampContainerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 50, 29)];
    self.timeStampContainerView.backgroundColor = UIColor.clearColor;
    UIView *timeStampView = [[UIView alloc] initWithFrame:(CGRectMake(0, 0, 50, 29))];
    timeStampView.backgroundColor = UIColor.whiteColor;
    [self.timeStampContainerView addSubview:timeStampView];
    timeStampView.center = self.timeStampContainerView.center;
    self.timeStampLable = [[UILabel alloc] initWithFrame:(CGRectMake(0, 0, 50, 29))];
    self.timeStampLable.textAlignment = NSTextAlignmentCenter;
    self.timeStampLable.font = [UIFont systemFontOfSize:15 weight:UIFontWeightRegular];
    self.timeStampLable.backgroundColor = UIColor.clearColor;
    self.timeStampLable.text = @"00:00";
    [timeStampView addSubview:self.timeStampLable];
    self.timeStampLable.center = timeStampView.center;
    [self.collectionView addSubview:self.timeStampContainerView];
    self.timeLineView = [[UIView alloc] initWithFrame:(CGRectMake(0, 0, 100, 2))];
    self.timeLineView.backgroundColor = UIColor.redColor;
    [self.collectionView addSubview:self.timeLineView];
    
    
    

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

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:YES];
    [self placeTimeStamp];
}

- (void)placeTimeStamp{
    self.calendar = [NSCalendar currentCalendar];
    NSDate *curentTime = [NSDate date];
    NSInteger curentMinute = [self.calendar component:NSCalendarUnitMinute fromDate:curentTime];
    NSDate *nextMinute = [self.calendar nextDateAfterDate:curentTime matchingUnit:(NSCalendarUnitMinute) value:curentMinute + 1 options:(NSCalendarMatchNextTime)];
    NSDate *nextQuoterHour = [self.calendar nextDateAfterDate:curentTime matchingUnit:(NSCalendarUnitMinute) value:15 options:(NSCalendarMatchNextTime)];
 
    if ((curentMinute >= 15)&&(curentMinute < 30)) {
        nextQuoterHour = [self.calendar nextDateAfterDate:curentTime matchingUnit:(NSCalendarUnitMinute) value:30 options:(NSCalendarMatchNextTime)];
    } else if ((curentMinute >= 30)&&(curentMinute < 45)) {
        nextQuoterHour = [self.calendar nextDateAfterDate:curentTime matchingUnit:(NSCalendarUnitMinute) value:46 options:(NSCalendarMatchNextTime)];
    } else if ((curentMinute >= 45)&&(curentMinute < 60)) {
        nextQuoterHour = [self.calendar nextDateAfterDate:curentTime matchingUnit:(NSCalendarUnitMinute) value:0 options:(NSCalendarMatchNextTime)];
    }
    [self recalculateTimerPosition];
    __weak DayScheduleViewController *weakSelf = self;
   self.StartTimer = [[NSTimer alloc] initWithFireDate:nextMinute interval:0.01 repeats:NO block:^(NSTimer * _Nonnull timer) {
      weakSelf.timer = [NSTimer scheduledTimerWithTimeInterval:60.2 target:weakSelf selector:@selector(recalculateTimerPosition) userInfo:nil repeats:YES];
       [weakSelf recalculateTimerPosition];

    }];
    [[NSRunLoop currentRunLoop] addTimer:self.StartTimer forMode:NSRunLoopCommonModes];
    


    
    
}

- (void)recalculateTimerPosition{
    NSDate *curentTime = [NSDate date];
    NSInteger curentHour = [self.calendar component:NSCalendarUnitHour fromDate:curentTime];
    NSInteger curentMinute = [self.calendar component:NSCalendarUnitMinute fromDate:curentTime];
    
    NSInteger yLableOffset = 0;
    if ((curentMinute >= 15)&&(curentMinute < 30)) {
        yLableOffset = 15;
    } else if ((curentMinute >= 30)&&(curentMinute < 45)) {
        yLableOffset = 30;
    } else if ((curentMinute >= 45)&&(curentMinute < 60)) {
        yLableOffset = 45;
    }
    
    CGFloat yLablePosition = (CGFloat)(((curentHour * 60) + yLableOffset)*2);
    CGFloat yTimeLinePosition = (CGFloat)(((curentHour * 60) + curentMinute)*2);
    CGFloat viewWidth =  CGRectGetWidth(self.collectionView.bounds);
    NSString *curentMinuetString = [NSString stringWithFormat:@"%ld", curentMinute];
    if (curentMinute < 10) {
        curentMinuetString = [NSString stringWithFormat:@"0%ld", curentMinute];
    }
    self.timeLineView.frame = CGRectMake(50, yTimeLinePosition, viewWidth - 50, 2);
    self.timeStampContainerView.frame = CGRectMake(0, yLablePosition, 50, 29);
    self.timeStampLable.text = [NSString stringWithFormat:@"  %ld:%@", curentHour, curentMinuetString];
    [self.collectionView bringSubviewToFront: self.self.timeStampContainerView];
    [self.collectionView bringSubviewToFront: self.timeStampLable];
    [self.collectionView bringSubviewToFront: self.timeLineView];

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
