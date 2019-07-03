//
//  WeekCell.m
//  Task4
//
//  Created by Roma on 7/3/19.
//  Copyright © 2019 Roman. All rights reserved.
//

#import "WeekCell.h"

@interface WeekCell ()
@property (weak, nonatomic) IBOutlet UIStackView *containerStackView;

@end

@implementation WeekCell

- (void)awakeFromNib {
    [super awakeFromNib];
    NSArray *allSubviews = self.containerStackView.subviews;
    for (UIView *view in allSubviews){
        for (UIView *subview in view.subviews) {
            CGFloat heigh = subview.frame.size.height;
            subview.layer.cornerRadius = (heigh / 2);
        }
    }
}

@end
