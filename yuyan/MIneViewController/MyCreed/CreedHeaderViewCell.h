//
//  CreedHeaderViewCell.h
//  yuyan
//
//  Created by tangfeimu on 2019/4/9.
//  Copyright © 2019 tangfeimu. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface CreedHeaderViewCell : UITableViewCell

@property (nonatomic,strong)UILabel *score;
@property (nonatomic,strong)UILabel *tip;
@property (nonatomic,strong)UILabel *total;

+ (instancetype)initWithTableView:(UITableView *)tableView;

@end

