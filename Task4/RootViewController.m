//
//  RootViewController.m
//  Task4
//
//  Created by Roma on 7/1/19.
//  Copyright © 2019 Roman. All rights reserved.
//

#import "RootViewController.h"
#import "DayScheduleViewController.h"
#import "DataSource.h"


@interface RootViewController ()
@property (nonatomic, strong) DayScheduleViewController *dayScheduleController;
@property (nonatomic, strong) UIView *dayScheduleCollectionView;
@property (weak, nonatomic) IBOutlet UIView *dayScheduleContainerView;
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
    

}

- (void)viewDidLayoutSubviews {
    self.dayScheduleCollectionView.translatesAutoresizingMaskIntoConstraints = NO;
    [NSLayoutConstraint activateConstraints:@[
    [self.dayScheduleCollectionView.topAnchor constraintEqualToAnchor:self.dayScheduleContainerView.topAnchor],
    [self.dayScheduleCollectionView.trailingAnchor constraintEqualToAnchor:self.dayScheduleContainerView.trailingAnchor],
    [self.dayScheduleCollectionView.leadingAnchor constraintEqualToAnchor:self.dayScheduleContainerView.leadingAnchor],
    [self.dayScheduleCollectionView.bottomAnchor constraintEqualToAnchor:self.dayScheduleContainerView.bottomAnchor]]];
}



@end
