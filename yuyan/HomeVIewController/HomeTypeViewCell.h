//
//  HomeTypeViewCell.h
//  yuyan
//
//  Created by tangfeimu on 2019/4/19.
//  Copyright © 2019 tangfeimu. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^Success)(NSInteger num);

@interface HomeTypeViewCell : UITableViewCell

@property (nonatomic,strong)UIView *backView;
@property (nonatomic,strong)UIImageView *typeImage;
@property (nonatomic,strong)UILabel *typeLabel;


@property (nonatomic,copy)Success succ;

+ (instancetype)initWithTable:(UITableView *)table;


- (void)config:(NSArray *)arr;

@end


