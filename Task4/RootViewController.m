//
//  RootViewController.m
//  Task4
//
//  Created by Roma on 7/1/19.
//  Copyright © 2019 Roman. All rights reserved.
//

#import "RootViewController.h"
#import "DayScheduleViewController.h"
#import "WeekViewController.h"
#import "DataSource.h"


@interface RootViewController ()
@property (nonatomic, strong) DayScheduleViewController *dayScheduleController;
@property (nonatomic, strong) UIView *dayScheduleCollectionView;
@property (weak, nonatomic) IBOutlet UIView *dayScheduleContainerView;
@property (nonatomic, strong) WeekViewController *weekViewController;
@property (weak, nonatomic) IBOutlet UIView *weekContainerView;
@property (nonatomic, strong) UIView *weekScheduleCollectionView;
@property (strong, nonatomic) DataSource *dataSource;

@end

@implementation RootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.dataSource = [DataSource new];
    [self.dataSource fetchData];
    self.dayScheduleController = [[DayScheduleViewController alloc] init];
    self.dayScheduleCollectionView = self.dayScheduleController.view;
    [self addChildViewController:self.dayScheduleController];
    [self.dayScheduleContainerView addSubview:self.dayScheduleCollectionView];
    [self.dayScheduleController didMoveToParentViewController:self];
    
    self.weekViewController = [[WeekViewController alloc] init];
    self.weekScheduleCollectionView = self.weekViewController.view;
    [self addChildViewController:self.weekViewController];
    [self.weekContainerView addSubview:self.weekScheduleCollectionView];
    [self.weekViewController didMoveToParentViewController:self];
    

}

- (void)viewDidLayoutSubviews {
    self.dayScheduleCollectionView.translatesAutoresizingMaskIntoConstraints = NO;
    [NSLayoutConstraint activateConstraints:@[
    [self.dayScheduleCollectionView.topAnchor constraintEqualToAnchor:self.dayScheduleContainerView.topAnchor],
    [self.dayScheduleCollectionView.trailingAnchor constraintEqualToAnchor:self.dayScheduleContainerView.trailingAnchor],
    [self.dayScheduleCollectionView.leadingAnchor constraintEqualToAnchor:self.dayScheduleContainerView.leadingAnchor],
    [self.dayScheduleCollectionView.bottomAnchor constraintEqualToAnchor:self.dayScheduleContainerView.bottomAnchor]]];
    
    self.weekScheduleCollectionView.translatesAutoresizingMaskIntoConstraints = NO;
    [NSLayoutConstraint activateConstraints:@[
    [self.weekScheduleCollectionView.topAnchor constraintEqualToAnchor:self.weekContainerView.topAnchor],
    [self.weekScheduleCollectionView.trailingAnchor constraintEqualToAnchor:self.weekContainerView.trailingAnchor],
    [self.weekScheduleCollectionView.leadingAnchor constraintEqualToAnchor:self.weekContainerView.leadingAnchor],
    [self.weekScheduleCollectionView.bottomAnchor constraintEqualToAnchor:self.weekContainerView.bottomAnchor]]];
}



@end
