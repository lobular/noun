//
//  HomeHeaderViewCell.h
//  yuyan
//
//  Created by tangfeimu on 2019/4/8.
//  Copyright © 2019 tangfeimu. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface HomeHeaderViewCell : UITableViewCell

@property (nonatomic,strong)UILabel *name;
@property (nonatomic,strong)UILabel *creed;
@property (nonatomic,strong)UIImageView *headerImage;
@property (nonatomic,strong)UIButton *btn;


+ (instancetype)initWithTable:(UITableView *)table;

@end


