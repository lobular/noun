//
//  ExchangeTableView.m
//  yuyan
//
//  Created by tangfeimu on 2019/4/11.
//  Copyright © 2019 tangfeimu. All rights reserved.
//

#import "ExchangeTableView.h"
#import "ConverHeaderViewCell.h"
#import "ConverViewCell.h"
#import <UIImageView+WebCache.h>

@interface ExchangeOrderInfo : UITableViewCell

@property (nonatomic,strong)UILabel *amount;
@property (nonatomic,strong)UILabel *num;
@property (nonatomic,strong)UILabel *time;

+ (instancetype)initWithTable:(UITableView *)table;

@end

@implementation ExchangeOrderInfo

+ (instancetype)initWithTable:(UITableView *)table;{
    ExchangeOrderInfo *cell = [table dequeueReusableCellWithIdentifier:@"info"];
    if (!cell) {
        cell = [[ExchangeOrderInfo alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"info"];
    }
    return cell;
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self config];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

- (void)config{
    if (!_amount) {
        _amount = [UILabel new];
        [self.contentView addSubview:_amount];
        _amount.whc_LeftSpace(16).whc_TopSpace(20);
        _amount.textColor = [UIColor textColorWithType:0];
        _amount.font = FontSize(16);
    }
    if (!_num) {
        _num = [UILabel new];
        [self.contentView addSubview:_num];
        _num.whc_LeftSpace(16).whc_TopSpaceToView(10, _amount);
        _num.textColor = [UIColor textColorWithType:0];
        _num.font = FontSize(16);
    }
    if (!_time) {
        _time = [UILabel new];
        [self.contentView addSubview:_time];
        _time.whc_LeftSpace(16).whc_TopSpaceToView(10, _num);
        _time.textColor = [UIColor textColorWithType:0];
        _time.font = FontSize(16);
    }
}
@end

@interface ExchangeGoodsInfo : UITableViewCell

@property (nonatomic,strong)UILabel *goodsInfo;
@property (nonatomic,strong)UILabel *content;
@property (nonatomic,strong)UILabel *tip;
@property (nonatomic,strong)UILabel *userInfo;

+ (instancetype)initWithTable:(UITableView *)table;

@end

@implementation ExchangeGoodsInfo

+ (instancetype)initWithTable:(UITableView *)table{
    ExchangeGoodsInfo *cell = [table dequeueReusableCellWithIdentifier:@"goods"];
    if (!cell) {
        cell = [[ExchangeGoodsInfo alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"info"];
    }
    return cell;
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self config];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

- (void)config{
    if (!_goodsInfo) {
        _goodsInfo = [UILabel new];
        [self.contentView addSubview:_goodsInfo];
        _goodsInfo.whc_LeftSpace(16).whc_TopSpace(20);
        _goodsInfo.textColor = [UIColor textColorWithType:0];
        _goodsInfo.font = FontSize(16);
    }
    if (!_content) {
        _content = [UILabel new];
        [self.contentView addSubview:_content];
        _content.whc_LeftSpace(16).whc_TopSpaceToView(10, _goodsInfo);
        _content.textColor = [UIColor textColorWithType:0];
        _content.font = FontSize(16);
    }
    if (!_tip) {
        _tip = [UILabel new];
        _tip.text = @"使用流程:";
        [self.contentView addSubview:_tip];
        _tip.whc_LeftSpace(16).whc_TopSpaceToView(10, _content);
        _tip.textColor = [UIColor textColorWithType:0];
    }
        
    if (!_userInfo) {
        _userInfo = [UILabel new];
        [self.contentView addSubview:_userInfo];
        _userInfo.whc_LeftSpace(16).whc_TopSpaceToView(10, _tip);
        _userInfo.textColor = [UIColor textColorWithType:0];
        _userInfo.font = FontSize(16);
    }
}
@end

@interface ExchangeTableView ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation ExchangeTableView

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style{
    if (self = [super initWithFrame:frame style:style]) {
        self.delegate = self;
        self.dataSource = self;
        self.separatorStyle = UITableViewCellSelectionStyleNone;
        [self registerClass:ConverHeaderViewCell.class forCellReuseIdentifier:@"header"];
        [self registerClass:ConverViewCell.class forCellReuseIdentifier:@"conver"];
        [self registerClass:ExchangeOrderInfo.class forCellReuseIdentifier:@"info"];
    }
    return self;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 4;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        ConverHeaderViewCell *cell = [ConverHeaderViewCell initWithTableView:tableView];
        cell.tip.text = @"恭喜你,兑换成功";
        return cell;
    }
    if (indexPath.section == 2) {
        ExchangeOrderInfo *cell = [ExchangeOrderInfo initWithTable:tableView];
        cell.amount.text = [NSString stringWithFormat:@"支付金额:%@信条",self.dataDic[@"pay_creed"]];
        cell.num.text = [NSString stringWithFormat:@"订单编号:%@",self.dataDic[@"order_no"]];
        cell.time.text = [NSString stringWithFormat:@"下单时间%@",self.dataDic[@"valid"]];

        return cell;
    }
    if (indexPath.section == 3) {
        ExchangeGoodsInfo *cell = [ExchangeGoodsInfo initWithTable:tableView];
        cell.goodsInfo.text = [NSString stringWithFormat:@"商品详情:%@",self.dataDic[@"title"]];
        cell.content.text = [NSString stringWithFormat:@"文本标签:%@",self.dataDic[@"detail"]];
        cell.userInfo.text = self.dataDic[@"process"];
        return cell;
    }
    ConverViewCell *cell = [ConverViewCell initWithTableView:tableView];
    [cell.image sd_setImageWithURL:[NSURL URLWithString:self.dataDic[@"thumb"]]];
    cell.name.text = self.dataDic[@"title"];
    cell.time.text = [NSString stringWithFormat:@"有效期至：%@",self.dataDic[@"valid"]];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return 115;
    }
    if (indexPath.section == 1) {
        return 100;
    }
    if (indexPath.section == 2) {
        return 130;
    }
    return 250;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return nil;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return 0.1f;
    }
    return 8;
}

@end
