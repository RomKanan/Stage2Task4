//
//  WeekViewController.m
//  Task4
//
//  Created by Roma on 7/1/19.
//  Copyright © 2019 Roman. All rights reserved.
//

#import "WeekViewController.h"
#import "WeekCell.h"

@interface WeekViewController ()<UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@end

@implementation WeekViewController
static NSString * const weekCellID = @"WeekCell";

- (void)viewDidLoad {
    [super viewDidLoad];
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    //UICollectionViewFlowLayout *layout = self.collectionView.collectionViewLayout;
    [self.collectionView registerNib:[UINib nibWithNibName:@"WeekCell" bundle:nil]
          forCellWithReuseIdentifier:weekCellID];
}


- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    CGFloat viewWidth =  CGRectGetWidth(self.collectionView.bounds);
    return CGSizeMake(viewWidth, 100);
}

- (nonnull __kindof UICollectionViewCell *)collectionView:(nonnull UICollectionView *)collectionView cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath {
    WeekCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:weekCellID forIndexPath:indexPath];
    return cell;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(nonnull UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 3;
}






















@end
