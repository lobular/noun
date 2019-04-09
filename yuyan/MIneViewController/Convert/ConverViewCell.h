//
//  ConverViewCell.h
//  yuyan
//
//  Created by tangfeimu on 2019/4/9.
//  Copyright © 2019 tangfeimu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MineModel.h"


@interface ConverViewCell : UITableViewCell

@property (nonatomic,strong)UIImageView *image;
@property (nonatomic,strong)UILabel *name;
@property (nonatomic,strong)UIImageView *tip;
@property (nonatomic,strong)UILabel *time;
@property (nonatomic,strong)UILabel *line;

+ (instancetype)initWithTableView:(UITableView *)tableView;

- (void)setValueForCell:(RecordModel *)model;

@end

