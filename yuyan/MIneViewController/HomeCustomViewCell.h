//
//  HomeCustomViewCell.h
//  yuyan
//
//  Created by tangfeimu on 2019/4/8.
//  Copyright © 2019 tangfeimu. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface HomeCustomViewCell : UITableViewCell

@property (nonatomic,strong)UIImageView *tipImage;
@property (nonatomic,strong)UILabel *tipLabel;

+ (instancetype)initWithTable:(UITableView *)table;

- (void)setValueForCell:(NSInteger)row;

@end

