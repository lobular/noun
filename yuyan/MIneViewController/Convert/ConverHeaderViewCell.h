//
//  ConverHeaderViewCell.h
//  yuyan
//
//  Created by tangfeimu on 2019/4/10.
//  Copyright © 2019 tangfeimu. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface ConverHeaderViewCell : UITableViewCell

@property (nonatomic,strong)UILabel *tip;

+ (instancetype)initWithTableView:(UITableView *)tableView;

@end

