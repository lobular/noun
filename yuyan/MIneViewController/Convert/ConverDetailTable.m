//
//  ConverDetailTable.m
//  yuyan
//
//  Created by tangfeimu on 2019/4/10.
//  Copyright © 2019 tangfeimu. All rights reserved.
//

#import "ConverDetailTable.h"
#import "ConverHeaderViewCell.h"
#import "ConverViewCell.h"
#import "UIView+CornerRadiusLayer.h"
#import <UIImageView+WebCache.h>

@implementation ConverGoods

+ (instancetype)initWithTable:(UITableView *)table;{
    ConverGoods *cell = [table dequeueReusableCellWithIdentifier:@"goods"];
    if (!cell) {
        cell = [[ConverGoods alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"goods"];
    }
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self config];
    }
    return self;
}

- (void)config{
    if (!_tip) {
        _tip = [UILabel new];
        [self.contentView addSubview:_tip];
        _tip.whc_CenterY(0).whc_LeftSpace(16);
        _tip.textColor = [UIColor textColorWithType:0];
        _tip.font = FontSize(16);
        _tip.text = @"商品金额";
    }
    if (!_amount) {
        _amount = [UILabel new];
        [self.contentView addSubview:_amount];
        _amount.whc_CenterY(0).whc_RightSpace(16);
        _amount.textColor = [UIColor colorWithHexString:@"#FD6D08"];
        _amount.font = FontSize(16);
    }
    if (!_line) {
        _line = [UILabel new];
        [self.contentView addSubview:_line];
        _line.whc_LeftSpace(16).whc_BottomSpace(0).whc_RightSpace(0).whc_Height(0.5);
        _line.backgroundColor = [UIColor colorWithHexString:@"#eeeeee"];
    }
}
@end

@implementation ConverInfoCell

+ (instancetype)initWithTable:(UITableView *)table;{
    ConverInfoCell *cell = [table dequeueReusableCellWithIdentifier:@"info"];
    if (!cell) {
        cell = [[ConverInfoCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"info"];
    }
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self config];
    }
    return self;
}

- (void)config{
    if (!_tip) {
        _tip = [UILabel new];
        [self.contentView addSubview:_tip];
        _tip.whc_TopSpace(20).whc_LeftSpace(16);
        _tip.textColor = [UIColor textColorWithType:0];
        _tip.font = FontSize(16);
    }
    if (!_time) {
        _time = [UILabel new];
        [self.contentView addSubview:_time];
        _time.whc_TopSpaceToView(10, _tip).whc_LeftSpace(16);
        _time.textColor = [UIColor textColorWithType:0];
        _time.font = FontSize(16);
    }
}
@end

@implementation ConverBtn

+ (instancetype)initWithTable:(UITableView *)table;{
    ConverBtn *cell = [table dequeueReusableCellWithIdentifier:@"sub"];
    if (!cell) {
        cell = [[ConverBtn alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"sub"];
    }
    return cell;
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self config];
    }
    return self;
}

- (void)config{
    if (!_subBtn) {
        _subBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.contentView addSubview:_subBtn];
        _subBtn.whc_TopSpace(32).whc_LeftSpace(20).whc_RightSpace(20).whc_Height(44);
        [_subBtn setTitle:@"去使用" forState:UIControlStateNormal];
        [_subBtn setTitleColor:[UIColor textColorWithType:0] forState:UIControlStateNormal];
        _subBtn.backgroundColor = [UIColor colorWithHexString:@"#FFE656"];
        [_subBtn setLayerCornerRadius:22];
        
    }
}

@end

@interface ConverDetailTable ()<UITableViewDelegate,UITableViewDataSource>

@end


@implementation ConverDetailTable

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style{
    if (self = [super initWithFrame:frame style:style]) {
        self.delegate = self;
        self.dataSource = self;
        self.separatorStyle = UITableViewCellSelectionStyleNone;
        [self registerClass:ConverHeaderViewCell.class forCellReuseIdentifier:@"header"];
        [self registerClass:ConverViewCell.class forCellReuseIdentifier:@"conver"];
        [self registerClass:ConverGoods.class forCellReuseIdentifier:@"goods"];
        [self registerClass:ConverInfoCell.class forCellReuseIdentifier:@"info"];
        [self registerClass:ConverBtn.class forCellReuseIdentifier:@"sub"];
    }
    return self;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 5;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return section == 2 ? 2 :1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        ConverHeaderViewCell *cell = [ConverHeaderViewCell initWithTableView:tableView];
        return cell;
    }
    if (indexPath.section == 2) {
        ConverGoods *cell = [ConverGoods initWithTable:tableView];
        if (indexPath.row == 1) {
            cell.tip.hidden = YES;
            NSMutableAttributedString *noteStr = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"实付%@信条",self.dic[@"pay_creed"]]];
            NSRange range = NSMakeRange(0,2);
            // 改变字体大小及类型
            [noteStr addAttribute:NSForegroundColorAttributeName value:[UIColor textColorWithType:1] range:range];
            // 为label添加Attributed
            [cell.amount setAttributedText:noteStr];
        }else{
            cell.amount.text = [NSString stringWithFormat:@"%@信条",self.dic[@"creed_price"]];
        }
        return cell;
    }
    if (indexPath.section == 3) {
        ConverInfoCell *cell = [ConverInfoCell initWithTable:tableView];
        cell.tip.text = [NSString stringWithFormat:@"订单编号：%@",self.dic[@"order_no"]];
        cell.time.text = [NSString stringWithFormat:@"订单时间：%@",self.dic[@"create_time_str"]];
        return cell;
    }
    if (indexPath.section == 4) {
        ConverBtn *cell = [ConverBtn initWithTable:tableView];
        return cell;
    }
    ConverViewCell *cell = [ConverViewCell initWithTableView:tableView];
    [cell.image sd_setImageWithURL:[NSURL URLWithString:self.dic[@"thumb"]]];
    cell.name.text = self.dic[@"title"];
    cell.time.text = [NSString stringWithFormat:@"有效期至：%@",self.dic[@"valid_date"]];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return 114;
    }
    if (indexPath.section == 1) {
        return 100;
    }
    if (indexPath.section == 2) {
        return 54;
    }
    if (indexPath.section == 3) {
        return 95;
    }
    return 160;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return nil;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section != 0) {
        return 8.0f;
    }
    return 0.1;
}


@end
