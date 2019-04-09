//
//  ConverViewCell.m
//  yuyan
//
//  Created by tangfeimu on 2019/4/9.
//  Copyright © 2019 tangfeimu. All rights reserved.
//

#import "ConverViewCell.h"
#import <UIImageView+WebCache.h>
#import "UIView+CornerRadiusLayer.h"

static NSString *ID = @"cell";

@implementation ConverViewCell

+ (instancetype)initWithTableView:(UITableView *)tableView;{
    ConverViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[ConverViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
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
    if (!_image){
        self.image = [UIImageView new];
        [self.contentView addSubview:_image];
        _image.whc_CenterY(0).whc_LeftSpace(16).
        whc_Width(60).whc_Height(60);
        [_image setLayerCornerRadius:4];
        //        _tipImage.backgroundColor = [UIColor redColor];
    }
    if (!_name) {
        _name = [UILabel new];
        [self.contentView addSubview:_name];
        _name.whc_TopSpace(20).whc_LeftSpaceToView(10, _image);
        _name.text = @"测试数据";
        _name.textColor = [UIColor textColorWithType:0];
        _name.font = FontSize(16);
    }
    if (!_tip) {
        _tip = [UIImageView new];
        [self.contentView addSubview:_tip];
        _tip.whc_LeftSpaceToView(10, _image).whc_TopSpaceToView(10, _name).whc_Width(12).whc_Height(14);
        _tip.image = [UIImage imageNamed:@"map_icon"];
    }
    if (!_time) {
        _time = [UILabel new];
        [self.contentView addSubview:_time];
        _time.whc_TopSpaceToView(10, _name).whc_LeftSpaceToView(5, _tip);
        _time.textColor = [UIColor textColorWithType:1];
        _time.text = @"杭州市滨江区长河街道466号";
        _time.font = FontSize(12);
    }
    if (!_line) {
        _line = [UILabel new];
        [self.contentView addSubview:_line];
        _line.whc_LeftSpace(16).whc_RightSpace(16).
        whc_BottomSpace(0).whc_Height(0.5);
        _line.backgroundColor = [UIColor colorWithHexString:@"#eeeeee"];
    }
}
- (void)setValueForCell:(RecordModel *)model;{
    _name.text = model.title;
    _time.text = [NSString stringWithFormat:@"有效期至：%@",model.valid_date];
    [_image sd_setImageWithURL:[NSURL URLWithString:model.thumb]];
   
}

@end
