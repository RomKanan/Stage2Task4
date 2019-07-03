//
//  IventCell.h
//  Task4
//
//  Created by Roma on 7/1/19.
//  Copyright © 2019 Roman. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface IventCell : UICollectionViewCell
@property (strong, nonatomic) UIColor* color;
@property (strong, nonatomic) NSString* text;
@property (weak, nonatomic) IBOutlet UILabel *eventDescriptionLable;
@property (weak, nonatomic) IBOutlet UIView *eventRootView;

@end

