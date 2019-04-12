//
//  ConverHeaderViewCell.m
//  yuyan
//
//  Created by tangfeimu on 2019/4/10.
//  Copyright © 2019 tangfeimu. All rights reserved.
//

#import "ConverHeaderViewCell.h"

static NSString *ID = @"header";

@interface ConverHeaderViewCell ()

@property (nonatomic,strong)UIImageView *image;


@end

@implementation ConverHeaderViewCell

+ (instancetype)initWithTableView:(UITableView *)tableView;{
    ConverHeaderViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[ConverHeaderViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
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
    if (!_image) {
        _image = [UIImageView new];
        [self.contentView addSubview:_image];
        _image.whc_CenterY(0).whc_LeftSpace(128 *ScaleWidth).whc_Width(32).whc_Height(32);
        _image.image = [UIImage imageNamed:@"success_icon"];
    }
    if (!_tip) {
        _tip = [UILabel new];
        [self.contentView addSubview:_tip];
        _tip.whc_CenterY(0).whc_LeftSpaceToView(5, _image);
        _tip.text = @"交易成功";
        _tip.textColor = [UIColor textColorWithType:0];
        _tip.font = FontSize(20);
    }
}

@end
