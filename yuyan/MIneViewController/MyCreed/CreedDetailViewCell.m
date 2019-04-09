//
//  CreedDetailViewCell.m
//  yuyan
//
//  Created by tangfeimu on 2019/4/9.
//  Copyright © 2019 tangfeimu. All rights reserved.
//

#import "CreedDetailViewCell.h"

static NSString *ID = @"cell";

@implementation CreedDetailViewCell

+ (instancetype)initWithTableView:(UITableView *)tableView;{
    CreedDetailViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[CreedDetailViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
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
    if (!_name) {
        _name = [UILabel new];
        [self.contentView addSubview:_name];
        _name.whc_TopSpace(12).whc_LeftSpace(16);
        _name.textColor = [UIColor textColorWithType:0];
        _name.font = [UIFont systemFontOfSize:16];
        _name.textAlignment = NSTextAlignmentCenter;
    }
    if (!_time) {
        _time = [UILabel new];
        _time.text = @"2018-09-22  18:00";
        [self.contentView addSubview:_time];
        _time.whc_TopSpaceToView(4, _name).whc_LeftSpace(16);
        _time.textColor = [UIColor colorWithHexString:@"#999999"];
        _time.font = [UIFont systemFontOfSize:12];
        _time.textAlignment = NSTextAlignmentCenter;
    }
    if (!_score) {
        _score = [UILabel new];
        [self.contentView addSubview:_score];
        _score.whc_CenterY(0).whc_RightSpace(16);
        _score.textColor = [UIColor colorWithHexString:@"#45B973"];
        _score.font = [UIFont systemFontOfSize:12];
        _score.textAlignment = NSTextAlignmentCenter;
    }
    if (!_line) {
        _line = [UILabel new];
        [self.contentView addSubview:_line];
        _line.whc_BottomSpace(0).whc_LeftSpace(16).whc_RightSpace(16).whc_Height(0.5);
        _line.backgroundColor = [UIColor colorWithHexString:@"#eeeeee"];
    }
}

- (void)setValueForCell:(MineModel *)model;{
    _name.text = model.note;
    _time.text = model.time;
    _score.text = model.desc;
    if ([model.opt isEqualToString:@"+"]) {
        _score.textColor = [UIColor colorWithHexString:@"#FD6D08"];
    }else{
        _score.textColor = [UIColor colorWithHexString:@"#45B973"];
    }
}

@end
