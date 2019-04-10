//
//  ConverDetailTable.h
//  yuyan
//
//  Created by tangfeimu on 2019/4/10.
//  Copyright © 2019 tangfeimu. All rights reserved.
//

#import "BaseTableView.h"

@interface ConverGoods : UITableViewCell

@property (nonatomic,strong)UILabel *tip;
@property (nonatomic,strong)UILabel *amount;
@property (nonatomic,strong)UILabel *line;

+ (instancetype)initWithTable:(UITableView *)table;

@end

@interface ConverInfoCell : UITableViewCell

@property (nonatomic,strong)UILabel *tip;
@property (nonatomic,strong)UILabel *time;

+ (instancetype)initWithTable:(UITableView *)table;

@end

@interface ConverBtn : UITableViewCell

@property (nonatomic,strong)UIButton *subBtn;

+ (instancetype)initWithTable:(UITableView *)table;

@end

@interface ConverDetailTable : BaseTableView

@property (nonatomic,strong)NSDictionary *dic;

@end

