//
//  CreedHeaderViewCell.m
//  yuyan
//
//  Created by tangfeimu on 2019/4/9.
//  Copyright © 2019 tangfeimu. All rights reserved.
//

#import "CreedHeaderViewCell.h"

static NSString *ID = @"cell";

@implementation CreedHeaderViewCell

+ (instancetype)initWithTableView:(UITableView *)tableView;{
    CreedHeaderViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[CreedHeaderViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self config];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.contentView.backgroundColor = [UIColor colorWithHexString:@"#FFE656"];
    }
    return self;
}

- (void)config{
    if (!_score) {
        _score = [UILabel new];
        [self.contentView addSubview:_score];
        _score.whc_CenterX(0).whc_TopSpace(30);
        _score.textColor = [UIColor textColorWithType:0];
        _score.font = FontSize(40);
    }
    if (!_tip) {
        _tip = [UILabel new];
        [self.contentView addSubview:_tip];
        _tip.whc_CenterYToView(0, _score).whc_LeftSpaceToView(0, _score);
        _tip.textColor = [UIColor colorWithHexString:@"#000000"];
        _tip.font = FontSize(12);
    }
    if (!_total) {
        _total = [UILabel new];
        [self.contentView addSubview:_total];
        _total.whc_CenterX(0).whc_TopSpaceToView(0, _score);
        _total.text = @"总积分";
        _total.font = FontSize(15);
        _total.textColor = [UIColor colorWithHexString:@"#333333"];
    }
}

@end
