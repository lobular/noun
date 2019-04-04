//
//  HomeViewCell.h
//  yuyan
//
//  Created by tangfeimu on 2019/4/3.
//  Copyright © 2019 tangfeimu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HomeModel.h"

@interface HomeViewCell : UITableViewCell


+ (instancetype)cellWithTableView:(UITableView *)tabelView;

- (void)setValueForCell:(HomeModel *)model;

@end

