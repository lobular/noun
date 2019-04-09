//
//  CreedDetailViewCell.h
//  yuyan
//
//  Created by tangfeimu on 2019/4/9.
//  Copyright © 2019 tangfeimu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MineModel.h"


@interface CreedDetailViewCell : UITableViewCell

@property (nonatomic,strong)UILabel *name;
@property (nonatomic,strong)UILabel *time;
@property (nonatomic,strong)UILabel *score;
@property (nonatomic,strong)UILabel *line;

+ (instancetype)initWithTableView:(UITableView *)tableView;

- (void)setValueForCell:(MineModel *)model;

@end

